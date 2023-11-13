import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
        setIgnorePointer(true);
      } else {
        setIgnorePointer(false);
      }
    });

  }

  void setIgnorePointer(bool value) {
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
              child: FutureBuilder<List<ChapterModel>>(
                future: _getBookNovelInfo(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: Text('loading'),
                    );
                  }
                  List<ChapterModel> list = snapshot.data!;
                  return _buildBookNovel(list);

                },
              ),
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
              Text('目录'),
              Text('亮度'),
              Text('设置'),
              Text('更多'),
            ],
          )
        ],
      ),
    );
  }

  _buildBookNovel(List<ChapterModel> chapterList) {

    ScrollController scrollController = ScrollController(); //控制跳到某章
    // int initialChapterIndex = 0;
    return ListView.builder(
        controller: scrollController,
        physics: PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: chapterList.length,
        itemBuilder: (context, index) {
          return _buildChapter(chapterList[index]);
        });
  }

  _buildChapter(ChapterModel chapterModel) {

    double fontSize = 24;
    NovelChapterInfo chapterInfo = ContentSplitUtil.calculateChapter(
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
      contentHeight: MediaQuery.of(context).size.height - 30 - 5 ,
      contentWidth: MediaQuery.of(context).size.width - 20,
    );

    chapterInfo.chapterTitle = chapterModel.chapterTitle;
    return ListView.builder(
        physics: PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: chapterInfo.chapterPageCount,
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
                        children: chapterInfo
                            .chapterPageContentList[index].paragraphContents),
                    softWrap: true,
                  ),
                )
              ],
            ),
          );
        });

  }

  Future<List<ChapterModel>> _getBookNovelInfo() async {
    String bookContent = await rootBundle.loadString('assets/三体.txt');
    return _parse(bookContent);
  }

  List<ChapterModel> _parse(String bookContent) {
    //匹配规则
    RegExp pest = RegExp(
        '(正文){0,1}(\\s|\\n)(第)([\\u4e00-\\u9fa5a-zA-Z0-9]{1,7})[章][^\\n]{1,35}(|\\n)');

    //将小说内容中的PS全部替换为""
    bookContent = bookContent.replaceAll(RegExp('(PS|ps)(.)*(|\\n)'), '');
    List<String> chapterContentList = bookContent.split(pest);

    List<ChapterModel> chapterList = [];
    chapterList.add(ChapterModel(
        chapterTitle: '正文', chapterContent: chapterContentList[0]));

    Iterable<Match> allMatches = pest.allMatches(bookContent);
    for (int i = 1; i < chapterContentList.length; i++) {
      String chapterName = allMatches.elementAt(i - 1).group(0).toString();
      chapterList.add(ChapterModel(
          chapterTitle: chapterName, chapterContent: chapterContentList[i]));
    }
    return chapterList;
  }
}
