import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'package:wuhoumusic/utils/audio_service/common.dart';
import 'package:wuhoumusic/utils/audio_service/controlButtons.dart';
import 'package:wuhoumusic/views/play/ui/lyric.dart';
import 'package:wuhoumusic/views/play/ui/playing.dart';
import 'package:wuhoumusic/views/play/ui/song_play_list.dart';
import 'dart:developer' as developer;

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  static final AudioPlayerHandler _audioHandler = GetIt.I<AudioPlayerHandler>();
  late PageController _pageController;
  Stream<Duration> get _bufferedPositionStream => _audioHandler.playbackState
      .map((state) => state.bufferedPosition)
      .distinct();
  Stream<Duration?> get _durationStream =>
      _audioHandler.mediaItem.map((item) => item?.duration).distinct();
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          AudioService.position,
          _bufferedPositionStream,
          _durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('播放页'),
      ),

      body: SafeArea(
          child: StreamBuilder<MediaItem?>(
        stream: _audioHandler.mediaItem,
        builder: (context, snapshot) {
          MediaItem? mediaItem = snapshot.data;
          if (mediaItem == null) return const SizedBox.shrink();
          SongEntity song = SongEntity(
              id: mediaItem.id,
              artist: mediaItem.artist!,
              title: mediaItem.title,
              duration: mediaItem.duration!.inMilliseconds,
              data: mediaItem.extras!['data']);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// MediaItem display
              Expanded(
                  child: PageView(
                controller: _pageController,
                children: [
                  PlayingPage(
                    mediaItem: mediaItem,
                  ),
                  Lyric(
                    song: song,
                  ),
                ],
              )),

              /// Playback controls
              ControlButtons(_audioHandler),

              /// A seek bar.
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data ??
                      PositionData(Duration.zero, Duration.zero, Duration.zero);
                  return SeekBar(
                    duration: positionData.duration,
                    position: positionData.position,
                    bufferedPosition: positionData.bufferedPosition,
                    onChangeEnd: (newPosition) {
                      developer.log('$newPosition',
                          name: 'playPage onChangeEnd');
                      _audioHandler.seek(newPosition);
                    },
                  );
                },
              ),

              /// 功能按钮 Repeat/shuffle controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<AudioServiceRepeatMode>(
                    stream: _audioHandler.playbackState
                        .map((state) => state.repeatMode)
                        .distinct(),
                    builder: (context, snapshot) {
                      final repeatMode =
                          snapshot.data ?? AudioServiceRepeatMode.none;
                      const icons = [
                        Icon(Icons.repeat, color: Colors.grey),
                        Icon(Icons.repeat, color: Colors.orange),
                        Icon(Icons.repeat_one, color: Colors.orange),
                      ];
                      const cycleModes = [
                        AudioServiceRepeatMode.none,
                        AudioServiceRepeatMode.all,
                        AudioServiceRepeatMode.one,
                      ];
                      final index = cycleModes.indexOf(repeatMode);
                      return IconButton(
                        icon: icons[index],
                        onPressed: () {
                          _audioHandler.setRepeatMode(cycleModes[
                              (cycleModes.indexOf(repeatMode) + 1) %
                                  cycleModes.length]);
                        },
                      );
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child:
                                          Center(child: Text('播放队列(点击关闭队列)')),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: SongPlayListPage(
                                        audioHandler: _audioHandler,
                                      ))
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.menu)),
                  IconButton(
                      onPressed: () {
                        // 定时
                      },
                      icon: Icon(Icons.access_alarms)),
                  StreamBuilder<bool>(
                    stream: _audioHandler.playbackState
                        .map((state) =>
                            state.shuffleMode == AudioServiceShuffleMode.all)
                        .distinct(),
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? const Icon(Icons.shuffle, color: Colors.orange)
                            : const Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () async {
                          final enable = !shuffleModeEnabled;
                          await _audioHandler.setShuffleMode(enable
                              ? AudioServiceShuffleMode.all
                              : AudioServiceShuffleMode.none);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      )),
      // bottomNavigationBar: ,
    );
  }
}
