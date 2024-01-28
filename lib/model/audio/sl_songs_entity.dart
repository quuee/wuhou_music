import 'package:isar/isar.dart';
part 'sl_songs_entity.g.dart';
//dart run build_runner build

@collection
class SLSongsEntity {
  @Name("id")
  Id? id = Isar.autoIncrement;
  @Name("sid")
  int sid; // app自动生成歌曲id
  @Name("apslid")
  int apslid; // app自动生成本地歌单id

  SLSongsEntity({
    this.id,
    required this.sid,
    required this.apslid,
  });
  factory SLSongsEntity.fromJson(Map<String, dynamic> json) => SLSongsEntity(
    id: json["id"],
    sid: json["sid"],
    apslid: json["apslid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sid": sid,
    "apslid": apslid,
  };
}
