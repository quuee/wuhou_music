import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'package:wuhoumusic/views/local_music/local_music_controller.dart';

class DirectoryTab extends StatefulWidget {
  const DirectoryTab({super.key});

  @override
  State<DirectoryTab> createState() => _DirectoryTabState();
}

class _DirectoryTabState extends State<DirectoryTab> {
  //分组
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/directory_tab',
      onGenerateRoute: (RouteSettings settins) {
        WidgetBuilder builder = (context) => SizedBox.shrink();
        switch (settins.name) {
          case '/directory_tab':
            builder = (context) {
              return _buildDirectory(context);
            };
            break;
        }
        return MaterialPageRoute(builder: builder);
      },
    );
  }

  Widget _buildDirectory(BuildContext context) {
    return GetBuilder<LocalMusicController>(builder: (c) {

      // TODO 这里计算有点慢 应该放controller里，页面搞个加载中
      Map<String, List<SongEntity>> map = Map.fromIterable(c.songs,
          key: (e) => e.data!
              .substring(0, e.data!.lastIndexOf('/'))
              .substring(0, e.data!.lastIndexOf('/')),
          value: (value) {
            return c.songs
                .where((element) =>
                    element.data!
                        .substring(0, element.data!.lastIndexOf('/'))
                        .substring(0, element.data!.lastIndexOf('/'))
                        .compareTo(value.data!
                            .substring(0, element.data!.lastIndexOf('/'))
                            .substring(0, element.data!.lastIndexOf('/'))) ==
                    0)
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
                  // 跳转到文件下的歌曲
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
                                          songList: map.entries
                                              .elementAt(index)
                                              .value,
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
                        ));
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
