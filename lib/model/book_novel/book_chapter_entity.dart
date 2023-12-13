import 'dart:convert';

import 'package:isar/isar.dart';

part 'book_chapter_entity.g.dart';
// dart run build_runner build

List<BookChapterEntity> bookNovelEntityFromJson(String str) =>
    List<BookChapterEntity>.from(
        json.decode(str).map((x) => BookChapterEntity.fromJson(x)));

String bookNovelEntityToJson(List<BookChapterEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
@Name('book_chapter')
class BookChapterEntity {
  Id? id = Isar.autoIncrement;
  int bookId; //书名
  int chapterIndex; //
  String chapterTitle; //章节名
  int? start; //章节内容在文章中的起始位置
  int? end; //章节内容在文章中的终止位置(本地)
  String? content;

  BookChapterEntity(
      {this.id,
      required this.bookId,
      required this.chapterIndex,
      required this.chapterTitle,
      this.start,
      this.end,
      this.content
      });

  factory BookChapterEntity.fromJson(Map<String, dynamic> json) =>
      BookChapterEntity(
        id: json["id"],
        bookId: json["bookId"],
        chapterIndex: json["chapterIndex"],
        chapterTitle: json["chapterTitle"],
        start: json["start"],
        end: json["end"],
        content: json["content"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookId": bookId,
        "chapterIndex": chapterIndex,
        "chapterTitle": chapterTitle,
        "start": start,
        "end": end,
        "content": content,

      };
}
