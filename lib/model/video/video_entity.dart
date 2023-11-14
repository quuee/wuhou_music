import 'dart:convert';

List<VideoEntity> videoEntityFromJson(String str) => List<VideoEntity>.from(json.decode(str).map((x) => VideoEntity.fromJson(x)));

String videoEntityToJson(List<VideoEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoEntity {
  int vid;
  String videoTitle;
  String videoUrl;

  VideoEntity({
    required this.vid,
    required this.videoTitle,
    required this.videoUrl,
  });

  factory VideoEntity.fromJson(Map<String, dynamic> json) => VideoEntity(
    vid: json["vid"],
    videoTitle: json["videoTitle"],
    videoUrl: json["videoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "vid": vid,
    "videoTitle": videoTitle,
    "videoUrl": videoUrl,
  };
}