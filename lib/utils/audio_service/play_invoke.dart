import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';

class PlayInvoke {
  static final AudioPlayerHandler audioHandler = GetIt.I.get<AudioPlayerHandler>();


  static Future<void> init({
    required List<SongEntity> songList,
    required int index,
    bool shuffle = false,
    String? playListBox,
  }) async {
    final int globalIndex = index < 0 ? 0 : index;
    final List<SongEntity> finalList = songList.toList();
    if (shuffle) finalList.shuffle();

    final List<MediaItem> queue = [];

    queue.addAll(finalList.map((e) => e.toMediaItem()));

    updateNplay(queue,globalIndex);
  }

  static Future<void> updateNplay(List<MediaItem> queue, int index) async {
    await audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    await audioHandler.updateQueue(queue);
    await audioHandler.skipToQueueItem(index);
    await audioHandler.play();

  }
}
