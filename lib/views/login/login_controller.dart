
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wuhoumusic/api/user_api.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/routes/app_routes.dart';

class LoginController extends GetxController{

  TextEditingController accountCtro = TextEditingController();
  TextEditingController passwdCtro = TextEditingController();

  TextEditingController phonedCtro = TextEditingController();
  TextEditingController validCodeCtro = TextEditingController();

  final userInfoBox = Hive.box(Keys.hiveUserInfo);

  accountLogin() async {

    var resp = await UserApi.accountLogin(accountCtro.text, passwdCtro.text);
    if(resp == null){
      return;
    }
    if(resp.code!=null && resp.code==0){
      userInfoBox.put(Keys.token, resp.data);
      Get.offAndToNamed(Routes.root);
    }

  }
}