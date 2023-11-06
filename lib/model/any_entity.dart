
import 'package:isar/isar.dart';
part 'any_entity.g.dart';

@collection
class AnyEntity {

  @Name('id')
  Id? id = Isar.autoIncrement;

  @Name('keyName')
  String keyName;

  @Name('anything')
  String anything;

  AnyEntity({
    this.id,
    required this.keyName,
    required this.anything,
  });

  factory AnyEntity.fromJson(Map<String, dynamic> json) => AnyEntity(
    id: json["id"],
    keyName: json["keyName"],
    anything: json["anything"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "keyName": keyName,
    "anything": anything,
  };
}