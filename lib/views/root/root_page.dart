import 'package:flutter/material.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/utils/event_bus.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/book_shelf/book_shelf.dart';
import 'package:wuhoumusic/views/home/home_page.dart';
import 'package:wuhoumusic/views/mine/mine_page.dart';
import 'package:wuhoumusic/views/songs_list/songs_list_page.dart';
import 'package:wuhoumusic/views/video/video_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  List bodyPage = [
    HomePage(),
    SongsListPage(),
    VideoPage(),
    BookShelfPage(),
    MinePage(),
  ];

  List<BottomNavigationBarItem> barList = [
    const BottomNavigationBarItem(
      icon: Icon(
        AliIcons.music,
      ),
      label: '首页',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.queue_music_sharp),
      label: '歌单',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.ondemand_video),
      label: '视频',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu_book_outlined),
      label: '书架',
    ),
    const BottomNavigationBarItem(
      icon: Icon(AliIcons.mine),
      label: '我',
    ),
  ];

  int bottomBarIndex = 0;

  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))..forward();

    eventBus.on<bool>().listen((event) {
      LogD('eventBus', event.toString());
      event ? animationController.reverse() : animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  changeBottomBarIndex(int index) {
    LogD('changeBottomBarIndex', 'changeBottomBarIndex:$index');
    setState(() {
      bottomBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyPage[bottomBarIndex],
      bottomNavigationBar: SizeTransition(
          axis: Axis.vertical,
          sizeFactor: animationController,
          axisAlignment: -1.0,
          child: BottomNavigationBar(
              items: barList,
              currentIndex: bottomBarIndex,
              onTap: (index) => changeBottomBarIndex(index))),
    );
  }
}
