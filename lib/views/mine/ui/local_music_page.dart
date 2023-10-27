import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/resource/loading_status.dart';

import 'package:wuhoumusic/views/mine/mine_controller.dart';
import 'package:wuhoumusic/views/mine/ui/Local_music_controller.dart';

class LocalMusicPage extends GetView<LocalMusicController> {
  const LocalMusicPage({super.key});

  /// 底部弹窗
  bottomSheet() {
    Get.bottomSheet(
        Container(
          // 加点样式
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.ring_volume),
                title: Text('设为铃声'),
                onTap: null,
              ),
              ListTile(
                leading: Icon(Icons.add_card_outlined),
                title: Text('添加到歌单'),
                onTap: () {
                  Get.back();

                  collectBottomSheet();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_forever),
                title: Text('本地删除'),
                onTap: null,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white, // bottomsheet背景色
        barrierColor: Colors.white60 // 后面挡住的颜色
        );
  }

  /// 收藏到歌单
  collectBottomSheet() {
    MineController controller = Get.find<MineController>();
    List<Widget> list = controller.songList!
        .map((e) => ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(e.listTitle),
              onTap: () {
                // controller.addSongToSongList(e.id, );
              },
            ))
        .toList();
    list.insert(
        0,
        ListTile(
          leading: Icon(Icons.add),
          title: Text('新建歌单'),
        ));
    Get.bottomSheet(
        Container(
          child: Wrap(
            children: list,
          ),
        ),
        backgroundColor: Colors.white, // bottomsheet背景色
        barrierColor: Colors.white60 // 后面挡住的颜色
        );
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    widget = GetBuilder<LocalMusicController>(builder: (c) {
      if (controller.loadingStatus == LoadingStatus.loading) {
        return Center(
          child: Text('加载中。。。'),
        );
      }
      if (controller.loadingStatus == LoadingStatus.success) {
        return ListView.builder(
            itemCount: c.songs?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: buildSongItem(
                  index: index,
                  songTitle: c.songs![index].title,
                  singer: c.songs![index].artist,
                  album: c.songs![index].album,
                  moreFunction: bottomSheet
                ),
              );
            });
      }
      if (controller.loadingStatus == LoadingStatus.failed) {
        return Center(
          child: Text('加载失败。。。'),
        );
      }
      return SizedBox.shrink();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('本地音乐'),
      ),
      bottomNavigationBar: PlayBar(),
      body: widget,
    );
  }
}
