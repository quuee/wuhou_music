
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/views/home/home_page.dart';
import 'package:wuhoumusic/views/mine/mine_page.dart';
import 'dart:developer' as developer;

class RootController extends GetxController{

  RxInt bottomBarIndex = 0.obs;

  List bodyPage = [
    HomePage(),
    MinePage()
  ];

  List<BottomNavigationBarItem> barList = [
    const BottomNavigationBarItem(icon: Icon(AliIcons.music,), label: '首页',),
    const BottomNavigationBarItem(icon: Icon(AliIcons.mine), label: '我的',),
  ];

  changeBottomBarIndex(int index){
    // print('changeBottomBarIndex:$index');
    developer.log('changeBottomBarIndex:$index',name: 'RootController');
    bottomBarIndex.value = index;
  }

}