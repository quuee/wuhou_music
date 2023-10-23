import 'package:flutter/material.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/views/home/tabs/hot_tab.dart';
import 'package:wuhoumusic/views/home/tabs/rank_tab.dart';
import 'package:wuhoumusic/views/home/tabs/singer_tab.dart';

/// 热门 排行
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List tabs = ["热门", "排行", "歌手"];
  List<Widget> tabsPage = [HotTab(),RankTab(),SingerTab()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        // print(_tabController.index);
        developer.log('_tabController.index:${_tabController.index}',name: 'HomePage');
      });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
                          hintText: '请输入关键字',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
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
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            )),
        body: TabBarView(
          controller: _tabController,
          children: tabsPage
        ),
      ),
    );
  }
}
