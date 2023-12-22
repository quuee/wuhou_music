import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/views/video/video_page_controller.dart';
import 'package:wuhoumusic/views/video/video_widget.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPageController videoPageController;

  @override
  void initState() {
    videoPageController = Get.find<VideoPageController>();
    super.initState();
    videoPageController.loadVideoList();
  }

  @override
  void dispose() {
    videoPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0, right: 0, top: 0, bottom: 0, child: _buildTabBarView()),
          Positioned(
              left: 0, right: 0, top: 25, bottom: 0, child: _buildTabBar())
        ],
      ),
    );
  }

  _buildTabBar() {
    return Container(
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: videoPageController.tabController,
        tabs: videoPageController.tabs
            .map((e) => Tab(
                  text: e,
                ))
            .toList(),
        // indicatorColor: Colors.white,
        // indicatorWeight: 2,
        // indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        isScrollable: true,
      ),
    );
  }

  _buildTabBarView() {
    return TabBarView(controller: videoPageController.tabController, children: [
      _buildTabScreen(videoPageController.tabController.index),
      _buildTabScreen(videoPageController.tabController.index),
      _buildTabScreen(videoPageController.tabController.index)
    ]);
  }

  _buildTabScreen(int index) {
    Widget child;
    if (videoPageController.videos != null) {
      child = GetBuilder<VideoPageController>(
        id: 'video_player',
        builder: (controller) {
          return PageView.builder(
            controller: videoPageController.pageController,
            itemCount: videoPageController.videos!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return VideoWidget(
                  contentHeight: MediaQuery.of(context).size.height,
                  video: videoPageController.videos![index]);
              // TODO 视频滑一点就播放下个视频，应该滑动大点才能播放
            },
            onPageChanged: (index) {},
          );
        },
      );
    } else {
      child = SizedBox.shrink();
    }

    return Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: child);
  }
}
