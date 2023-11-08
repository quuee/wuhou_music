
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'package:wuhoumusic/views/local_music/local_music_controller.dart';

class SingleSongTab extends StatefulWidget {
  const SingleSongTab({super.key});

  @override
  State<SingleSongTab> createState() => _SingleSongTabState();
}

class _SingleSongTabState extends State<SingleSongTab> {
  @override
  Widget build(BuildContext context) {

    return  GetBuilder<LocalMusicController>(builder: (c) {
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
  }
}
