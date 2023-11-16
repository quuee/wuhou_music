import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/custome_drawer.dart';
import 'package:wuhoumusic/model/book_novel/book_novel_entity.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/book_shelf/code_convert/code_convert.dart';
import 'package:wuhoumusic/views/book_shelf/reader/content_parse_util.dart';
import 'package:wuhoumusic/views/book_shelf/reader/content_split_util.dart';

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

  late ScrollController chapterScro;

  Stream<ChapterCacheInfo>? chapterStream;
  List<ChapterCacheInfo> chapterCacheInfoList = []; // 若是调整字体 间距，重新画笔布局，清空章节集合

  int totalPage = 0; // 总页数
  int currentPage = 1; //

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
    //记录阅读位置
    // IsarHelper.instance.isarInstance.writeTxnSync(() {
    //   IsarHelper.instance.isarInstance.bookNovelEntitys.putSync(bookNovel!);
    // });
    chapterScro.dispose();
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
                            itemCount: chapterCacheInfoList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title:
                                    Text(chapterCacheInfoList[index].chapterTitle??''),
                                subtitle: Text('第$index章'),
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

  _buildChapter(){
    return StreamBuilder<ChapterCacheInfo>(stream: chapterStream,builder: (context,snapshot){
      if(!snapshot.hasData){
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
          ),
        );
      }
      LogD('StreamBuilder', snapshot.data!.toString());
      chapterCacheInfoList.add(snapshot.data!);
        return ListView.builder(
            controller: chapterScro, // TODO 自定义手势 收集页码
            physics: PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: chapterCacheInfoList.length,
            itemBuilder: (context, index) {
              return _buildReadScreen(chapterCacheInfoList[index]);
            });

    },);
  }

  _buildReadScreen(ChapterCacheInfo chapterCacheInfo) {
      return ListView.builder(
          physics: PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: chapterCacheInfo.chapterPageCount,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Text.rich(
                      TextSpan(
                          children: chapterCacheInfo.chapterPageContentCacheInfoList[index]
                              .paragraphContents),
                      softWrap: true,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 10,
                      child: Text('页码:$currentPage' + "/$totalPage",
                          style: TextStyle(color: Colors.grey, fontSize: 12))),
                  Positioned(
                      bottom: 0,
                      left: 10,
                      child: Text(
                        chapterCacheInfo.chapterTitle ?? '',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )),
                ],
              ),
            );
          });
  }


  Future<ChapterCacheInfo> _parseChapter(ChapterModel chapterModel) async{
    double fontSize = 24;
    ChapterCacheInfo chapterInfo = ContentSplitUtil.calculateChapter(
      chapterContent: TextSpan(
          text: chapterModel.chapterTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize * 1.3,
            height: 1.3,
          ),
          children: [
            TextSpan(
                text: chapterModel.chapterContent,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    height: 1.3)) // height行高是倍速
          ]),
      contentHeight: MediaQuery.of(context).size.height - 30 - 30,
      contentWidth: MediaQuery.of(context).size.width - 20,
    );
    chapterInfo.chapterTitle = chapterModel.chapterTitle;

    return Future.value(chapterInfo);
  }

  _getBookNovelInfo() {
    String bookContent = '';
    if (bookNovel == null) {
      bookNovel = Get.arguments as BookNovelEntity;
      File file = File(bookNovel!.localPath);
      bool exist = file.existsSync();
      if (!exist) {
        return;
      }
      try {
        bookContent = file.readAsStringSync();
      } on FileSystemException catch (e) {
        LogE('读取book编码错误', e.message);
        List<int> readBytes = file.readAsBytesSync().toList();
        bookContent = CodeConvert.gbk2utf8(readBytes);
      }
    }
    // double? lastReadOffset = bookNovel?.lastReadChapterOffset;
    // chapterScro = ScrollController(initialScrollOffset: lastReadOffset ?? 0)
    //   ..addListener(() {
    //     bookNovel?.lastReadChapterOffset = chapterScro.offset;
    //     LogD('chapterScro.offset', chapterScro.offset.toString());
    //   });

    List<ChapterModel> cList = ContentParseUtil.parseBookContent(bookContent);
    chapterStream = _createChapterCacheInfoStream(cList);

  }

  Stream<ChapterCacheInfo> _createChapterCacheInfoStream(List<ChapterModel> cList ) async*{
    for(int i =0 ;i<cList.length;i++){
      LogD('返回', i.toString());
      await Future.delayed(Duration(milliseconds: 500));
      ChapterCacheInfo parseChapter = await _parseChapter(cList[i]);
      totalPage += parseChapter.chapterPageCount;
      yield parseChapter;
      // 如何中断
    }
  }
}
