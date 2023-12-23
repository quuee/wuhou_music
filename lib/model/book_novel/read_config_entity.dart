import 'package:isar/isar.dart';

part 'read_config_entity.g.dart'; // dart run build_runner build

@collection
@Name('read_config')
class ReadConfigEntity {
  final Id id = 1;
  double fontSize; // 字号
  double fontHeight; // 字间高度
  String background; // 背景色
  int fontColor; // 字体颜色

  ReadConfigEntity(
      {required this.fontSize,
      required this.fontHeight,
      required this.background,
      required this.fontColor});
}
