import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/home/tabs/hot_tab.dart';
import 'package:wuhoumusic/views/home/tabs/rank_tab.dart';
import 'package:wuhoumusic/views/home/tabs/singer_tab.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List tabs = ["热门", "排行", "歌手"];
  List<Widget> tabsPage = [HotTab(),RankTab(),SingerTab()];
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: tabs.length, vsync: this)
      ..addListener(() {
        LogD('HomeController', '_tabController.index:${tabController?.index}');
      });
  }

}
