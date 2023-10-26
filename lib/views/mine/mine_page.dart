import 'dart:developer' as developer;
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_list.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/views/mine/mine_controller.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  MineController controller = Get.find<MineController>();

  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onRefresh() async {
    developer.log('onRefresh', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    controller.loadSongList();
    if (!mounted) {
      return;
    }
    setState(() {});
    _controller.finishRefresh();
    _controller.resetFooter();
  }

  onLoading() async {
    developer.log('onLoading', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    controller.loadSongList();
    _controller.finishLoad(IndicatorResult.success);
  }

  /// 创建顶部四个功能按钮
  Widget _buildIconButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.localMusicPage);
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.scanner),
              SizedBox(
                height: 8,
              ),
              const Text('本地歌曲')
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.addOrUpdateSongListDialog(null);
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_chart),
              SizedBox(
                height: 8,
              ),
              Text('创建歌单'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(
                height: 8,
              ),
              Text('待定'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(
                height: 8,
              ),
              Text('待定'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSongListWidget() {
    return GetBuilder<MineController>(builder: (c) {
      return EasyRefresh(
        header: ClassicHeader(),
        footer: ClassicFooter(),
        onRefresh: onRefresh,
        onLoad: onLoading,
        child: ListView.builder(
            itemCount: c.songList!.length,
            itemBuilder: (context, index) {
              return SongList(
                id: c.songList![index].id,
                listTitle: c.songList![index].listTitle,
                count: c.songList![index].count,
                listAlbum: c.songList![index].listAlbum,
              );
            }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                color: Colors.deepPurple[100],
                child: Column(
                  children: [
                    /// 功能按钮
                    Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border:
                                  Border.all(width: 0.5, color: Colors.white70),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: _buildIconButton())),

                    /// 歌单
                    Expanded(
                      flex: 6,
                      child: _buildSongListWidget(),
                    ),

                    /// 播放栏
                    // Expanded(
                    //   flex: 1,
                    //   child: SizedBox(
                    //     /// Positioned不能自适应宽度
                    //     width: MediaQuery.of(context).size.width,
                    //     child: PlayBar(),
                    //   ),
                    // ),
                  ],
                ),
              ),

              /// 浮动的播放栏
              Positioned(
                  bottom: 0.5,
                  child: SizedBox(
                    /// Positioned不能自适应宽度
                    width: MediaQuery.of(context).size.width,
                    child: PlayBar(),
                  ))
            ],
          ),
        ));
  }
}
