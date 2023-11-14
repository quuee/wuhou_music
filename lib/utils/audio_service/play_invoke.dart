import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'package:wuhoumusic/utils/mediaitem_converter.dart';

class PlayInvoke {
  static final AudioPlayerHandler _audioHandler = GetIt.I<AudioPlayerHandler>();

  static Future<void> init({
    required List<SongEntity> songList,
    required int index,
    bool shuffle = false,
    String? playListBox,
  }) async {

    // 跳过本地不存在的文件
    final List<SongEntity> finalList = songList.where((element) {
      bool fileFlag = false;
      if(element.data == null){
        fileFlag = false;
      }else{
        if(File(element.data!).existsSync()){
          fileFlag = true;
        }
      }

      bool urlFlag = false;
      if(element.url.toString().startsWith('http')){
        urlFlag = true;
      }

      return fileFlag || urlFlag;

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

    queue.addAll(finalList.map((e) => MediaItemConverter.songEntityToMediaItem(e)));

    _updateNplay(queue, globalIndex);
  }

  static Future<void> _updateNplay(List<MediaItem> queue, int index) async {
    await _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    await _audioHandler.updateQueue(queue);
    await _audioHandler.skipToQueueItem(index);
    await _audioHandler.play();
  }
}
