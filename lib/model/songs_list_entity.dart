import 'dart:convert';

import 'package:hive/hive.dart';
part 'songs_list_entity.g.dart';
//dart run build_runner build

List<SongsListEntity> songListEntityFromJson(String str) =>
    List<SongsListEntity>.from(
        json.decode(str).map((x) => SongsListEntity.fromJson(x)));
String songListEntityToJson(List<SongsListEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class SongsListEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String listTitle;
  @HiveField(2)
  String listAlbum;
  @HiveField(3)
  int count;
  // @HiveField(4,defaultValue: <SongEntity>[])
  // List<SongEntity> songEntityList;

  SongsListEntity({
    required this.id,
    required this.listTitle,
    required this.listAlbum,
    required this.count,
    // required this.songEntityList,
  });

  factory SongsListEntity.fromJson(Map<String, dynamic> json) =>
      SongsListEntity(
        id: json["id"],
        listTitle: json["listTitle"],
        listAlbum: json["listAlbum"] ?? '',
        count: json["count"] ?? 0,
        // songEntityList: songEntityFromJson(songEntityToJson(json["songEntityList"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "listTitle": listTitle,
        "listAlbum": listAlbum,
        "count": count,
        // "songEntityList": songEntityList,
      };
}
