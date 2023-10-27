
import 'dart:convert';

List<SongArtEntity> songArtFromJson(String str) => List<SongArtEntity>.from(json.decode(str).map((x) => SongArtEntity.fromJson(x)));

String songArtToJson(List<SongArtEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongArtEntity {
  String songId;
  String albumArt;

  SongArtEntity({
    required this.songId,
    required this.albumArt,
  });

  factory SongArtEntity.fromJson(Map<String, dynamic> json) => SongArtEntity(
    songId: json["song_id"],
    albumArt: json["album_art"],
  );

  Map<String, dynamic> toJson() => {
    "song_id": songId,
    "album_art": albumArt,
  };
}
