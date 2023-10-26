import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/common_widgets/song_item.dart';
import 'dart:developer' as developer;

class SongListDetailPage extends StatefulWidget {
  const SongListDetailPage({super.key});

  @override
  State<SongListDetailPage> createState() => _SongListDetailPageState();
}

class _SongListDetailPageState extends State<SongListDetailPage> {
  int _selectedIndex = -1;

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
        body: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {},
                  child: Container(
                    child: buildSongItem(
                        index: index,
                        songTitle: 'item' + index.toString(),
                        quality: '超清母带',
                        singer: '阿悄',
                        album: '人来人往'),
                  ));
            }));
  }
}
