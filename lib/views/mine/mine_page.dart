import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_list.dart';
import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static final audioPlayHandler = GetIt.I.get<AudioPlayerHandler>();

  List<SongListEntity>? songList;

  @override
  initState(){
    super.initState();
    var box = Hive.box('songList');
    // todo 从hive获取本地歌单
  }

  /// 创建歌单的中间弹窗
  _createSongListInput(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('请输入歌单名称'),
            content: TextField(
              onChanged: (value) {},
            ),
            actions: [
              ElevatedButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('确认'),
                onPressed: () {
                  // 逻辑
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  /// 创建顶部四个功能按钮
  Widget _buildIconButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.scanner),
              onPressed: () {
                Get.toNamed(Routes.localMusicPage);
              },
            ),
            const Text('本地歌曲')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add_chart),
              onPressed: () {
                _createSongListInput(context);

              },
            ),
            Text('创建歌单')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
            Text('待定')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
            Text('待定')
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            color: Colors.deepPurple[100],
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(width: 0.5, color: Colors.white70),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _buildIconButton())),
                Expanded(
                    flex: 6,
                    child: ListView(

                        ///歌单
                        children: [
                          SongList(
                            albumURI: 'images/wallhaven-wydwyr_2560x1440.png',
                          ),
                          SongList(
                            albumURI: 'images/wallhaven-wydwyr_2560x1440.png',
                          ),
                          SongList(
                            albumURI: 'images/wallhaven-wydwyr_2560x1440.png',
                          ),
                          SongList(
                            albumURI: 'images/wallhaven-wydwyr_2560x1440.png',
                          ),
                          SongList(
                            albumURI: 'images/wallhaven-wydwyr_2560x1440.png',
                          ),
                          SongList(
                            albumURI: 'images/wallhaven-wydwyr_2560x1440.png',
                          ),
                          SongList(
                            albumURI: 'images/wallhaven-wydwyr_2560x1440.png',
                          ),
                          SongList(
                            albumURI: 'images/wallhaven-wydwyr_2560x1440.png',
                          ),
                        ])),
              ],
            ),
          ),
          Positioned(
              bottom: 0.5,
              child: SizedBox(
                /// Positioned不能自适应宽度
                width: MediaQuery.of(context).size.width,
                child: PlayBar(
                  audioPlayerHandler: audioPlayHandler,
                ),
              ))
        ],
      ),
    ));
  }
}
