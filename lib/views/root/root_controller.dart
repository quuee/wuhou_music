
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/views/home/home_page.dart';
import 'package:wuhoumusic/views/mine/mine_page.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_page.dart';
import 'dart:developer' as developer;


class RootController extends GetxController{

  RxInt bottomBarIndex = 0.obs;

  List bodyPage = [
    HomePage(),
    SongsListPage(),
    MinePage(),
  ];

  List<BottomNavigationBarItem> barList = [
    const BottomNavigationBarItem(icon: Icon(AliIcons.music,), label: '首页',),
    const BottomNavigationBarItem(icon: Icon(Icons.queue_music_sharp), label: '歌单',),
    const BottomNavigationBarItem(icon: Icon(AliIcons.mine), label: '我',),
  ];

  changeBottomBarIndex(int index){
    developer.log('changeBottomBarIndex:$index',name: 'RootController');
    bottomBarIndex.value = index;
  }

  @override
  void onInit() {
    developer.log('onInit',name: 'RootController');
    // int index = Get.arguments;
    // bottomBarIndex.value = index;
    super.onInit();
  }

  @override
  void onReady() {
    developer.log('onReady',name: 'RootController');
    super.onReady();
  }

}