import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';

class PlayingPage extends StatelessWidget {
  const PlayingPage({super.key, required this.audioHandler});

  final AudioPlayerHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, snapshot) {
        final mediaItem = snapshot.data;
        if (mediaItem == null) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (mediaItem.artUri != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.network('${mediaItem.artUri!}'),
                  ),
                ),
              ),
            Text(mediaItem.album ?? '',
                style: Theme.of(context).textTheme.titleLarge),
            Text(mediaItem.title),
          ],
        );
      },
    );
  }
}
