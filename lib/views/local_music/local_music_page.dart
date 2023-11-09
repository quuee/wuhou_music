import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/views/local_music/local_music_controller.dart';

class LocalMusicPage extends GetView<LocalMusicController> {
  const LocalMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地音乐'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
        bottom: TabBar(
            controller: controller.tabController,
            tabs: controller.tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
      ),
      bottomNavigationBar: PlayBar(),
      body: TabBarView(
        controller: controller.tabController,
        children: controller.tabsPage,
      ),
    );
  }


}
