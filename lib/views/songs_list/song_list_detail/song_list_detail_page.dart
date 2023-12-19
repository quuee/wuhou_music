import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'package:wuhoumusic/views/songs_list/song_list_detail/song_list_detail_controller.dart';
import 'package:wuhoumusic/views/songs_list/song_list_detail/ui/my_sliver_persistent_header_delegate.dart';
import 'package:wuhoumusic/views/songs_list/song_list_detail/ui/song_list_cover.dart';


class SongListDetailPage extends GetView<SongListDetailController> {
  SongListDetailPage({super.key});

  _buildSongs(List<SongEntity> songs, int index) {
    File song = File(songs[index].data!);
    bool fileExit = song.existsSync();

    final songWidget;
    if (fileExit) {
      songWidget = SongItem(
        index: index,
        songEntity: songs[index],
        fileExist: true,
      );
    } else {
      songWidget = SongItem(
        index: index,
        songEntity: songs[index],
        fileExist: false,
      );
    }
    return Dismissible(
        key: Key(songs[index].id),
        direction: DismissDirection.endToStart,
        background: Container(
          child: Icon(Icons.delete),
          color: Colors.redAccent,
          alignment: Alignment.centerRight,
        ),
        onDismissed: (direction) {
          controller.deleteSongInSongList(songs[index].sid!);
        },
        child: Ink(
          // color: fileExit ? Colors.white : Colors.grey[400],
          child: InkWell(
              onTap: () {
                if (fileExit) PlayInvoke.init(songList: songs, index: index);
              },
              child: songWidget),
        ));
  }

  _buildFeatureBar() {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              PlayInvoke.init(songList: controller.songs, index: 0);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.play_circle,
                  size: 35,
                  color: Colors.lightGreen,
                ),
                Text(
                  '播放全部',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.songListAdd);
                  },
                  icon: Icon(AliIcons.music_add_line)),
              IconButton(onPressed: () {}, icon: Icon(AliIcons.sync)),
              IconButton(
                  onPressed: () {}, icon: Icon(AliIcons.list_choose_line)),
            ],
          )
        ],
      ),
    );
  }

  _buildCenterPage(String songTitle, String coverImage) {
    return CustomScrollView(
      shrinkWrap: false,
      primary: true,
      slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              songTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
        ),
        // 封面 可被隐藏
        SliverToBoxAdapter(
          child: SongListCover(
            songsListId: controller.apslid!,
            songsListTitle: songTitle,
            songsListCoverImagePath: coverImage,
          ),
        ),

        // 固定
        SliverPersistentHeader(
          pinned: true,
          delegate: MySliverPersistentHeaderDelegate(
              minHeight: 48, maxHeight: 48, child: _buildFeatureBar()),
        ),

        // SliverFillRemaining(
        //   //利用剩余空间填满
        //   child: _buildSongs(c.songs),
        // )
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: controller.songs.length, (context, index) {
          return _buildSongs(controller.songs, index);
        }))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> param = Get.arguments as Map<String, dynamic>;
    String songTitle = Get.parameters['title'] ?? '未知';
    String coverImage = Get.parameters['coverImage'] ?? '';

    return Scaffold(

      body: GetBuilder<SongListDetailController>(
          // id: 'songListDetail',
          builder: (c) {
        if (c.loadingStatus == LoadingStatus.loading) {
          return Center(
            child: Text('加载中。。。'),
          );
        }
        if (c.loadingStatus == LoadingStatus.success) {
          return _buildCenterPage(songTitle, coverImage);
        }
        return SizedBox.shrink();
      }),
      bottomNavigationBar: PlayBar(),
    );
  }
}
