import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/views/home/tabs/hot_tab.dart';
import 'package:wuhoumusic/views/home/tabs/rank_tab.dart';
import 'package:wuhoumusic/views/home/tabs/singer_tab.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List tabs = ["热门", "排行", "歌手"];
  final List<Widget> tabsPage = [HotTab(),RankTab(),SingerTab()];
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: tabs.length, vsync: this)
      ..addListener(() {
        developer.log('_tabController.index:${tabController?.index}',
            name: 'GetxController');
      });
  }
}
