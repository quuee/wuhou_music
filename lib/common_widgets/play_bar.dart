import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';

class PlayBar extends StatelessWidget {
  const PlayBar({
    super.key,
    required this.audioPlayerHandler,
  });

  final AudioPlayerHandler audioPlayerHandler;

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
                colors: [Colors.deepPurple, Color(0xFFB39DDB)])),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.play);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 封面
              Image.asset(
                R.images.logo,
                width: 60,
                height: 60,
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
                            queueState.queue[queueState.queueIndex!].title,
                            overflow: TextOverflow.ellipsis));
                  }),

              /// 上一首
              StreamBuilder<QueueState>(
                stream: audioPlayerHandler.queueState,
                builder: (context, snapshot) {
                  final queueState = snapshot.data ?? QueueState.empty;
                  return IconButton(
                    icon: const Icon(Icons.skip_previous),
                    onPressed: queueState.hasPrevious
                        ? audioPlayerHandler.skipToPrevious
                        : null,
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
                    onPressed: queueState.hasNext
                        ? audioPlayerHandler.skipToNext
                        : null,
                  );
                },
              ),
            ],
          ),
        ));
  }
}