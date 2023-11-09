import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/any_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/theme/app_theme.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/views/mine/user_info.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  late bool darkMode;
  @override
  void initState() {
    super.initState();

    AnyEntity? a = IsarHelper.instance.isarInstance.anyEntitys
        .filter()
        .keyNameEqualTo(Keys.isDarkMode)
        .findFirstSync();
    if (a == null) {
      darkMode = false;
    } else {
      darkMode = int.parse(a.anything) == 0 ? false : true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // 个人信息 或 点我登录
              MyInfo()
            ],
          )

          // 最近听过

          //

          ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 2,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('白天'),
                Switch(
                    inactiveThumbColor: Colors.yellow, // 关闭时 滑块颜色
                    inactiveTrackColor: Colors.white, // 关闭时 轨道颜色
                    activeColor: Colors.black, // 打开时 滑块颜色
                    activeTrackColor: Colors.grey, // 打开时 轨道颜色
                    value: darkMode,
                    onChanged: (v) {
                      setState(() {
                        darkMode = v;
                      });
                      if (v) {
                        Get.changeTheme(darkTheme);
                      } else {
                        Get.changeTheme(lightTheme);
                      }
                      var anyEntity = new AnyEntity(
                          keyName: Keys.isDarkMode,
                          anything: darkMode ? '1' : '0');
                      IsarHelper.instance.isarInstance.writeTxn(() => IsarHelper
                          .instance.isarInstance.anyEntitys
                          .put(anyEntity));
                    }),
                Text('黑夜'),
              ],
            ),
            Container(

              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  // userInfoBox.delete(Keys.token);
                  IsarHelper.instance.isarInstance.anyEntitys
                      .filter()
                      .keyNameEqualTo(Keys.token)
                      .deleteAll();
                  Get.offAllNamed(Routes.login);
                },
                child: Text('退出'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
