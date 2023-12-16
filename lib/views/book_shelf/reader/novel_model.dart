//
// import 'package:flutter/material.dart';
//
// /**-------------------------------------------用于解析布局的章节模型-----------------------------------------------------------------*/
// /// 小说
//
//
// /// 章节
// class ChapterCacheInfo {
//   int chapterIndex = 0;
//   String? chapterTitle;
//
//   List<ChapterPageContentCacheInfo> chapterPageContentCacheInfoList = [];
//
//   int get chapterPageCount => chapterPageContentCacheInfoList.length;
//
//   double getChapterHeight() {
//     double height = 0.0;
//     for (int i = 0; i < chapterPageCount; i++) {
//       height += chapterPageContentCacheInfoList[i].contentHeight;
//     }
//     return height;
//   }
// }
//
// /// 章节内容的每页数据
// class ChapterPageContentCacheInfo {
//   double contentHeight = 0.0;
//   double currentContentParagraphSpace = 0;
//   List<InlineSpan> paragraphContents = []; // 一行行文字的集合
// }
