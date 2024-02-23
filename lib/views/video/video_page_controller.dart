import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/flavors/build_config.dart';
import 'package:wuhoumusic/model/video/video_entity.dart';
import 'package:wuhoumusic/utils/log_util.dart';

class VideoPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List tabs = ["热门", "推荐", "关注"];

  static final String minioUrl = BuildConfig.instance.config.minioUrl;

  late TabController tabController;

  late PageController pageController;

  List<VideoEntity>? videos;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(
        length: tabs.length, vsync: this, initialIndex: 1)
      ..addListener(() {
        LogD('VideoPageController', 'tabController.index:${tabController.index}');
      });

    pageController = PageController()..addListener(() {
      LogD('VideoPageController', 'pageController.index:${pageController.initialPage}');
    });

  }

  @override
  void onReady() {
    super.onReady();
  }

  loadVideoList(){
    LogD('VideoPageController loadVideoList', '加载视频');
    videos = [
      VideoEntity(vid: 1, videoTitle: 'something like this', videoUrl: '$minioUrl/videos/Romy%20Wave%E6%96%B0%E7%BF%BB%E5%94%B1%E5%8D%95%E6%9B%B2_Something%20Just%20Like%20This.mp4'),
      VideoEntity(vid: 2, videoTitle: 'wudiao', videoUrl: '$minioUrl/videos/2021-12-15 08.25.42 v0d00fg10000c47jeu3c77ua7580lppg.mp4'),
      VideoEntity(vid: 3, videoTitle: 'something like this', videoUrl: '$minioUrl/videos/2021-12-15 08.25.42 v0300fg10000c43u6ojc77udh4t6tal0.mp4'),
      VideoEntity(vid: 3, videoTitle: 'something like this', videoUrl: '$minioUrl/videos/2021-12-15 08.25.42 IMG_0631.mp4'),
      VideoEntity(vid: 3, videoTitle: 'something like this', videoUrl: '$minioUrl/videos/share_246aed7274af43a4e79f3a08ed073851.mp4'),
      VideoEntity(vid: 3, videoTitle: 'something like this', videoUrl: '$minioUrl/videos/share_3041bae634fff5b669f4e2d8934f86d0.mp4'),
      VideoEntity(vid: 3, videoTitle: 'something like this', videoUrl: '$minioUrl/videos/share_6f637e2ba27b35de08bf9ea55c657b0c.mp4'),
    ];

    update(['video_player']);
  }

  @override
  void onClose() {

    tabController.dispose();
    pageController.dispose();
    super.onClose();
  }
}
