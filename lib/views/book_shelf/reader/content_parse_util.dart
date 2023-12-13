import 'dart:isolate';
import 'novel_model.dart';

class ContentParseUtil {


  // static Future<List<NovelChapterInfo>> parseInBackground(String encodedContent,double contentHeight,double contentWidth) async {
  //   // create a port
  //   ReceivePort  rp = ReceivePort();
  //   // spawn the isolate and wait for it to complete
  //   await Isolate.spawn(decodeAndParseContent, [p.sendPort,encodedContent,contentHeight,contentWidth]);
  //   // get and return the result data
  //   return await p.first;
  // }

  static void decodeAndParseContent(List<dynamic> args) async {
    SendPort sendPort = args[0];
    String encodedContent = args[1];

    //匹配规则
    RegExp pest = RegExp(
        '(正文){0,1}(\\s|\\n)(第)([\\u4e00-\\u9fa5a-zA-Z0-9]{1,7})[章][^\\n]{1,35}(|\\n)');

    //将小说内容中的PS全部替换为""
    String replaceContent = encodedContent.replaceAll(RegExp('(PS|ps)(.)*(|\\n)'), '');
    List<String> chapterContentList = replaceContent.split(pest);
    Iterable<Match> allMatches = pest.allMatches(replaceContent);
    // List<ChapterModel> chapterList = [];
    sendPort.send(ChapterModel(
        chapterIndex: 0,
        chapterTitle: '正文',
        chapterContent: chapterContentList[0]));

    for (int i = 1; i < chapterContentList.length; i++) {
      String chapterName = allMatches.elementAt(i - 1).group(0).toString();
      sendPort.send(ChapterModel(
          chapterIndex: i,
          chapterTitle: chapterName,
          chapterContent: chapterContentList[i]));
    }

    // for(int i =0 ;i<chapterList.length;i++){
    //   NovelChapterInfo calculateChapter = ContentSplitUtil.calculateChapter(
    //     chapterContent: TextSpan(
    //         text: chapterList[i].chapterTitle,
    //         style: TextStyle(
    //           color: Colors.black,
    //           fontSize: fontSize * 1.3,
    //           height: 1.3,
    //         ),
    //         children: [
    //           TextSpan(
    //               text: chapterList[i].chapterContent,
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: fontSize,
    //                   height: 1.3)) // height行高是倍速
    //         ]),
    //     contentHeight: contentHeight,
    //     contentWidth: contentWidth,
    //   );
    //   sendPort.send(calculateChapter);
    // }
    Isolate.exit(sendPort);

  }

}