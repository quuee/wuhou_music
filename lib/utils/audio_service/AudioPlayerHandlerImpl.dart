import 'dart:convert';
import 'package:audio_service/audio_service.dart';
import 'package:isar/isar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wuhoumusic/model/audio/cache_songs_entity.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/utils/audio_service/common.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/utils/mediaitem_converter.dart';

/// This handler is backed by a just_audio player. The player's effective
/// sequence is mapped onto the handler's queue, and the player's state is
/// mapped onto the handler's state.
class AudioPlayerHandlerImpl extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  final _player = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: []);

  // 缓存最新一次事件的广播流控制器：BehaviorSubject
  // @override
  // final BehaviorSubject<double> volume = BehaviorSubject.seeded(1.0);
  // @override
  // final BehaviorSubject<double> speed = BehaviorSubject.seeded(1.0);

  final _mediaItemExpando = Expando<MediaItem>();

  /// A stream of the current effective sequence from just_audio.
  Stream<List<IndexedAudioSource>> get _effectiveSequence => Rx.combineLatest3<
              List<IndexedAudioSource>?,
              List<int>?,
              bool,
              List<IndexedAudioSource>?>(_player.sequenceStream,
          _player.shuffleIndicesStream, _player.shuffleModeEnabledStream,
          (sequence, shuffleIndices, shuffleModeEnabled) {
        if (sequence == null) return [];
        if (!shuffleModeEnabled) return sequence;
        if (shuffleIndices == null) return null;
        if (shuffleIndices.length != sequence.length) return null;
        return shuffleIndices.map((i) => sequence[i]).toList();
      }).whereType<List<IndexedAudioSource>>();

  /// Computes the effective queue index taking shuffle mode into account.
  int? getQueueIndex(
      int? currentIndex, bool shuffleModeEnabled, List<int>? shuffleIndices) {
    final effectiveIndices = _player.effectiveIndices ?? [];
    final shuffleIndicesInv = List.filled(effectiveIndices.length, 0);
    for (var i = 0; i < effectiveIndices.length; i++) {
      shuffleIndicesInv[effectiveIndices[i]] = i;
    }
    return (shuffleModeEnabled &&
            ((currentIndex ?? 0) < shuffleIndicesInv.length))
        ? shuffleIndicesInv[currentIndex ?? 0]
        : currentIndex;
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    if (enabled) {
      await _player.shuffle();
    }
    playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
    await _player.setShuffleModeEnabled(enabled);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
    await _player.setLoopMode(LoopMode.values[repeatMode.index]);
  }

  AudioPlayerHandlerImpl() {
    _init();
  }

  Future<void> _init() async {
    // Broadcast media item changes.
    Rx.combineLatest4<int?, List<MediaItem>, bool, List<int>?, MediaItem?>(
        _player.currentIndexStream,
        queue,
        _player.shuffleModeEnabledStream,
        _player.shuffleIndicesStream,
        (index, queue, shuffleModeEnabled, shuffleIndices) {
      final queueIndex =
          getQueueIndex(index, shuffleModeEnabled, shuffleIndices);
      return (queueIndex != null && queueIndex < queue.length)
          ? queue[queueIndex]
          : null;
    }).whereType<MediaItem>().distinct().listen(mediaItem.add);

    // Broadcast the current queue.
    _effectiveSequence
        .map((sequence) =>
            sequence.map((source) => _mediaItemExpando[source]!).toList())
        .pipe(queue);

    // Load the playlist.
    if (queue.value.isEmpty) {
      // 从本地缓存中恢复最近一次的队列
      List<CacheSongEntity> cacheList = IsarHelper
          .instance.isarInstance.cacheSongEntitys
          .where(distinct: true, sort: Sort.asc)
          .findAllSync();

      if (cacheList.isNotEmpty) {
        List<SongEntity> temp = songEntityFromJson(jsonEncode(cacheList));
        final List<MediaItem> lastQueue = temp
            .map((e) => MediaItemConverter.songEntityToMediaItem(e))
            .toList();
        if (lastQueue.isNotEmpty) {
          _playlist.addAll(_itemsToSources(lastQueue));
          await _player.setAudioSource(_playlist);
          await _player.seek(Duration(seconds: 0), index: 0);
        }
      } else {
        await _player
            .setAudioSource(_playlist, preload: false)
            .onError((error, stackTrace) {
          return null;
        });
      }
    } else {
      _playlist.addAll(queue.value.map(_itemToSource).toList());
      await _player.setAudioSource(_playlist);
    }

    _player.playbackEventStream.listen((event) {
      _broadcastState(_player.playbackEvent);
    }, onError: _playbackError);

    // _player.shuffleModeEnabledStream
    //     .listen((enabled) => _broadcastState(_player.playbackEvent));

    // _player.loopModeStream
    //     .listen((event) => _broadcastState(_player.playbackEvent));

    // In this example, the service stops when reaching the end. 在本例中，服务到达终点时停止。
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        stop();
        _player.seek(Duration.zero, index: 0);
      }
    });
  }

  AudioSource _itemToSource(MediaItem mediaItem) {
    AudioSource? audioSource;
    if (mediaItem.artUri.toString().startsWith('content:')) {
      audioSource = AudioSource.uri(mediaItem.artUri!);
    } else if (mediaItem.artUri.toString().startsWith('file:')) {
      audioSource = AudioSource.uri(mediaItem.artUri!);
    } else {
      audioSource = AudioSource.uri(Uri.parse(mediaItem.extras!['url']));
    }
    _mediaItemExpando[audioSource] = mediaItem;
    return audioSource;
  }

  List<AudioSource> _itemsToSources(List<MediaItem> mediaItems) =>
      mediaItems.map(_itemToSource).toList();

  Future<void> addLastQueue(List<MediaItem> queue) async {
    if (queue.isNotEmpty) {
      // 将queue的mediaItem 转成 map 或 songEntity，存入hive
      final lastSongEntityList = queue
          .map((item) => CacheSongEntity(
              id: item.id,
              album: item.album,
              artist: item.artist ?? '',
              title: item.title,
              url: item.extras!['url'] ?? '',
              duration: item.duration!.inMilliseconds))
          .toList();
      IsarHelper.instance.isarInstance.writeTxn(() async {
        await IsarHelper.instance.isarInstance.cacheSongEntitys
            .putAll(lastSongEntityList);
      });
    }
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    await _playlist.add(_itemToSource(mediaItem));
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    await _playlist.addAll(_itemsToSources(mediaItems));
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    await _playlist.insert(index, _itemToSource(mediaItem));
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    if(queue.first.extras!.containsKey('text')){
      return;
    }
    await _playlist.clear();
    await _playlist.addAll(_itemsToSources(queue));
    // 清理cacheSongs
    IsarHelper.instance.isarInstance.writeTxn(() async {
      await IsarHelper.instance.isarInstance.cacheSongEntitys.clear();
    });
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    _mediaItemExpando[_player.sequence![index]] = mediaItem;
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {
    final index = queue.value.indexOf(mediaItem);
    await _playlist.removeAt(index);
  }

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= _playlist.children.length) return;
    // This jumps to the beginning of the queue item at [index].
    // TODO shuffleIndices empty 就会索引越界。先不设置shuffleMode
    _player.seek(Duration.zero,
        index: _player.shuffleModeEnabled
            ? _player.shuffleIndices![index]
            : index);
    // play();
  }

  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    await _playlist.move(currentIndex, newIndex);
  }

  @override
  Future<void> play() async {
    _player.play();
  }

  @override
  Future<void> pause() async {
    _player.pause();
    if(this.runtimeType == AudioPlayerHandlerImpl){
      addLastQueue(queue.value);
    }
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await playbackState.firstWhere(
        (state) => state.processingState == AudioProcessingState.idle);

    if(this.runtimeType == AudioPlayerHandlerImpl){
      addLastQueue(queue.value);
    }
  }

  /// Broadcasts the current state to all clients.
  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    final queueIndex = getQueueIndex(
        event.currentIndex, _player.shuffleModeEnabled, _player.shuffleIndices);

    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: queueIndex,
    ));
  }

  void _playbackError(Object e, StackTrace st) {
    if (e is PlayerException) {
      LogE('_playbackError', e.message.toString());
    } else {
      LogE('_playbackError', st.toString());
    }
  }
}
