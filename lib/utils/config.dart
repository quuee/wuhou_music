import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/any_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/theme/app_theme.dart';

import 'isar_helper.dart';

class Config {
  Config._privateConstructor();
  static final Config _instance = Config._privateConstructor();
  static Config get instance => _instance;
  init() async {
    // 主题模式
    AnyEntity? a = IsarHelper.instance.isarInstance.anyEntitys
        .filter()
        .keyNameEqualTo(Keys.isDarkMode)
        .findFirstSync();
    if (a == null) {
      a = new AnyEntity(keyName: Keys.isDarkMode, anything: '0');
    } else {
      int.parse(a.anything) == 0 ? Get.changeTheme(lightTheme) : Get.changeTheme(darkTheme);

    }
    IsarHelper.instance.isarInstance.writeTxn(
        () => IsarHelper.instance.isarInstance.anyEntitys.put(a!));
  }
}
