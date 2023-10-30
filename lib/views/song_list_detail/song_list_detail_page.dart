import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/resource/ali_icons.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'package:wuhoumusic/views/song_list_detail/song_list_detail_controller.dart';
import 'package:wuhoumusic/views/song_list_detail/ui/song_list_cover.dart';
import 'package:wuhoumusic/views/song_list_detail/ui/my_sliver_persistent_header_delegate.dart';

class SongListDetailPage extends GetView<SongListDetailController> {
  SongListDetailPage({super.key});

  _buildSongs(List<SongEntity> songs, int index) {
    File song = File(songs[index].data!);
    bool fileExit = song.existsSync();
    return Dismissible(
      key: Key(songs[index].id),
      direction: DismissDirection.endToStart,
      background: Container(
        child: Icon(Icons.delete),
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        controller.deleteSongInSongList(songs[index].id);
      },
      child: InkWell(
          onTap: () {
            if (fileExit) PlayInvoke.init(songList: songs, index: index);
          },
          child: Container(
            color: fileExit ? Colors.white : Colors.grey[400],
            child: SongItem(
              index: index,
              songEntity: songs[index],
            ),
          )),
    );
  }

  _buildFeatureBar() {
    return Container(
      color: Colors.grey[200],
      // height: 60,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.play_circle,
                size: 35,
              ),
              Text(
                '播放全部',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(onPressed: () {}, icon: Icon(Icons.music_note)),
              IconButton(onPressed: () {}, icon: Icon(AliIcons.music_add_line)),
              IconButton(onPressed: () {}, icon: Icon(AliIcons.sync)),
              IconButton(
                  onPressed: () {}, icon: Icon(AliIcons.list_choose_line)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> param = Get.arguments as Map<String, dynamic>;
    developer.log('${Get.parameters}', name: 'SongListDetailPage');
    String songTitle = Get.parameters['title'] ?? '未知';
    String coverImage = Get.parameters['coverImage'] ?? '';

    return Scaffold(
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

          return CustomScrollView(
            shrinkWrap: false,
            primary: true,
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                // expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    songTitle,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
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
                  songListUUID: c.songListUUID!,
                  songListTitle: songTitle,
                  songListCoverImagePath: coverImage,
                ),
              ),

              // 固定
              SliverPersistentHeader(
                pinned: true,
                delegate: MySliverPersistentHeaderDelegate(
                    minHeight: 48, maxHeight: 48, child: _buildFeatureBar()),
              ),

              // SliverFillRemaining(
              //   child: _buildSongs(c.songs),
              // )
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: c.songs.length, (context, index) {
                return _buildSongs(c.songs, index);
                // listView + inkWell 有按下去样式，这个没有了
              })),
            ],
          );
        }
        return SizedBox.shrink();
      }),
      bottomNavigationBar: PlayBar(),
    );
  }
}
