// import 'dart:isolate';
// import 'novel_model.dart';
//
// class ContentParseUtil {
//
//
//
//   static void decodeAndParseContent(List<dynamic> args) async {
//     SendPort sendPort = args[0];
//     String encodedContent = args[1];
//
//     //匹配规则
//     RegExp pest = RegExp(
//         '(正文){0,1}(\\s|\\n)(第)([\\u4e00-\\u9fa5a-zA-Z0-9]{1,7})[章][^\\n]{1,35}(|\\n)');
//
//     //将小说内容中的PS全部替换为""
//     String replaceContent = encodedContent.replaceAll(RegExp('(PS|ps)(.)*(|\\n)'), '');
//     List<String> chapterContentList = replaceContent.split(pest);
//     Iterable<Match> allMatches = pest.allMatches(replaceContent);
//     // List<ChapterModel> chapterList = [];
//     sendPort.send(ChapterModel(
//         chapterIndex: 0,
//         chapterTitle: '正文',
//         chapterContent: chapterContentList[0]));
//
//     for (int i = 1; i < chapterContentList.length; i++) {
//       String chapterName = allMatches.elementAt(i - 1).group(0).toString();
//       sendPort.send(ChapterModel(
//           chapterIndex: i,
//           chapterTitle: chapterName,
//           chapterContent: chapterContentList[i]));
//     }
//
//     Isolate.exit(sendPort);
//
//   }
//
// }