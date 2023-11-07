import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/any_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/views/mine/user_info.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  bool dayOrNight = true;
  // final userInfoBox = Hive.box(Keys.hiveUserInfo);

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
        child: ListView(
          children: [
            // 白天 黑夜
            ListTile(
              leading: Switch(value: dayOrNight, onChanged: (v) {}),
              title: Text('白天/黑夜'),
            ),

            // 退出
            Card(
              child: ListTile(
                title: Text('退出'),
                onTap: () {
                  // userInfoBox.delete(Keys.token);
                  IsarHelper.instance.isarInstance.anyEntitys.filter().keyNameEqualTo(Keys.token).deleteAll();
                  Get.offAllNamed(Routes.login);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
