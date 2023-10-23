
import 'dart:convert';

import 'package:hive/hive.dart';
part 'song_list_entity.g.dart';
//dart run build_runner build

List<SongListEntity> songListFromJson(String str) => List<SongListEntity>.from(json.decode(str).map((x) => SongListEntity.fromJson(x)));
String songListToJson(List<SongListEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class SongListEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String songList;
  @HiveField(2)
  String songListAlbum;
  @HiveField(3)
  int count;

  SongListEntity({
    required this.id,
    required this.songList,
    required this.songListAlbum,
    required this.count,
  });

  factory SongListEntity.fromJson(Map<String, dynamic> json) => SongListEntity(
    id: json["id"],
    songList: json["songList"],
    songListAlbum: json["songListAlbum"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "songList": songList,
    "songListAlbum": songListAlbum,
    "count": count,
  };
}
