import 'dart:convert';

import 'package:android_content_provider/android_content_provider.dart';
import 'package:audio_service/audio_service.dart';
import 'package:hive/hive.dart';

part 'song_entity.g.dart';
//dart run build_runner build

List<SongEntity> songEntityFromJson(String str) => List<SongEntity>.from(json.decode(str).map((x) => SongEntity.fromJson(x)));
String songEntityToJson(List<SongEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class SongEntity {
  @HiveField(0)
  late String id;
  @HiveField(1)
  String? album;
  @HiveField(2)
  int? albumId;
  @HiveField(3)
  String artist;
  @HiveField(4)
  late String title;
  @HiveField(5)
  late int duration;

  /// Actual art file path, if any.
  // String? get artPath => albumArtPaths[albumId];
  // int? get albumId => this.albumId;

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
  });

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
    },
  );

  static const mediaStoreProjection = [
    '_id',
    'album',
    'album_id',
    'artist',
    'title',
    'duration',
  ];

  /// Creates a song from data retrieved from the MediaStore.
  factory SongEntity.fromMediaStore(List<Object?> data) => SongEntity(
    id: data[0] as String,
    album: data[1] as String?,
    albumId: data[2] as int,
    artist: data[3] as String,
    title: data[4] as String,
    duration: data[5] as int,
  );

  /// Returns a markup of what data to get from the cursor.
  static NativeCursorGetBatch createBatch(NativeCursor cursor) =>
      cursor.batchedGet()
        ..getString(0)
        ..getString(1)
        ..getInt(2)
        ..getString(3)
        ..getString(4)
        ..getInt(5);

  factory SongEntity.fromJson(Map<String, dynamic> json) => SongEntity(
    id: json["id"],
    album: json["album"],
    albumId: json["albumId"],
    artist: json["artist"],
    title: json["title"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "album": album,
    "albumId": albumId,
    "artist": artist,
    "title": title,
    "duration": duration,
  };
}