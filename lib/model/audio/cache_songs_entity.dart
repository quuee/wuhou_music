
import 'package:isar/isar.dart';
part 'cache_songs_entity.g.dart';
//dart run build_runner build

@collection
class CacheSongEntity {

  @Name("gid")
  Id gid = Isar.autoIncrement;

  @Name("id")
  late String id; // 媒体库id

  @Name("album")
  String? album; // 专辑
  @Name("albumId")
  int? albumId; // 专辑
  @Name("artist")
  String artist; // 艺术家
  @Name("title")
  late String title; // 歌名
  @Name("duration")
  late int duration; // 时长
  @Name("quality")
  String? quality; // 音频质量
  @Name("albumArt")
  String? albumArt; //专辑封面 artPath
  @Name("data")
  String? data; // 真实路径
  @Name("bucketDisplayName")
  String? bucketDisplayName; // 来自哪个包
  @Name('url')
  String? url; // 在线播放地址

  CacheSongEntity({
    required this.id,
    this.album,
    this.albumId,
    required this.artist,
    required this.title,
    required this.duration,
    this.quality,
    this.albumArt,
    this.data,
    this.bucketDisplayName,
    this.url
  });

  factory CacheSongEntity.fromJson(Map<String, dynamic> json) => CacheSongEntity(
    id: json["id"],
    album: json["album"],
    albumId: json["albumId"],
    artist: json["artist"],
    title: json["title"],
    duration: json["duration"],
    quality: json["quality"],
    albumArt: json["albumArt"],
    data: json["data"],
    bucketDisplayName: json["bucketDisplayName"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "album": album,
    "albumId": albumId,
    "artist": artist,
    "title": title,
    "duration": duration,
    "quality": quality,
    "albumArt": albumArt,
    "data": data,
    "bucketDisplayName": bucketDisplayName,
    "url": url,
  };
}