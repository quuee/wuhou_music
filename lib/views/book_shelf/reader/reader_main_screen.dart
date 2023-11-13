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

  List<NovelChapterInfo>? novelChapterInfoList;

  bool _loadingCompleted = false;

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
    _getBookNovelInfo();
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
              child: _buildBookNovel(),
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
            bottom: 10,
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

  _buildBookNovel() {

    if(!_loadingCompleted){
      return Center(child: Text('loading'),);
    }

    ScrollController scrollController = ScrollController();
    // int initialChapterIndex = 0;
    return ListView.builder(
        controller: scrollController,
        physics: PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: novelChapterInfoList!.length,
        itemBuilder: (context, index) {
          return _buildChapter(novelChapterInfoList![index]);
        });

  }

  _buildChapter(NovelChapterInfo? chapterInfo){

    if(chapterInfo == null ){
      return Center(child: Text('解析中'),);
    }
    return ListView.builder(
        physics: PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: chapterInfo.chapterPageCount,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 30),
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


  _getBookNovelInfo() async {
    String bookContent = await rootBundle.loadString('assets/三体.txt');
    _parse(bookContent);
  }
  _parse(String bookContent){
    //匹配规则
    RegExp pest = RegExp(
        '(正文){0,1}(\\s|\\n)(第)([\\u4e00-\\u9fa5a-zA-Z0-9]{1,7})[章][^\\n]{1,35}(|\\n)');

    //将小说内容中的PS全部替换为""
    bookContent = bookContent.replaceAll(RegExp('(PS|ps)(.)*(|\\n)'), '');
    List<String> chapterContentList = [];
    for (String s in bookContent.split(pest)) {
      chapterContentList.add(s); // 分割后只有章节内容，没有章节
    }

    List<ChapterModel> chapterList = [];
    chapterList.add(ChapterModel(
        chapterTitle: '正文', chapterContent: chapterContentList[0]));

    Iterable<Match> allMatches = pest.allMatches(bookContent);
    for (int i = 1; i < chapterContentList.length; i++) {
      String chapterName = allMatches.elementAt(i - 1).group(0).toString();
      chapterList.add(ChapterModel(
          chapterTitle: chapterName, chapterContent: chapterContentList[i]));
    }

    int i = 1;
    novelChapterInfoList = chapterList.map((e) {
      NovelChapterInfo chapterInfo = ContentSplitUtil.calculateChapter(chapterContent: TextSpan(
          text: e.chapterTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16 * 2,
            height: 1,
          ),
          children: [
            TextSpan(
                text: e.chapterContent,
                style: TextStyle(color: Colors.black, fontSize: 16, height: 1))// height行高是倍速
          ]),
        contentHeight: MediaQuery.of(context).size.height - 30 - 60,
        contentWidth: MediaQuery.of(context).size.width,);
      chapterInfo.chapterTitle = e.chapterTitle;
      chapterInfo.chapterIndex = i;
      i++;
      return chapterInfo;
    }).toList();

    setState(() {
      _loadingCompleted = true;
    });


  }
}
