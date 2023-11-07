import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/api/user_api.dart';
import 'package:wuhoumusic/model/any_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';

class LoginController extends GetxController {
  TextEditingController accountCtro = TextEditingController();
  TextEditingController passwdCtro = TextEditingController();

  TextEditingController phonedCtro = TextEditingController();
  TextEditingController validCodeCtro = TextEditingController();

  _accountLogin() async {
    var resp = await UserApi.accountLogin(accountCtro.text, passwdCtro.text);
    if (resp == null) {
      return;
    }
    if (resp.code != null && resp.code == 0) {
      // Hive.box(Keys.hiveUserInfo).put(Keys.token, resp.data);

      IsarHelper.instance.isarInstance.writeTxn(() async {
        AnyEntity any = new AnyEntity(keyName: Keys.token, anything: resp.data);
        await IsarHelper.instance.isarInstance.anyEntitys.put(any);
      });
      Get.offAndToNamed(Routes.root);
    }
  }
}
