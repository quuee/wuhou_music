import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/book_novel/book_chapter_entity.dart';
import 'package:wuhoumusic/model/book_novel/book_novel_entity.dart';
import 'package:wuhoumusic/model/book_novel/read_config_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/book_shelf/code_convert/code_convert.dart';
import 'package:wuhoumusic/views/book_shelf/reader/text_composition/simple_text_painter.dart';

class ReadController extends GetxController with GetTickerProviderStateMixin {
  LoadingStatus _loadingStatus = LoadingStatus.loading;
  get loadingStatus => _loadingStatus;
  // 当前书本
  BookNovelEntity? bookNovel;
  // 当前书本所有章节
  List<BookChapterEntity> chapters = [];

  // 当前章节索引
  late int firstChapterIndex, currentChapterIndex, lastChapterIndex;

  // 一个章节中 每一页内容
  List<TextPage> textPages = <TextPage>[];
  // 预加载下一章内容
  List<TextPage> nextTextPages = <TextPage>[];
  // 章节页数
  int pageIndex = 0;

  ReadConfigEntity? readConfigEntity;

  // 书页背景
  late String background;
  late int fontColor;
  ui.Image? _backgroundImage;
  ui.Image? get backgroundImage => _backgroundImage;

  /// 获取背景图片
  _getBackImage(String background) async {
    try {
      if (background.isEmpty || background == 'null') {
        _backgroundImage = null;
        return;
      } else if (background.startsWith("assets")) {
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

  updateBackground(Map<String, int> backgroundAndFontColor) async {
    background = backgroundAndFontColor.keys.first;
    fontColor = backgroundAndFontColor.values.first;
    await _getBackImage(background);
    update();
  }

  // 菜单动画
  bool menuShowStatus = false; //在菜单栏弹出时 状态判断
  late AnimationController menuAnimationController;
  late Animation<Offset> menuTopAnimationProgress;
  late Animation<Offset> menuBottomAnimationProgress;

  var size = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  /// 是否剪辑A区画面
  RxBool isAlPath = RxBool(true); //使用setState不会抖,用obx会抖; 必须整个页面刷新才不会抖。

  updateAlPath(bool val) {
    isAlPath.value = val;
    update();
  }

  late TextEditingController fontSizeController; // 字号
  late TextEditingController fontHeightController; // 间距

  updateFontSizeOrFontHeight(double fontSize, double fontHeight) {
    if (fontSize > 0) {
      fontSizeController.text = fontSize.toString();
    }
    if (fontHeight > 0) {
      fontHeightController.text = fontHeight.toString();
    }

    _loadLastReadChapter();
  }

  /// 获取书本信息 并且分章节
  Future<List<BookChapterEntity>> _getBookNovelInfo() async {
    File file = File(bookNovel!.localPath);
    bool exist = file.existsSync();
    if (!exist) {
      return Future.value([]);
    }
    // String fileCharsetName = CodeConvertUtil.getFileCharsetName(file);
    String fileCharsetName = 'UTF-8';
    List<BookChapterEntity> tempChapters = [];
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
      String chapterContent = "";

      switch (fileCharsetName) {
        case 'GBK':
          chapterContent =
              CodeConvertUtil.gbk2utf8(buffer.sublist(0, readLength));
          break;
        case 'UTF-8':
          chapterContent =
              utf8.decode(buffer.sublist(0, readLength), allowMalformed: true);
          break;
      }

      // try {
      //   // 默认按utf8读取，如果读取gbk编码会FileSystemException CodeConvertUtil.gbk2utf8(readBytes)转码
      //   // allowMalformed: true 避免数据拆包后无法转码，但是截取处个别字乱码
      //    // 当前章节内容  Unfinished UTF-8 octet sequence问题
      // } on FormatException catch (e) {
      //   LogE('utf8拆包错误', e.message);
      // } on FileSystemException catch (e) {
      //    LogE('解码错误，尝试GBK解码', e.message);
      // }

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
      if (allMatches.isNotEmpty) {
        for (int i = 0; i < allMatches.length; i++) {
          chapterIndex++; // 其实这里分章节也不是太准，但一般字数不多的情况可以用
          int chapterStart = allMatches.elementAt(i).start;
          String chapterContentSubFront = chapterContent.substring(
              seekPositionString, chapterStart); // 截取章节前部内容

          if (seekPositionBytes == 0 && chapterStart != 0) {
            //表示 章节处于中间
            seekPositionBytes +=
                utf8.encode(chapterContentSubFront).length; //设置字节指针偏移
            seekPositionString += chapterContentSubFront.length; //字符串偏移量
            if (curOffset == 0) {
              // 说明有序章
              BookChapterEntity preChapter = BookChapterEntity(
                bookId: bookNovel!.id!,
                chapterIndex: chapterIndex,
                chapterTitle: "序章",
                start: 0,
                end: utf8.encode(chapterContentSubFront).length,
              );
              tempChapters.add(preChapter);

              BookChapterEntity curChapter = BookChapterEntity(
                  bookId: bookNovel!.id!,
                  chapterIndex: chapterIndex,
                  chapterTitle: allMatches.elementAt(i).group(0).toString(),
                  start: preChapter.end);
              tempChapters.add(curChapter);
            } else {
              // 将当前段落添加到上一章中
              BookChapterEntity lastChapter =
                  tempChapters[tempChapters.length - 1];
              lastChapter.end = (lastChapter.end ?? 0) +
                  utf8.encode(chapterContentSubFront).length;
              // lastChapter.content =
              //     (lastChapter.content ?? "") + chapterContentSubFront;

              BookChapterEntity curChapter = BookChapterEntity(
                  bookId: bookNovel!.id!,
                  chapterIndex: chapterIndex,
                  chapterTitle: allMatches.elementAt(i).group(0).toString(),
                  start: lastChapter.end);
              tempChapters.add(curChapter);
            }
          } else {
            if (tempChapters.isNotEmpty) {
              seekPositionBytes +=
                  utf8.encode(chapterContentSubFront).length; //设置字节指针偏移
              seekPositionString += chapterContentSubFront.length; //字符串偏移量
              BookChapterEntity lastChapter =
                  tempChapters[tempChapters.length - 1];
              lastChapter.end = (lastChapter.start ?? 0) +
                  utf8.encode(chapterContentSubFront).length;
              // lastChapter.content =
              //     (lastChapter.content ?? "") + chapterContentSubFront;

              BookChapterEntity curChapter = BookChapterEntity(
                  bookId: bookNovel!.id!,
                  chapterIndex: chapterIndex,
                  chapterTitle: allMatches.elementAt(i).group(0).toString(),
                  start: lastChapter.end);
              tempChapters.add(curChapter);
            } else {
              BookChapterEntity curChapter = BookChapterEntity(
                  bookId: bookNovel!.id!,
                  chapterIndex: chapterIndex,
                  chapterTitle: allMatches.elementAt(i).group(0).toString(),
                  start: 0);
              tempChapters.add(curChapter);
            }
          }
        }

      } else {
        // 没有匹配章节目录则进行虚拟分章
        //章节在buffer的偏移量
        int chapterOffset = 0;
        //当前剩余可分配的长度
        int strLength = readLength;

        while (strLength > 0) {
          ++chapterIndex;
          if (strLength > 16 * 1024) {
            //是否长度超过一章
            //在buffer中一章的终止点
            int end = readLength;
            //寻找换行符作为终止点
            for (int i = chapterOffset + 16 * 1024; i < readLength; ++i) {
              if (buffer[i] == CharCode.LF) {
                end = i;
                break;
              }
            }
            BookChapterEntity chapterEntity = BookChapterEntity(
                bookId: bookNovel!.id!,
                chapterIndex: chapterIndex,
                chapterTitle: '虚拟章节 第' + chapterIndex.toString() + '章',
                start: curOffset + chapterOffset + 1,
                end: curOffset + end);
            tempChapters.add(chapterEntity);
            //减去已经被分配的长度
            strLength = strLength - (end - chapterOffset);
            //设置偏移的位置
            chapterOffset = end;
          } else {
            BookChapterEntity chapterEntity = BookChapterEntity(
                bookId: bookNovel!.id!,
                chapterIndex: chapterIndex,
                chapterTitle: '虚拟章节 第' + chapterIndex.toString() + '章',
                start: curOffset + chapterOffset + 1,
                end: curOffset + readLength);
            tempChapters.add(chapterEntity);
            strLength = 0;
          }
        }
      }

      curOffset += readLength;
      // 如果是符合正则章节，这里直接加了
      BookChapterEntity lastChapter = tempChapters[tempChapters.length - 1];
      lastChapter.end = curOffset;

    }
    randomAccessFile.closeSync();
    return Future.value(tempChapters);
  }

  /// 获取该章节内容
  List<int> _getChapterBytes(BookChapterEntity chapterEntity) {
    File file = File(bookNovel!.localPath);
    RandomAccessFile randomAccessFile = file.openSync();
    randomAccessFile.setPositionSync(chapterEntity.start ?? 0);

    int extent = (chapterEntity.end ?? 0) - (chapterEntity.start ?? 0);
    List<int> b = randomAccessFile.readSync(extent);
    randomAccessFile.closeSync();
    return b;
  }

  /// 获取当前阅读章节，并且分割
  List<String> _bytes2String(List<int> bytes) {
    String chapterContent = utf8.decode(bytes, allowMalformed: true);
    // 当前阅读章节分段数据
    List<String> currentChapterParagraph = chapterContent
        .replaceAll(RegExp("<br\\s?/>\\n?"), "\n")
        .replaceAll("&nbsp;", " ")
        .replaceAll("&ldquo;", "“")
        .replaceAll("&rdquo;", "”")
        .replaceAll('\r', '\n')
        .replaceAll('\r\n', '\n')
        .replaceAll('\n\n', '\n')
        .trim()
        .split("\n")
        .where((e) => e.isNotEmpty)
        // .map((e) => "[开始${++_paragraph}]$e[结束$_paragraph]")
        .toList();

    return currentChapterParagraph;
  }

  /// 构建字体信息 布局信息  分页。 改成异步
  Future<List<TextPage>> _startX(int chapterIndex) async {
    LogD('_startX start', DateTime.now().toString());
    double leftPadding = 16;
    double rightPadding = 16;
    double topPadding = WidgetsBinding
            .instance.platformDispatcher.views.first.padding.top /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    double columnPadding = 20;

    double fontSize = double.parse(fontSizeController.value.text);
    double fontHeight = double.parse(fontHeightController.value.text);
    Color fontColor = Color(0xFF303133);
    double bottomPadding = 16 + 16;

    var getChapterBytes = _getChapterBytes(chapters[chapterIndex]);
    List<String> currentChapterParagraph = _bytes2String(getChapterBytes);

    final pages = <TextPage>[];
    // final columns = config.columns > 0 ? config.columns : size.width > 580 ? 2 : 1;
    final columns = 1;
    final _width = (size.width -
            leftPadding -
            rightPadding -
            (columns - 1) * columnPadding) /
        columns;
    // final _width2 = _width - fontSize;
    final _width2 = _width;
    final _height = size.height - bottomPadding;
    // final _height2 = _height - fontSize * fontHeight;
    final _height2 = _height;

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

    var _t = chapters[chapterIndex]
        .chapterTitle
        .replaceAll('\r', '')
        .replaceAll('\n', '');
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

    /// 是否底栏对齐
    bool shouldJustifyHeight = true;
    bool configJustifyHeight = true; // 用户配置
    /// 下一页 判断分页 依据: `_boxHeight` `_boxHeight2`是否可以容纳下一行
    void newPage([bool shouldJustifyHeight = true, bool lastPage = false]) {
      if (shouldJustifyHeight && configJustifyHeight ) {
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
        if(textCount <= 0){
          break;
        }
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
            dy += 10; // 段间距 paragraphPadding = 18
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
    for (int j = 0; j < pages.length; j++) {
      pages[j].pageTotal = total;
      pages[j].percent =
          pages[j].pageNo / pages.length / chapters.length + basePercent;
      // 页面最底下 显示当前章节名称
      pages[j].lines.add(TextLine(
          chapters[chapterIndex]
              .chapterTitle
              .replaceAll('\n', '')
              .replaceAll('\r', ''),
          dx,
          size.height - bottomPadding));
    }

    LogD('_startX end', DateTime.now().toString());
    return Future.value(pages);
  }

  Widget getPageWidget(int pageIndex) {
    return Container(
      child: CustomPaint(
        painter: SimpleTextPainter(
            textPage: textPages[pageIndex],
            pageIndex: pageIndex,
            backgroundImage: backgroundImage,
            fontSize: double.parse(fontSizeController.value.text),
            fontHeight: double.parse(fontHeightController.value.text),
            fontColor: Color(fontColor)),
      ),
    );
  }

  /// 用于展示翻页时 最后一页 至 下一章第一页
  Widget getNextPageWidget() {
    if (nextTextPages.isEmpty) {
      // 最后一章
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('已读完')],
        ),
        color: Colors.black45,
      );
    } else {
      return CustomPaint(
        painter: SimpleTextPainter(
            textPage: nextTextPages[0],
            pageIndex: 0,
            backgroundImage: backgroundImage,
            fontSize: double.parse(fontSizeController.value.text),
            fontHeight: double.parse(fontHeightController.value.text),
            fontColor: Color(fontColor)),
      );
    }
  }

  previousPage() {
    LogD('上一页', 'previousPage:$pageIndex');
    if (pageIndex <= 0) {
      _previousChapter();
    } else {
      pageIndex--;
    }
    update();
  }

  nextPage() {
    LogD('下一页', 'nextPage:$pageIndex');
    //检查是否该章最后一页了，如果是最后一页滑动则nextChapter
    //检查是否全书最后一页
    //检查是否有下一页
    if (pageIndex >= textPages.length - 1) {
      //进入下一章
      _nextChapter();
    } else {
      pageIndex++;
    }
    update();
  }

  gotoPage(int gotoPageIndex) {
    pageIndex = gotoPageIndex;
    bookNovel?.lastReadChapterOffset = pageIndex;
    update();
  }

  gotoChapter(int chapterIndex) {
    currentChapterIndex = chapterIndex - 1;
    _nextChapter();
    update();
  }

  _previousChapter() async {
    LogD('上一章', 'currentChapterIndex:$currentChapterIndex');
    if (currentChapterIndex <= 0) {
      currentChapterIndex = 0;
    } else {
      textPages.clear();
      currentChapterIndex--;
      final pages = await _startX(currentChapterIndex);
      this.textPages.addAll(pages);
      pageIndex = textPages.length - 1;
      _prepareNextChapter();
    }
  }

  _nextChapter() async {
    LogD('下一章', 'currentChapterIndex:$currentChapterIndex');
    if (currentChapterIndex >= chapters.length - 1) {
      pageIndex = textPages.length - 1;
    } else {
      pageIndex = 0;
      textPages.clear();
      currentChapterIndex++;
      // 反正有预加载章节，应该直接用预加载的数据。用了预加载章节数据，数据不对，可能是异步 或 直接引用的原因（浅拷贝）
      final pages = await _startX(currentChapterIndex);
      textPages.addAll(pages);
      _prepareNextChapter();
    }
  }

  // 多读取一章内容
  _prepareNextChapter() async {
    nextTextPages.clear();
    if (currentChapterIndex + 1 <= lastChapterIndex) {
      final pages2 = await _startX(currentChapterIndex + 1);
      nextTextPages.addAll(pages2);
    }
  }

  /// 加载上次阅读章节
  _loadLastReadChapter() async {
    textPages.clear();
    final pages = await _startX(currentChapterIndex);
    textPages.addAll(pages);
    _prepareNextChapter();
    int gotoPageIndex = bookNovel?.lastReadChapterOffset ?? 0;
    gotoPage(gotoPageIndex);
  }

  @override
  Future<void> onInit() async {
    LogI('生命周期顺序', 'onInit');

    bookNovel = Get.arguments as BookNovelEntity;
    currentChapterIndex = bookNovel?.lastReadChapterIndex ?? 0;

    // 读取阅读配置
    readConfigEntity =
        IsarHelper.instance.isarInstance.readConfigEntitys.getSync(1);
    if (readConfigEntity == null) {
      fontSizeController = TextEditingController(text: '20');
      fontHeightController = TextEditingController(text: '1.2');
      background = R.images.bg001;
      fontColor = 0xdd000000;
    } else {
      fontSizeController =
          TextEditingController(text: readConfigEntity?.fontSize.toString());
      fontHeightController =
          TextEditingController(text: readConfigEntity?.fontHeight.toString());
      background = readConfigEntity!.background;
      fontColor = readConfigEntity!.fontColor;
    }

    await _getBackImage(background);

    // 从数据库中查询章节
    List<BookChapterEntity> temp = IsarHelper
        .instance.isarInstance.bookChapterEntitys
        .filter()
        .bookIdEqualTo(bookNovel!.id!)
        .findAllSync();
    if (temp.isEmpty) {
      temp = await _getBookNovelInfo();
      IsarHelper.instance.isarInstance.writeTxn(() async {
        IsarHelper.instance.isarInstance.bookChapterEntitys.putAll(temp);
      });
    }
    chapters.addAll(temp);
    firstChapterIndex = chapters.first.chapterIndex;
    lastChapterIndex = chapters.last.chapterIndex;

    menuAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    menuTopAnimationProgress = menuAnimationController
        .drive(Tween(begin: Offset(0.0, -1.0), end: Offset.zero));
    menuBottomAnimationProgress = menuAnimationController
        .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero));

    super.onInit();
  }

  @override
  void onReady() {
    LogI('生命周期顺序', 'onReady');

    _loadLastReadChapter();
    _loadingStatus = LoadingStatus.success;

    super.onReady();
  }

  @override
  void onClose() {
    _recordRead();
    menuAnimationController.dispose();
    fontSizeController.dispose();
    fontHeightController.dispose();

    super.onClose();
  }

  _recordRead() {
    // 记录阅读位置
    bookNovel?.lastReadChapterIndex = currentChapterIndex;
    bookNovel?.lastReadChapterTitle =
        chapters[currentChapterIndex].chapterTitle;
    bookNovel?.lastReadChapterOffset = pageIndex;

    // 记录阅读配置
    readConfigEntity = ReadConfigEntity(
        fontSize: double.parse(fontSizeController.value.text),
        fontHeight: double.parse(fontHeightController.value.text),
        background: background,
        fontColor: fontColor);

    IsarHelper.instance.isarInstance.writeTxn(() async {
      IsarHelper.instance.isarInstance.bookNovelEntitys.put(bookNovel!);
      IsarHelper.instance.isarInstance.readConfigEntitys.put(readConfigEntity!);
    });
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
