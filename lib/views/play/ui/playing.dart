import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'dart:developer' as developer;

class PlayingPage extends StatelessWidget {
  const PlayingPage({super.key, required this.audioHandler});

  final AudioPlayerHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, snapshot) {
        final mediaItem = snapshot.data;
        if (mediaItem != null && mediaItem.artUri != null) {
          developer.log(mediaItem.artUri!.path, name: 'PlayingPage');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.network(
                      'content://media' + mediaItem.artUri!.path,
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          R.images.logo,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Text(mediaItem.album ?? '',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(mediaItem.title),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
