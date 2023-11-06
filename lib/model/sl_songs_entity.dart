import 'package:isar/isar.dart';
part 'sl_songs_entity.g.dart';
@collection
class SLSongsEntity {
  @Name("id")
  Id? id = Isar.autoIncrement;
  @Name("sid")
  int? sid;
  @Name("apslid")
  int? apslid;

  SLSongsEntity({
    this.id,
    this.sid,
    this.apslid,
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
