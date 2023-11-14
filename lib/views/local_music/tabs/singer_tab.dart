import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'package:wuhoumusic/views/local_music/local_music_controller.dart';

class SingerTab extends StatefulWidget {
  const SingerTab({super.key});

  @override
  State<SingerTab> createState() => _SingerTabState();
}

class _SingerTabState extends State<SingerTab> {
  //分组

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/singer_tab',
      onGenerateRoute: (RouteSettings settins) {
        WidgetBuilder builder = (context) => SizedBox.shrink();
        switch (settins.name) {
          case '/singer_tab':
            builder = (context) {
              return _buildSinger(context);
            };
            break;
        }
        return MaterialPageRoute(builder: builder);
      },
    );
  }

  Widget _buildSinger(BuildContext context) {
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
              return ListTile(
                title: Text(map.keys.elementAt(index)),
                onTap: () {
                  // 跳转到歌手下的歌曲
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Scaffold(
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        body: ListView(
                          children: [
                            ListView.builder(
                                shrinkWrap: true, // 多层嵌套滚动必须加shrinkWrap: true
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                map.entries.elementAt(index).value.length,
                                itemBuilder: (context, index2) {
                                  return InkWell(
                                    onTap: () {
                                      PlayInvoke.init(
                                          songList:
                                          map.entries.elementAt(index).value,
                                          index: index2);
                                    },
                                    child: SongItem(
                                      index: index2,
                                      songEntity: map.entries
                                          .elementAt(index)
                                          .value[index2],
                                    ),
                                  );
                                }),
                          ],
                        )
                    );
                  }));
                },
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
