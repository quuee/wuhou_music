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
          // color: Colors.grey[200],
          border: Border.all(),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search),
            Expanded(
              flex: 1,
              child: TextField(
                decoration: //装饰
                    InputDecoration(
                      isDense: true,//特殊属性isDense,作用是在较小空间时，使组件正常渲染（包括文本垂直居中）
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  fillColor: Colors.transparent,
                  hintText: '请开始搜索',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
                style: TextStyle(
                  fontSize: 14,
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
