import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'package:wuhoumusic/views/local_music/local_music_controller.dart';

class LocalMusicPage extends GetView<LocalMusicController> {
  const LocalMusicPage({super.key});

  // 单曲 歌手 封面 文件夹

  @override
  Widget build(BuildContext context) {
    Widget widget;
    widget = GetBuilder<LocalMusicController>(builder: (c) {
      if (c.loadingStatus == LoadingStatus.loading) {
        return Center(
          child: Text('加载中。。。'),
        );
      }
      if (c.loadingStatus == LoadingStatus.success) {
        if(c.songs.isEmpty) return Center(child: Text('空空如也'),);
        return ListView.builder(
            itemCount: c.songs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  PlayInvoke.init(songList: c.songs, index: index);
                },
                child: SongItem(
                  index: index,
                  songEntity: c.songs[index],
                ),
              );
            });
      }
      if (c.loadingStatus == LoadingStatus.failed) {
        return Center(
          child: Text('加载失败。。。'),
        );
      }
      return SizedBox.shrink();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('本地音乐'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),
      bottomNavigationBar: PlayBar(),
      body: widget,
    );
  }
}
