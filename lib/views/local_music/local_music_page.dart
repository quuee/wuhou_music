import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'package:wuhoumusic/views/local_music/local_music_controller.dart';

class LocalMusicPage extends GetView<LocalMusicController> {
  const LocalMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地音乐'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
        bottom: TabBar(
            controller: controller.tabController,
            tabs: controller.tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
      ),
      bottomNavigationBar: PlayBar(),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          buildSingleLocalSongsWidget(),
          buildArtistLocalSongsWidget(),
          buildDirectoryLocalSongsWidget()
        ],
      ),
    );
  }

  /// 默认不分组
  Widget buildSingleLocalSongsWidget() {
    return GetBuilder<LocalMusicController>(builder: (c) {
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

  /// 按歌手
  buildArtistLocalSongsWidget() {
    return GetBuilder<LocalMusicController>(builder: (c) {
      Map<String, List<SongEntity>> map = Map.fromIterable(c.songs,
          key: (e) => e.artist,
          value: (value) {
            return c.songs
                .where((element) => element.artist.compareTo(value.artist) == 0)
                .toList();
          });

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
            // 第一层 分组信息
            itemCount: map.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(map.keys.elementAt(index)),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: map.entries.elementAt(index).value.length,
                      itemBuilder: (context, index2) {
                        return InkWell(
                          onTap: () {
                            PlayInvoke.init(songList: c.songs, index: index);
                          },
                          child: SongItem(
                            index: index2,
                            songEntity:
                                map.entries.elementAt(index).value[index2],
                          ),
                        );
                      })
                ],
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

  /// 按文件夹
  buildDirectoryLocalSongsWidget() {
    return GetBuilder<LocalMusicController>(builder: (c) {

      Map<String, List<SongEntity>> map = Map.fromIterable(
          c.songs,
          key: (e) => e.data!.substring(0,e.data!.lastIndexOf('/')).substring(0,e.data!.lastIndexOf('/')),
          value: (value) {
            return c.songs
                .where((element) => element.data!.substring(0,element.data!.lastIndexOf('/')).substring(0,element.data!.lastIndexOf('/')).compareTo(value.data!.substring(0,element.data!.lastIndexOf('/')).substring(0,element.data!.lastIndexOf('/'))) == 0)
                .toList();
          });

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
            // 第一层 分组信息
            itemCount: map.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(map.keys.elementAt(index)),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: map.entries.elementAt(index).value.length,
                      itemBuilder: (context, index2) {
                        return InkWell(
                          onTap: () {
                            PlayInvoke.init(songList: c.songs, index: index);
                          },
                          child: SongItem(
                            index: index2,
                            songEntity:
                                map.entries.elementAt(index).value[index2],
                          ),
                        );
                      })
                ],
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
