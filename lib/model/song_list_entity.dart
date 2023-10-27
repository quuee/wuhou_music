
import 'dart:convert';

import 'package:hive/hive.dart';
part 'song_list_entity.g.dart';
//dart run build_runner build

List<SongListEntity> songListEntityFromJson(String str) => List<SongListEntity>.from(json.decode(str).map((x) => SongListEntity.fromJson(x)));
String songListEntityToJson(List<SongListEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class SongListEntity {
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

  SongListEntity({
    required this.id,
    required this.listTitle,
    required this.listAlbum,
    required this.count,
    // required this.songEntityList,
  });

  factory SongListEntity.fromJson(Map<String, dynamic> json) => SongListEntity(
    id: json["id"],
    listTitle: json["listTitle"],
    listAlbum: json["listAlbum"],
    count: json["count"],
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
