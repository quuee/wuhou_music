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
  VideoPageController videoPageController = Get.find<VideoPageController>();

  @override
  void initState() {
    super.initState();
    videoPageController.loadVideoList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: TabBar( // TODO tab应该放stack
            controller: videoPageController.tabController,
            tabs: videoPageController.tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
      ),
      body:
          TabBarView(controller: videoPageController.tabController, children: [
        _buildTabScreen(videoPageController.tabController.index),
        _buildTabScreen(videoPageController.tabController.index),
        _buildTabScreen(videoPageController.tabController.index)
      ]),
    );
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
            onPageChanged: (index) {

            },
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
