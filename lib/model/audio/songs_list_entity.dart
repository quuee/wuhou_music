import 'dart:convert';

import 'package:isar/isar.dart';

part 'songs_list_entity.g.dart';
//dart run build_runner build

List<SongsListEntity> songListEntityFromJson(String str) =>
    List<SongsListEntity>.from(
        json.decode(str).map((x) => SongsListEntity.fromJson(x)));
String songListEntityToJson(List<SongsListEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
@Name('songs_list')
class SongsListEntity {
  @Name("apslid")
  Id? apslid = Isar.autoIncrement; //app自动生成本地id
  @Name("slid")
  String? slid; // 服务端id
  @Name("listTitle")
  String listTitle;
  @Name("listAlbum")
  String? listAlbum;
  @Name("count")
  int? count;

  SongsListEntity({
    this.apslid,
    this.slid,
    required this.listTitle,
    this.listAlbum,
    this.count,

  });

  factory SongsListEntity.fromJson(Map<String, dynamic> json) =>
      SongsListEntity(
        apslid: json["apslid"],
        listTitle: json["listTitle"],
        listAlbum: json["listAlbum"] ?? '',
        count: json["count"] ?? 0,
        slid: json["slid"] ?? '',

      );

  Map<String, dynamic> toJson() => {
        "apslid": apslid,
        "listTitle": listTitle,
        "listAlbum": listAlbum,
        "count": count,
        "slid": slid,

      };
}
