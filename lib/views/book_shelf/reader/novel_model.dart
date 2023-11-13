import 'dart:convert';

import 'package:flutter/material.dart';

List<ChapterModel> chapterModelFromJson(String str) => List<ChapterModel>.from(json.decode(str).map((x) => ChapterModel.fromJson(x)));

String chapterModelToJson(List<ChapterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChapterModel {
  String chapterTitle;
  String chapterContent;

  ChapterModel({
    required this.chapterTitle,
    required this.chapterContent,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
    chapterTitle: json["chapterTitle"],
    chapterContent: json["chapterContent"],
  );

  Map<String, dynamic> toJson() => {
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

//   List<NovelChapterInfo>? chapterList;
//   int currentChapterIndex = 0;
// }

/// 章节
class NovelChapterInfo {
  int chapterIndex = 0;
  String? chapterTitle;

  List<PerPageContentInfo> chapterPageContentList = [];

  int get chapterPageCount => chapterPageContentList.length;
}

/// 章节内容的每页数据
class PerPageContentInfo{
  double currentContentParagraphSpace = 0;
  int currentPageIndex = 0;
  List<InlineSpan> paragraphContents = []; // 一行行文字的集合
}