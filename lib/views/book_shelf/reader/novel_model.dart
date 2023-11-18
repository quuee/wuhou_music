import 'dart:convert';

import 'package:flutter/material.dart';

List<ChapterModel> chapterModelFromJson(String str) => List<ChapterModel>.from(
    json.decode(str).map((x) => ChapterModel.fromJson(x)));

String chapterModelToJson(List<ChapterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChapterModel {
  int chapterIndex;
  String chapterTitle;
  String chapterContent;

  ChapterModel({
    required this.chapterIndex,
    required this.chapterTitle,
    required this.chapterContent,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
        chapterIndex: json["chapterIndex"],
        chapterTitle: json["chapterTitle"],
        chapterContent: json["chapterContent"],
      );

  Map<String, dynamic> toJson() => {
        "chapterIndex": chapterIndex,
        "chapterName": chapterTitle,
        "chapterContent": chapterContent,
      };
}

/**-------------------------------------------用于解析布局的章节模型-----------------------------------------------------------------*/
/// 小说
// class NovelBookInfo{
//   String bookTitle;
//   String localPath;
//   String? bookAuthor;
//   String? lastChapterTitle;
//
//   NovelBookInfo({
//     required this.bookTitle,
//     required this.localPath,
//     this.bookAuthor,
//     this.lastChapterTitle
// });
//
//   List<NovelChapterInfo>? chapterList;
//   int currentChapterIndex = 0;
// }

/// 章节
class ChapterCacheInfo {
  int chapterIndex = 0;
  String? chapterTitle;

  List<ChapterPageContentCacheInfo> chapterPageContentCacheInfoList = [];

  int get chapterPageCount => chapterPageContentCacheInfoList.length;

  double getChapterHeight() {
    double height = 0.0;
    for (int i = 0; i < chapterPageCount; i++) {
      height += chapterPageContentCacheInfoList[i].contentHeight;
    }
    return height;
  }
}

/// 章节内容的每页数据
class ChapterPageContentCacheInfo {
  double contentHeight = 0.0;
  double currentContentParagraphSpace = 0;
  List<InlineSpan> paragraphContents = []; // 一行行文字的集合
}
