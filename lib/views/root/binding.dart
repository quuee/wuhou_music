
import 'package:get/get.dart';
import 'package:wuhoumusic/views/home/home_controller.dart';
import 'package:wuhoumusic/views/home/tabs/hot_tab_controller.dart';
import 'package:wuhoumusic/views/root/root_controller.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_controller.dart';
import 'package:wuhoumusic/views/video/video_page_controller.dart';

class RootBinding implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<RootController>(() => RootController());

    // 找不到HomeController
    // 因为只有Get.toNamed('/root')，bindings才会生效；切换选项卡对这没有任何影响。
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SongsListController>(() => SongsListController());
    Get.lazyPut<VideoPageController>(() => VideoPageController());

    Get.lazyPut<HotTabController>(() => HotTabController());


  }


}