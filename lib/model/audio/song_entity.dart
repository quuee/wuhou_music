import 'dart:convert';
import 'package:android_content_provider/android_content_provider.dart';
import 'package:isar/isar.dart';

part 'song_entity.g.dart';
//dart run build_runner build

List<SongEntity> songEntityFromJson(String str) {
  print(str);
  return List<SongEntity>.from(json.decode(str).map((x) => SongEntity.fromJson(x)));
}

// String songEntityToJson(List<SongEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String songEntityToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@collection
class SongEntity {

  @Name("sid")
  Id? sid ; // 用在isra中，建立歌单歌曲关系
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
  int? duration; // 时长
  @Name("quality")
  String? quality; // 音频质量
  @Name("albumArt")
  String? albumArt; //专辑封面 artPath
  @Name("data")
  String? data; // 真实路径
  @Name("bucketDisplayName")
  String? bucketDisplayName; // 来自哪个本地文件夹
  @Name('url')
  String? url; // 在线播放地址


  /// The content URI of the song for playback.
  // String get uri => 'content://media/external/audio/media/$id';


  SongEntity({
    this.sid,
    required this.id,
     this.album,
     this.albumId,
    required this.artist,
    required this.title,
    this.duration,
    this.quality,
    this.albumArt,
    this.data,
    this.bucketDisplayName,
    this.url
  });

  static const mediaStoreProjection = [
    '_id',
    'album',
    'album_id',
    'artist',
    'title',
    'duration',
    '_data',
    'bucket_display_name',
    // '_size', //文件大小
  ];

  /// Creates a song from data retrieved from the MediaStore.
  factory SongEntity.fromMediaStore(List<Object?> data) => SongEntity(
    sid: int.parse(data[0].toString()) ,
    id: data[0] as String,
    album: data[1] as String?,
    albumId: data[2] as int,
    artist: data[3] as String,
    title: data[4] as String,
    duration: data[5] as int,
    data: data[6] as String,
    bucketDisplayName: data[7] as String,
  );

  /// Returns a markup of what data to get from the cursor.
  static NativeCursorGetBatch createBatch(NativeCursor cursor) =>
      cursor.batchedGet()
        ..getString(0)
        ..getString(1)
        ..getInt(2)
        ..getString(3)
        ..getString(4)
        ..getInt(5)
        ..getString(6)
        ..getString(7);

  factory SongEntity.fromJson(Map<String, dynamic> json) => SongEntity(
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