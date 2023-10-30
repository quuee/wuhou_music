import 'package:flutter/material.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/views/home/home_controller.dart';

buildAppBar({required HomeController controller}) {

  return AppBar(
    leading: Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: ClipOval(
        child: Image.asset(
          R.images.tom,
        ),
      ),
    ),
    centerTitle: true,
    title: Container(
        height: 36,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(Icons.search),
            Expanded(
              flex: 1,
              child: TextField(
                decoration: //装饰
                    InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: '搜索歌曲',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            )
          ],
        )),
    actions: [
      IconButton(onPressed: () {}, tooltip: "扫一扫", icon: Icon(Icons.qr_code)),
      IconButton(onPressed: () {}, tooltip: "添加", icon: Icon(Icons.add))
    ],
    actionsIconTheme: IconThemeData(size: 32),
    bottom: TabBar(
        controller: controller.tabController,
        tabs: controller.tabs
            .map((e) => Tab(
                  text: e,
                ))
            .toList()),
  );
}
