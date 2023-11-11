
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/home/home_page.dart';
import 'package:wuhoumusic/views/mine/mine_page.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_page.dart';
import 'package:wuhoumusic/views/video/video_page.dart';



class RootController extends GetxController{

  RxInt bottomBarIndex = 0.obs;

  List bodyPage = [
    HomePage(),
    SongsListPage(),
    VideoPage(),
    MinePage(),
  ];

  List<BottomNavigationBarItem> barList = [
    const BottomNavigationBarItem(icon: Icon(AliIcons.music,), label: '首页',),
    const BottomNavigationBarItem(icon: Icon(Icons.queue_music_sharp), label: '歌单',),
    const BottomNavigationBarItem(icon: Icon(Icons.ondemand_video), label: '视频',),
    const BottomNavigationBarItem(icon: Icon(AliIcons.mine), label: '我',),
  ];

  changeBottomBarIndex(int index){
    LogD('RootController', 'changeBottomBarIndex:$index');
    bottomBarIndex.value = index;
  }

  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

}