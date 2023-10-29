import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'package:wuhoumusic/views/mine/ui/song_list_detail_controller.dart';

class SongListDetailPage extends GetView<SongListDetailController> {
  SongListDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> param = Get.arguments as Map<String, dynamic>;
    developer.log('${Get.parameters}', name: 'SongListDetailPage');
    String songTitle = Get.parameters['title'] ?? '未知';

    return Scaffold(
      appBar: AppBar(
        title: Text('歌单'),
      ),
      // bottomNavigationBar: PlayBar(),
      body: GetBuilder<SongListDetailController>(builder: (c) {
        if (c.loadingStatus == LoadingStatus.loading) {
          return Center(
            child: Text('加载中。。。'),
          );
        }
        if (c.loadingStatus == LoadingStatus.success) {
          if (c.songs.isEmpty)
            return Center(
              child: Text('空空如也'),
            );
          return ListView.builder(
              itemCount: c.songs.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(c.songs[index].id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    child: Icon(Icons.delete),
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                  ),
                  onDismissed: (direction) {
                    c.deleteSongInSongList(c.songs[index].id);
                  },
                  child: InkWell(
                      onTap: () {
                        PlayInvoke.init(songList: c.songs, index: index);
                      },
                      child: Container(
                        child: SongItem(
                          index: index,
                          songEntity: controller.songs[index],
                        ),
                      )),
                );
              });
        }
        return SizedBox.shrink();
      }),
      bottomNavigationBar: PlayBar(),
    );
  }
}
