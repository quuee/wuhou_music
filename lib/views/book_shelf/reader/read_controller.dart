import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/model/book_novel/book_chapter_entity.dart';
import 'package:wuhoumusic/model/book_novel/book_novel_entity.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/book_shelf/reader/text_composition/text_compsition_effect.dart';

class ReadController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // 当前书本
  BookNovelEntity? bookNovel;

  // 当前书本所有章节
  List<BookChapterEntity> chapters = [];

  // 当前阅读章节分段数据
  List<String> currentChapterParagraph = [];

  // 当前章节索引
  int currentChapterIndex = 0;

  // 多个 每一页内容
  List<TextPage> textPages = <TextPage>[];

  ui.Image? _backgroundImage;
  ui.Image? get backgroundImage => _backgroundImage;

  String animation = 'curl';
  late AnimationController animationController;

  /// 获取书本信息
  _getBookNovelInfo() {
    File file = File(bookNovel!.localPath);
    bool exist = file.existsSync();
    if (!exist) {
      return;
    }
    // RandomAccessFile重写小说阅读
    List<int> buffer = List.generate(128 * 1024, (index) => 0);
    int curOffset = 0; // 文件游标位置
    int chapterIndex = 0; // 第几章
    int readLength = 0; // 读取长度

    // 0 定义章节模型，定义每页数据模型
    // 1 判断是否存在章节，有则取出章节
    // 2 分章节内容，跳过章节长度，取出内容
    RandomAccessFile randomAccessFile = file.openSync();
    while ((readLength =
            randomAccessFile.readIntoSync(buffer, 0, buffer.length)) >
        0) {
      ++chapterIndex;

      String chapterContent = "";
      try {
        // todo 默认按utf8读取，如果读取gbk编码会FileSystemException CodeConvertUtil.gbk2utf8(readBytes)转码

        // allowMalformed: true 避免数据拆包后无法转码，但是截取处个别字乱码
        chapterContent = utf8.decode(buffer.sublist(0, readLength),
            allowMalformed: true); // 当前章节内容  Unfinished UTF-8 octet sequence问题
      } on FormatException catch (e) {
        LogE('utf8拆包错误', e.message);
      }
      // chapterContent.replaceAll(RegExp('(PS|ps)(.)*(|\\n)'), '');
      // 匹配规则
      // "(第)([0-9零一二两三四五六七八九十百千万壹贰叁肆伍陆柒捌玖拾佰仟]{1,10})([章节回集卷])(.*)"
      RegExp pest = RegExp(
          '(正文){0,1}(\\s|\\n)(第)([\\u4e00-\\u9fa5a-zA-Z0-9]{1,7})[章][^\\n]{1,35}(|\\n)');

      int seekPositionBytes = 0; // 当前章节位置 bytes，因为读取的是字节数组，后面获取章节内容需要数组的位置
      int seekPositionString = 0; // 当前章节位置 字符串
      // 匹配章节
      Iterable<RegExpMatch> allMatches = pest.allMatches(chapterContent);
      //如果存在章节（符合正则匹配），则具体分章；否则创建虚拟章节
      for (int i = 0; i < allMatches.length; i++) {
        int chapterStart = allMatches.elementAt(i).start;
        String chapterContentSubFront = chapterContent.substring(
            seekPositionString, chapterStart); // 截取章节前部内容

        if (seekPositionBytes == 0 && chapterStart != 0) {
          //表示 章节处于中间
          seekPositionBytes +=
              utf8.encode(chapterContentSubFront).length; //设置指针偏移
          seekPositionString += chapterContentSubFront.length; //临时偏移量
          if (curOffset == 0) {
            // 说明有序章
            BookChapterEntity preChapter = BookChapterEntity(
                bookId: bookNovel!.id!,
                chapterIndex: chapterIndex,
                chapterTitle: "序章",
                start: 0,
                end: utf8.encode(chapterContentSubFront).length,
                content: chapterContentSubFront);
            chapters.add(preChapter);

            BookChapterEntity curChapter = BookChapterEntity(
                bookId: bookNovel!.id!,
                chapterIndex: chapterIndex,
                chapterTitle: allMatches.elementAt(i).group(0).toString(),
                start: preChapter.end);
            chapters.add(curChapter);
          } else {
            // 将当前段落添加到上一章中
            BookChapterEntity lastChapter = chapters[chapters.length - 1];
            lastChapter.end = (lastChapter.end ?? 0) +
                utf8.encode(chapterContentSubFront).length;
            lastChapter.content =
                (lastChapter.content ?? "") + chapterContentSubFront;

            BookChapterEntity curChapter = BookChapterEntity(
                bookId: bookNovel!.id!,
                chapterIndex: chapterIndex,
                chapterTitle: allMatches.elementAt(i).group(0).toString(),
                start: lastChapter.end);
            chapters.add(curChapter);
          }
        } else {
          if (chapters.isNotEmpty) {
            seekPositionBytes +=
                utf8.encode(chapterContentSubFront).length; //设置指针偏移
            seekPositionString += chapterContentSubFront.length; //临时偏移量
            BookChapterEntity lastChapter = chapters[chapters.length - 1];
            lastChapter.end = (lastChapter.end ?? 0) +
                utf8.encode(chapterContentSubFront).length;
            lastChapter.content =
                (lastChapter.content ?? "") + chapterContentSubFront;

            BookChapterEntity curChapter = BookChapterEntity(
                bookId: bookNovel!.id!,
                chapterIndex: chapterIndex,
                chapterTitle: allMatches.elementAt(i).group(0).toString(),
                start: lastChapter.end);
            chapters.add(curChapter);
          } else {
            BookChapterEntity curChapter = BookChapterEntity(
                bookId: bookNovel!.id!,
                chapterIndex: chapterIndex,
                chapterTitle: allMatches.elementAt(i).group(0).toString(),
                start: 0);
            chapters.add(curChapter);
          }
        }
      }

      // TODO 没有匹配则进行虚拟分章

      curOffset += readLength;
      // 如果有正则章节
      BookChapterEntity lastChapter = chapters[chapters.length - 1];
      lastChapter.end = curOffset;
    }

    randomAccessFile.closeSync();
  }

  /// 获取该章节内容
  List<int> _getChapterContent(BookChapterEntity chapterEntity) {
    File file = File(bookNovel!.localPath);
    RandomAccessFile randomAccessFile = file.openSync();
    randomAccessFile.setPositionSync(chapterEntity.start ?? 0);

    int extent = (chapterEntity.end ?? 0) - (chapterEntity.start ?? 0);
    List<int> b = randomAccessFile.readSync(extent);
    randomAccessFile.closeSync();
    return b;
  }

  /// 获取当前阅读章节，并且分割
  _getCurrentReadChapter() {
    List<int> chapterContentBytes =
        _getChapterContent(chapters[currentChapterIndex]);
    String chapterContent =
        utf8.decode(chapterContentBytes, allowMalformed: true);
    currentChapterParagraph = chapterContent
        .replaceAll(RegExp("<br\\s?/>\\n?"), "\n")
        .replaceAll("&nbsp;", " ")
        .replaceAll("&ldquo;", "“")
        .replaceAll("&rdquo;", "”")
        .replaceAll('\r\n', '\n')
        .replaceAll('\n\n', '\n')
        .trim()
        .split("\n")
        .where((e) => e.isNotEmpty)
        // .map((e) => "[开始${++_paragraph}]$e[结束$_paragraph]")
        .toList();

    update();
  }

  Future<void> _getBackImage() async {
    try {
      final background = '#FFFFFFCC';
      final size =
          WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
              WidgetsBinding
                  .instance.platformDispatcher.views.first.devicePixelRatio;
      if (background.isEmpty || background == 'null') {
        _backgroundImage = null;
        return;
      } else if (background.startsWith("asset")) {
        final data = await rootBundle.load(background);
        ui.Codec codec = await ui.instantiateImageCodec(
            data.buffer.asUint8List(),
            targetWidth: size.width.round(),
            targetHeight: size.height.round());
        ui.FrameInfo fi = await codec.getNextFrame();
        _backgroundImage = fi.image;
      } else {
        final data = await File(background).readAsBytes();
        ui.Codec codec = await ui.instantiateImageCodec(data,
            targetWidth: size.width.round(), targetHeight: size.height.round());
        ui.FrameInfo fi = await codec.getNextFrame();
        _backgroundImage = fi.image;
      }
    } catch (e) {}
  }

  ui.Picture? getPicture(int index, Size size) {
    final textPage = textPages[index];
    final pic = ui.PictureRecorder();
    final c = Canvas(pic);
    final pageRect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    c.drawRect(pageRect, Paint()..color = Color(0xFFFFFFCC));
    if (_backgroundImage != null)
      c.drawImage(_backgroundImage!, Offset.zero, Paint());
    paintText(c, size, textPage);
    return pic.endRecording();
  }

  paintText(ui.Canvas canvas, ui.Size size, TextPage page) {
    double fontSize = 20;
    double fontHeight = 1.6;
    Color fontColor = const Color(0xFF303133);

    final lineCount = page.lines.length;
    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize + 2,
      // fontFamily: config.fontFamily,
      color: fontColor,
      height: fontHeight,
    );
    final style = TextStyle(
      fontSize: fontSize,
      // fontFamily: config.fontFamily,
      color: fontColor,
      height: fontHeight,
    );
    final _lineHeight = fontSize * fontHeight;
    for (var i = 0; i < lineCount; i++) {
      final line = page.lines[i];
      if (line.letterSpacing != null &&
          (line.letterSpacing! < -0.1 || line.letterSpacing! > 0.1)) {
        tp.text = TextSpan(
          text: line.text,
          style: line.isTitle
              ? TextStyle(
                  letterSpacing: line.letterSpacing,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize + 2,
                  // fontFamily: config.fontFamily,
                  color: fontColor,
                  height: fontHeight,
                )
              : TextStyle(
                  letterSpacing: line.letterSpacing,
                  fontSize: fontSize,
                  // fontFamily: fontFamily,
                  color: fontColor,
                  height: fontHeight,
                ),
        );
      } else {
        tp.text =
            TextSpan(text: line.text, style: line.isTitle ? titleStyle : style);
      }
      final offset = Offset(line.dx, line.dy);
      tp.layout();
      tp.paint(canvas, offset);

      //underline
      canvas.drawLine(
          Offset(line.dx, line.dy + _lineHeight),
          Offset(line.dx + page.column, line.dy + _lineHeight),
          Paint()..color = Colors.grey);
    }
  }

  List<Widget> getPageWidget([int pageIndex = 0]) {
    return [
      for (; pageIndex <= textPages.length; pageIndex++)

          CustomPaint(
              painter: TextCompositionEffect(
            amount: animationController,
            index: pageIndex,
          )
          )

    ];
  }

  /// 构建字体信息 布局信息
  startX(int chapterIndex) {
    double leftPadding = 16;
    double rightPadding = 16;
    double topPadding = 16;
    double columnPadding = 30;

    double fontSize = 20;
    double fontHeight = 1.6;
    Color fontColor = Color(0xFF303133);
    double bottomPadding = 16;

    /// 是否底栏对齐
    bool shouldJustifyHeight = true;

    final pages = <TextPage>[];
    final size = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    // final columns = config.columns > 0 ? config.columns : size.width > 580 ? 2 : 1;
    final columns = 1;
    final _width = (size.width -
            leftPadding -
            rightPadding -
            (columns - 1) * columnPadding) /
        columns;
    final _width2 = _width - fontSize;
    final _height = size.height - bottomPadding;
    final _height2 = _height - fontSize * fontHeight;

    final tp = TextPainter(textDirection: TextDirection.ltr, maxLines: 1);
    final offset = Offset(_width, 1);
    final _dx = leftPadding;
    final _dy = topPadding;

    var lines = <TextLine>[];
    var columnNum = 1;
    var dx = _dx;
    var dy = _dy;
    var startLine = 0;

    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize + 2,
      // fontFamily: config.fontFamily,
      color: fontColor,
      height: fontHeight,
    );
    final style = TextStyle(
      fontSize: fontSize,
      // fontFamily: config.fontFamily,
      color: fontColor,
      height: fontHeight,
    );

    var _t = chapters[chapterIndex].chapterTitle;
    while (true) {
      tp.text = TextSpan(text: _t, style: titleStyle);
      tp.layout(maxWidth: _width);
      final textCount = tp.getPositionForOffset(offset).offset;
      final text = _t.substring(0, textCount);
      double? spacing;
      if (tp.width > _width2) {
        tp.text = TextSpan(text: text, style: titleStyle);
        tp.layout();
        double _spacing = (_width - tp.width) / textCount;
        if (_spacing < -0.1 || _spacing > 0.1) {
          spacing = _spacing;
        }
      }
      lines.add(TextLine(text, dx, dy, spacing, true));
      dy += tp.height;
      if (_t.length == textCount) {
        break;
      } else {
        _t = _t.substring(textCount);
      }
    }
    dy += 30; // + titlePadding

    var pageIndex = 1;

    /// 下一页 判断分页 依据: `_boxHeight` `_boxHeight2`是否可以容纳下一行
    void newPage([bool shouldJustifyHeight = true, bool lastPage = false]) {
      if (shouldJustifyHeight && shouldJustifyHeight) {
        final len = lines.length - startLine;
        double justify = (_height - dy) / (len - 1);
        for (var i = 0; i < len; i++) {
          lines[i + startLine].justifyDy(justify * i);
        }
      }
      if (columnNum == columns || lastPage) {
        pages.add(TextPage(
          lines: lines,
          height: dy,
          pageNo: pageIndex++,
          chIndex: chapterIndex,
          column: _width,
        ));
        lines = <TextLine>[];
        columnNum = 1;
        dx = _dx;
      } else {
        columnNum++;
        dx += _width + columnPadding;
      }
      dy = _dy;
      startLine = lines.length;
    }

    for (var p in currentChapterParagraph) {
      p = "  " * 2 + p; // 段落前加两空格
      while (true) {
        tp.text = TextSpan(text: p, style: style);
        tp.layout(maxWidth: _width);
        final textCount = tp.getPositionForOffset(offset).offset;
        double? spacing;
        final text = p.substring(0, textCount);
        if (tp.width > _width2) {
          tp.text = TextSpan(text: text, style: style);
          tp.layout();
          spacing = (_width - tp.width) / textCount;
        }
        lines.add(TextLine(text, dx, dy, spacing));
        dy += tp.height;
        if (p.length == textCount) {
          if (dy > _height2) {
            newPage();
          } else {
            dy += 18; // + paragraphPadding
          }
          break;
        } else {
          p = p.substring(textCount);
          if (dy > _height2) {
            newPage();
          }
        }
      }
    }
    if (lines.isNotEmpty) {
      newPage(false, true);
    }
    if (pages.length == 0) {
      pages.add(TextPage(
        lines: [],
        height: topPadding + bottomPadding,
        pageNo: 1,
        chIndex: chapterIndex,
        column: _width,
      ));
    }

    final basePercent = chapterIndex / chapters.length;
    final total = pages.length;
    pages.forEach((page) {
      page.pageTotal = total;
      page.percent = page.pageNo / pages.length / chapters.length + basePercent;
    });

    return pages;
  }

  @override
  void onInit() {
    LogI('生命周期顺序', 'onInit');
    bookNovel = Get.arguments as BookNovelEntity;
    // 是否有上次阅读记录；没有则从头开始
    currentChapterIndex = bookNovel?.lastReadChapterIndex ?? 0;
    _getBookNovelInfo();
    _getBackImage();

    animationController = AnimationController(
        value: 1, duration: Duration(seconds: 1), vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    LogI('生命周期顺序', 'onReady');
    _getCurrentReadChapter();
    textPages = startX(currentChapterIndex);
    super.onReady();
  }

  @override
  void onClose() {
    // todo 记录阅读位置
    // bookNovel?.lastReadChapterIndex = currentChapterCacheInfo?.chapterIndex;
    // IsarHelper.instance.isarInstance.writeTxnSync(() {
    //   IsarHelper.instance.isarInstance.bookNovelEntitys.putSync(bookNovel!);
    // });
    super.onClose();
  }
}

/// 每一页内容
class TextPage {
  double percent; // 百分比
  int pageNo; // 页数
  int pageTotal; // 总数
  int chIndex; // 第N章
  final double height;
  final double column; // 默认1栏，宽度大于580时分2栏。如果横屏就没必要
  final List<TextLine> lines;

  TextPage({
    this.percent = 0.0,
    this.pageTotal = 1,
    this.chIndex = 0,
    required this.column,
    required this.pageNo,
    required this.height,
    required this.lines,
  });
}

class TextLine {
  final String text;
  double dx;
  double _dy;
  double get dy => _dy;
  final double? letterSpacing;
  final bool isTitle;
  TextLine(
    this.text,
    this.dx,
    double dy, [
    this.letterSpacing = 0,
    this.isTitle = false,
  ]) : _dy = dy;

  justifyDy(double offsetDy) {
    _dy += offsetDy;
  }
}