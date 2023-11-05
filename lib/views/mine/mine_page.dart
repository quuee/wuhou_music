import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  bool dayOrNight = true;
  final userInfoBox = Hive.box(Keys.hiveUserInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // 个人信息 或 点我登录
            Card(
              child: Column(
                children: [
                  Image.network("https://avatars.githubusercontent.com/u/33923687?v=4", errorBuilder: (c, e, s) {
                    return ClipOval(
                      child: Image.asset(
                        R.images.tom,
                      ),
                    );
                  }),
                  Text('站直了别趴下')
                ],
              ),
            ),

            // 最近听过

            //
          ],
        ),
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
                  userInfoBox.delete(Keys.token);
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
