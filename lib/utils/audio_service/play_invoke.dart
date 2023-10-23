import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';

class PlayInvoke {
  static final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

  static Future<void> init({
    required List songList,
    required int index,
    bool shuffle = false,
    String? playListBox,
  }) async {
    final int globalIndex = index < 0 ? 0 : index;
    final List finalList = songList.toList();
    if (shuffle) finalList.shuffle();

    final List<MediaItem> queue = [];
    queue.addAll(
        finalList.map(
              (song) => MediaItem(
                id: song.uri,
                title: song.title,
                duration: Duration(milliseconds: song.duration),

          ),
        ));

    updateNplay(queue,globalIndex);
  }

  static Future<void> updateNplay(List<MediaItem> queue, int index) async {
    await audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    await audioHandler.updateQueue(queue);
    await audioHandler.skipToQueueItem(index);
    await audioHandler.play();

  }
}
