import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';

class PlayInvoke {
  static final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

  static Future<void> init({
    required List<SongEntity> songList,
    required int index,
    bool shuffle = false,
    String? playListBox,
  }) async {
    // 跳过本地不存在的文件
    final List<SongEntity> finalList = songList.where((element) {
      return File(element.data!).existsSync();
    }).toList();

    // 因为存在 本地不存在的文件 索引不正常
    int globalIndex = 0;
    if (index >= finalList.length) {
      globalIndex = finalList.length - 1;
    } else {
      int temp =
          finalList.elementAt(index).id.compareTo(songList.elementAt(index).id);
      if (temp == 0) {
        globalIndex = index;
      } else {
        globalIndex = finalList.indexWhere((element) =>
            element.id.compareTo(songList.elementAt(index).id) == 0);
      }
    }

    if (shuffle) finalList.shuffle();

    final List<MediaItem> queue = [];

    queue.addAll(finalList.map((e) => e.toMediaItem()));

    updateNplay(queue, globalIndex);
  }

  static Future<void> updateNplay(List<MediaItem> queue, int index) async {
    await audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    await audioHandler.updateQueue(queue);
    await audioHandler.skipToQueueItem(index);
    await audioHandler.play();
  }
}
