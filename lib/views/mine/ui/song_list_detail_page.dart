import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'dart:developer' as developer;

class SongListDetailPage extends StatelessWidget {
  const SongListDetailPage({super.key});

  static final AudioPlayerHandler audioPlayerHandler =
      GetIt.I.get<AudioPlayerHandler>();

  @override
  Widget build(BuildContext context) {

    // Map<String, dynamic> param = Get.arguments as Map<String, dynamic>;
    developer.log('${Get.parameters}',name: 'SongListDetailPage');
    String title = Get.parameters['title'] ?? '未知';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: PlayBar(),
      body: Center(
        child: Text('歌单列表'),
      ),
    );
  }
}
