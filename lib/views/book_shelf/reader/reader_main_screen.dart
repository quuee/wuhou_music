import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/common_widgets/custome_drawer.dart';
import 'package:wuhoumusic/model/book_novel/book_chapter_entity.dart';
import 'package:wuhoumusic/model/book_novel/book_chapter_entity.dart';
import 'package:wuhoumusic/model/book_novel/book_novel_entity.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/book_shelf/code_convert/code_convert.dart';
import 'package:wuhoumusic/views/book_shelf/reader/reader_content_screen.dart';

import 'content_split_util.dart';
import 'novel_model.dart';

class ReaderMainScreen extends StatefulWidget {
  const ReaderMainScreen({super.key});

  @override
  State<ReaderMainScreen> createState() => _ReaderMainScreenState();
}

class _ReaderMainScreenState extends State<ReaderMainScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _ignorePointerKey = GlobalKey();
  bool _shouldIgnorePointer = false;
  late AnimationController menuAnimationController;
  late Animation<Offset> menuTopAnimationProgress;
  late Animation<Offset> menuBottomAnimationProgress;

  BookNovelEntity? bookNovel;
  List<BookChapterEntity> chapters = [];

  // late ScrollController chapterScroll;

  // Stream<ChapterCacheInfo>? chapterStream;
  // List<ChapterCacheInfo> chapterCacheInfoList = []; // 若是调整字体 间距，重新画笔布局，清空章节集合

  // int totalPage = 0; // 总页数

  @override
  void initState() {
    super.initState();
    menuAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    menuTopAnimationProgress = menuAnimationController
        .drive(Tween(begin: Offset(0.0, -1.0), end: Offset.zero));
    menuBottomAnimationProgress = menuAnimationController
        .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero));
    menuAnimationController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _setIgnorePointer(true);
      } else {
        _setIgnorePointer(false);
      }
    });

    // chapterScroll = ScrollController()..addListener(() {
    //
    // });

    _getBookNovelInfo();
  }

  _setIgnorePointer(bool value) {
    if (_shouldIgnorePointer == value) return;
    _shouldIgnorePointer = value;
    if (_ignorePointerKey.currentContext != null) {
      final RenderIgnorePointer renderBox = _ignorePointerKey.currentContext!
          .findRenderObject()! as RenderIgnorePointer;
      renderBox.ignoring = _shouldIgnorePointer;
    }
  }

  @override
  void dispose() {
    // 记录阅读位置
    // IsarHelper.instance.isarInstance.writeTxnSync(() {
    //   IsarHelper.instance.isarInstance.bookNovelEntitys.putSync(bookNovel!);
    // });
    // chapterScro.dispose();
    menuAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (menuAnimationController.isCompleted) {
                menuAnimationController.reverse();
              } else {
                menuAnimationController.forward();
              }
            },
            child: IgnorePointer(
              key: _ignorePointerKey,
              ignoring: _shouldIgnorePointer,
              child: _buildChapter(),
            ),
          )),
          // 顶部
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: menuTopAnimationProgress,
              child: AppBar(),
            ),
          ),
          //底部
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: menuBottomAnimationProgress,
              child: _buildBottomMenu(),
            ),
          )
        ],
      ),
    );
  }

  _buildBottomMenu() {
    return Container(
      color: Colors.white70,
      child: Column(
        children: [
          //第一行
          Row(
            children: [
              Expanded(flex: 1, child: Text('上一章')),
              Expanded(
                flex: 6,
                child: Slider(max: 100, value: 1, onChanged: (v) {}),
              ),
              Expanded(flex: 1, child: Text('下一章')),
            ],
          ),
          // 第二行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Text('目录'),
                onTap: () {
                  RDrawer.open(
                      Drawer(
                        child: ListView.builder(
                            itemCount: chapters.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(chapters[index].chapterTitle ?? ''),
                                subtitle: Text('第$index章'),
                                onTap: () {
                                  // double height = 0.0;
                                  // var list =
                                  //     chapterCacheInfoList.sublist(0, index);
                                  // for (int i = 0; i < list.length; i++) {
                                  //   height += list[i].getChapterHeight();
                                  // }
                                  //
                                  // LogD('跳转高度', height.toString());
                                  // chapterScro.jumpTo(height);
                                },
                              );
                            }),
                      ),
                      width: MediaQuery.of(context).size.width * 2 / 3);
                },
              ),
              Text('亮度'),
              Text('设置'),
              Text('更多'),
            ],
          )
        ],
      ),
    );
  }

  _buildChapter() {
    // return StreamBuilder<ChapterCacheInfo>(
    //   stream: chapterStream,
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           backgroundColor: Colors.grey[200],
    //           valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
    //         ),
    //       );
    //     }
    //
    //     chapterCacheInfoList.add(snapshot.data!);
    //
    //     return ListView.builder(
    //
    //         physics: PageScrollPhysics(),
    //         scrollDirection: Axis.horizontal,
    //         itemCount: chapterCacheInfoList.length,
    //         itemBuilder: (context, index) {
    //           return ReaderContentScreen(
    //             chapterCacheInfo: chapterCacheInfoList[index],
    //             contentHeight: MediaQuery.of(context).size.height,
    //             contentWidth: MediaQuery.of(context).size.width,
    //             totalPage: 0,
    //           );
    //         });
    //   },
    // );
    ChapterCacheInfo parseChapter = _parseChapter(chapters[0]);
    setState(() {});
    return ReaderContentScreen(
      chapterCacheInfo: parseChapter,
      contentHeight: MediaQuery.of(context).size.height,
      contentWidth: MediaQuery.of(context).size.width,
      totalPage: 0,
    );
  }

  _getBookNovelInfo() {
    if (bookNovel == null) {
      bookNovel = Get.arguments as BookNovelEntity;
      File file = File(bookNovel!.localPath);
      bool exist = file.existsSync();
      if (!exist) {
        return;
      }
      // TODO RandomAccessFile重写小说阅读

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
          // allowMalformed: true 避免数据拆包后无法转码
          chapterContent = utf8.decode(buffer.sublist(0, readLength),
              allowMalformed:
                  true); // 当前章节内容  Unfinished UTF-8 octet sequence问题
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
          String chapterContentSubFront =
              chapterContent.substring(seekPositionString, chapterStart); // 截取章节前部内容

          if (seekPositionBytes == 0 && chapterStart != 0) {
            //表示 章节处于中间
            seekPositionBytes += utf8.encode(chapterContentSubFront).length; //设置指针偏移
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
              lastChapter.end =
                  (lastChapter.end ?? 0) + utf8.encode(chapterContentSubFront).length;
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
              seekPositionBytes += utf8.encode(chapterContentSubFront).length; //设置指针偏移
              seekPositionString += chapterContentSubFront.length; //临时偏移量
              BookChapterEntity lastChapter = chapters[chapters.length - 1];
              lastChapter.end =
                  (lastChapter.end ?? 0) + utf8.encode(chapterContentSubFront).length;
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

        // 没有匹配则进行虚拟分章

        curOffset += readLength;
        // 如果有正则章节
        BookChapterEntity lastChapter = chapters[chapters.length - 1];
        lastChapter.end = curOffset;
      }

      randomAccessFile.closeSync();

      // try {
      //
      //
      //   // bookContent = file.readAsStringSync();
      // } on FileSystemException catch (e) {
      //   LogE('读取book编码错误', e.message);
      //   List<int> readBytes = file.readAsBytesSync().toList();
      //   bookContent = CodeConvert.gbk2utf8(readBytes);
      // }
      // chapterStream = _createChapterCacheInfoStream(chapters);
    }
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

  // Stream<ChapterCacheInfo> _createChapterCacheInfoStream(
  //     List<BookChapterEntity> cList) async* {
  //   for (int i = 0; i < cList.length; i++) {
  //     LogD('返回', cList[i].chapterTitle.toString());
  //     await Future.delayed(Duration(milliseconds: 500));
  //     ChapterCacheInfo parseChapter = await _parseChapter(cList[i]);
  //     yield parseChapter;
  //     // 如何中断
  //   }
  // }

  ChapterCacheInfo _parseChapter(BookChapterEntity chapterModel) {
    List<int> getChapterContent = _getChapterContent(chapterModel);
    String chapterContent =
        utf8.decode(getChapterContent, allowMalformed: true);

    double contentHeight = MediaQuery.of(context).size.height - 30 - 30;
    double contentWidth = MediaQuery.of(context).size.width - 20;
    double fontSize = 24;
    double lineHeight = 1.3;

    ChapterCacheInfo chapterInfo = ContentSplitUtil.calculateChapter(
      chapterContent: TextSpan(
          text: chapterModel.chapterTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize * lineHeight,
            height: lineHeight,
          ),
          children: [
            TextSpan(
                text: chapterContent,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    height: lineHeight)) // height行高是倍速
          ]),
      contentHeight: contentHeight,
      contentWidth: contentWidth,
    );
    chapterInfo.chapterTitle = chapterModel.chapterTitle;
    return chapterInfo;
    // return Future.value(chapterInfo);
  }
}
