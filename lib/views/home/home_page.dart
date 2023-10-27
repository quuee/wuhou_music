import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/views/home/home_app_bar.dart';

import 'package:wuhoumusic/views/home/home_controller.dart';

/// 热门 排行
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(controller: controller),
      body: TabBarView(
          controller: controller.tabController, children: controller.tabsPage),
    );
  }
}
