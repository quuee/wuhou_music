import 'dart:convert';

import 'package:isar/isar.dart';

part 'book_novel_entity.g.dart';
// dart run build_runner build

List<BookNovelEntity> bookNovelEntityFromJson(String str) => List<BookNovelEntity>.from(json.decode(str).map((x) => BookNovelEntity.fromJson(x)));

String bookNovelEntityToJson(List<BookNovelEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
@Name('book_novel')
class BookNovelEntity {

  Id? id= Isar.autoIncrement;
  String bookTitle;
  String localPath;

  BookNovelEntity({
    required this.bookTitle,
    required this.localPath,
  });

  factory BookNovelEntity.fromJson(Map<String, dynamic> json) => BookNovelEntity(
    bookTitle: json["bookTitle"],
    localPath: json["localPath"],
  );

  Map<String, dynamic> toJson() => {
    "bookTitle": bookTitle,
    "localPath": localPath,
  };
}