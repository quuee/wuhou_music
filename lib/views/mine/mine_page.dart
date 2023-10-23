import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_list.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'package:wuhoumusic/views/mine/mine_controller.dart';

class MinePage extends GetView<MineController> {
  const MinePage({super.key});

  static final audioPlayHandler = GetIt.I.get<AudioPlayerHandler>();

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
              onPressed: () {},
            ),
            Text('创建歌单')
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
            Text('待定')],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
            Text('待定')],
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
                          SongList(),
                          SongList(),
                          SongList(),
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
