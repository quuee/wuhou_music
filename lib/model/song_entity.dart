import 'dart:convert';

import 'package:android_content_provider/android_content_provider.dart';
import 'package:audio_service/audio_service.dart';
import 'package:hive/hive.dart';

part 'song_entity.g.dart';
//dart run build_runner build

List<SongEntity> songEntityFromJson(String str) {
  print(str);
  return List<SongEntity>.from(json.decode(str).map((x) => SongEntity.fromJson(x)));
}

// String songEntityToJson(List<SongEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String songEntityToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class SongEntity {
  @HiveField(0)
  late String id; // 媒体库id
  @HiveField(1)
  String? album; // 专辑
  @HiveField(2)
  int? albumId; // 专辑
  @HiveField(3)
  String artist; // 艺术家
  @HiveField(4)
  late String title; // 歌名
  @HiveField(5)
  late int duration; // 时长
  @HiveField(6)
  String? quality; // 音频质量
  @HiveField(7)
  String? artAlbum; //专辑封面 artPath
  @HiveField(8)
  String? data; //真是路径

  /// Actual art file path, if any.
  // String? get artPath => albumArtPaths[albumId];

  /// The content URI of the song for playback.
  String get uri => 'content://media/external/audio/media/$id';

  /// The content URI of the art.
  String get artUri => 'content://media/external/audio/media/$id/albumart';

  SongEntity({
    required this.id,
     this.album,
     this.albumId,
    required this.artist,
    required this.title,
    required this.duration,
    this.quality,
    this.artAlbum,
    this.data,
  });

  /// id:uri 这里必须换uri，不然找不到文件
  /// Converts the song info to [AudioService] media item.
  MediaItem toMediaItem() => MediaItem(
    id: uri,
    album: album,
    artist: artist,
    title: title,
    duration: Duration(milliseconds: duration),
    artUri: Uri.parse(artUri),
    extras: <String, dynamic>{
      'loadThumbnailUri': uri,
      'id':id,
      'artAlbum':artAlbum,
    },
  );

  static const mediaStoreProjection = [
    '_id',
    'album',
    'album_id',
    'artist',
    'title',
    'duration',
    '_data',
  ];

  /// Creates a song from data retrieved from the MediaStore.
  factory SongEntity.fromMediaStore(List<Object?> data) => SongEntity(
    id: data[0] as String,
    album: data[1] as String?,
    albumId: data[2] as int,
    artist: data[3] as String,
    title: data[4] as String,
    duration: data[5] as int,
    data: data[6] as String,
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
        ..getString(6);

  factory SongEntity.fromJson(Map<String, dynamic> json) => SongEntity(
    id: json["id"],
    album: json["album"],
    albumId: json["albumId"],
    artist: json["artist"],
    title: json["title"],
    duration: json["duration"],
    quality: json["quality"],
    artAlbum: json["artAlbum"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "album": album,
    "albumId": albumId,
    "artist": artist,
    "title": title,
    "duration": duration,
    "quality": quality,
    "artAlbum": artAlbum,
    "data": data,
  };
}