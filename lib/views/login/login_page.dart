import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/views/login/login_controller.dart';



class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// 底层背景
          Image.asset(
            R.images.bg1,
            fit: BoxFit.fill,
            // 须设置宽高，不然铺不满
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),

          Column(
            children: [
              Expanded(
                flex: 2,
                child:
                    ///标题
                    Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Text(
                        '登录',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: R.fonts.puHuiTiX,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 6,
                child:
                    ///输入框
                    ///登录按钮
                    ///忘记密码
                    Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    border: Border.all(width: 0.5, color: Colors.white60),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                            labelText: "用户名",
                            hintText: "用户名或邮箱",
                            prefixIcon: Icon(Icons.person)),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "密码",
                            hintText: "您的登录密码",
                            prefixIcon: Icon(Icons.lock)),
                        obscureText: true,
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('登录'))
                    ],
                  ),
                ),
              ),

              ///暂不登录 跳过 （底部）
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 15),
                    width: MediaQuery.of(context).size.width - 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAndToNamed(Routes.root);
                      },
                      child: Text('跳过'),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
