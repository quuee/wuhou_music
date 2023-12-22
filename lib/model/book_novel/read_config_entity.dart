import 'package:isar/isar.dart';

part 'read_config_entity.g.dart'; // dart run build_runner build

@collection
@Name('read_config')
class ReadConfigEntity{
  Id? id = Isar.autoIncrement;
  double fontSize; // 字号
  double fontHeight; // 字间高度
  // double lineHeight; // 行高

  ReadConfigEntity({required this.fontSize,required this.fontHeight});
}