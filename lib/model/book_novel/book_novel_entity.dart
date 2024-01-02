import 'dart:convert';

import 'package:isar/isar.dart';

part 'book_novel_entity.g.dart';
// dart run build_runner build

List<BookNovelEntity> bookNovelEntityFromJson(String str) =>
    List<BookNovelEntity>.from(
        json.decode(str).map((x) => BookNovelEntity.fromJson(x)));

String bookNovelEntityToJson(List<BookNovelEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
@Name('book_novel')
class BookNovelEntity {
  Id? id = Isar.autoIncrement;
  String bookTitle; //书名
  String localPath; //本地路径
  int? lastReadChapterIndex; //上次阅读章节
  String? lastReadChapterTitle;
  int? lastReadChapterOffset; //上次阅读位置
  int? spendTime; // 阅读花费的时间

  BookNovelEntity(
      {required this.bookTitle,
      required this.localPath,
      this.lastReadChapterIndex,
      this.lastReadChapterTitle,
      this.lastReadChapterOffset});

  factory BookNovelEntity.fromJson(Map<String, dynamic> json) =>
      BookNovelEntity(
        bookTitle: json["bookTitle"],
        localPath: json["localPath"],
        lastReadChapterIndex: json["lastReadChapterIndex"],
        lastReadChapterTitle: json["lastReadChapterTitle"],
        lastReadChapterOffset: json["lastReadChapterOffset"],
      );

  Map<String, dynamic> toJson() => {
        "bookTitle": bookTitle,
        "localPath": localPath,
        "lastReadChapterIndex": lastReadChapterIndex,
        "lastReadChapterTitle": lastReadChapterTitle,
        "lastReadChapterOffset": lastReadChapterOffset,
      };
}
