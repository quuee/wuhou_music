
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/audio_service/common.dart';
import 'package:wuhoumusic/utils/log_util.dart';

class PlayBar extends StatelessWidget {
  const PlayBar({
    super.key,
  });

  static final WHAudioPlayerHandler audioPlayerHandler = GetIt.I<WHAudioPlayerHandler>();


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white54,
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5.0,
                  spreadRadius: 0.1)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff9ee29f), Colors.lightGreen])),
        child: GestureDetector(
          behavior: HitTestBehavior
              .opaque, // opaque：空白部分点击也有效果，但是会阻止后面目标接收事件；Translucent：空白部分点击也有效果，也允许其后面的目标接收事件。
          onTap: () {
            Get.toNamed(Routes.play);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 封面
              StreamBuilder(
                  stream: audioPlayerHandler.queueState,
                  builder: (context, snapshot) {
                    QueueState queueState = snapshot.data ?? QueueState.empty;
                    if (queueState.queue.isEmpty) {
                      return SizedBox.shrink();
                    }

                    // int lastIndex = queueState.queue[queueState.queueIndex!].id
                    //     .lastIndexOf('/');
                    // String id = queueState.queue[queueState.queueIndex!].id
                    //     .substring(lastIndex + 1);
                    // LogD("PlayBar",'${queueState.queue[queueState.queueIndex!].id}');

                    // var artAlbum = queueState.queue[queueState.queueIndex!]
                    //         .extras!['artAlbum'] ??
                    //     '';

                    // return Image.file(
                    //   File(artAlbum),
                    //   cacheHeight: 70,
                    //   cacheWidth: 70,
                    //   // width: 70,
                    //   // height: 70,
                    //   fit: BoxFit.fill,
                    //   errorBuilder: (BuildContext context, Object error,
                    //       StackTrace? stackTrace) {
                    //     return Image.asset(
                    //       R.images.logo,
                    //       width: 70,
                    //       height: 70,
                    //       fit: BoxFit.fill,
                    //     );
                    //   },
                    // );
                    return QueryArtworkWidget(
                      id: int.parse(queueState.mediaItem!.id),
                      type: ArtworkType.PLAYLIST,
                      keepOldArtwork: true,
                      artworkBorder: BorderRadius.circular(7.0),
                      nullArtworkWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Image(
                          fit: BoxFit.cover,
                          height: 60.0,
                          width: 60.0,
                          image: AssetImage(R.images.logo),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                width: 10,
              ),

              /// 歌名
              StreamBuilder<QueueState>(
                  stream: audioPlayerHandler.queueState,
                  builder: (context, snapshot) {
                    QueueState queueState = snapshot.data ?? QueueState.empty;
                    if (queueState.queue.isEmpty) {
                      return const Text('');
                    }
                    return Expanded(
                        child: Text(
                            queueState.mediaItem!.title,
                            overflow: TextOverflow.ellipsis));
                  }),

              /// 上一首
              StreamBuilder<QueueState>(
                stream: audioPlayerHandler.queueState,
                builder: (context, snapshot) {
                  final queueState = snapshot.data ?? QueueState.empty;
                  return IconButton(
                    icon: const Icon(Icons.skip_previous),
                    onPressed: audioPlayerHandler.skipToPrevious
                  );
                },
              ),

              /// 播放
              StreamBuilder<PlaybackState>(
                stream: audioPlayerHandler.playbackState,
                builder: (context, snapshot) {
                  final playbackState = snapshot.data;
                  final processingState = playbackState?.processingState;
                  final playing = playbackState?.playing;
                  if (processingState == AudioProcessingState.loading ||
                      processingState == AudioProcessingState.buffering) {
                    return const CircularProgressIndicator();
                  } else if (playing != true) {
                    return IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: audioPlayerHandler.play,
                    );
                  } else {
                    return IconButton(
                      icon: const Icon(Icons.pause),
                      onPressed: audioPlayerHandler.pause,
                    );
                  }
                },
              ),

              /// 下一首
              StreamBuilder<QueueState>(
                stream: audioPlayerHandler.queueState,
                builder: (context, snapshot) {
                  final queueState = snapshot.data ?? QueueState.empty;
                  return IconButton(
                    icon: const Icon(Icons.skip_next),
                    onPressed: audioPlayerHandler.skipToNext
                  );
                },
              ),
            ],
          ),
        ));
  }
}
