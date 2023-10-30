import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/views/play/play_controller.dart';

class PlayingPage extends StatelessWidget {
  PlayingPage({super.key, required this.audioHandler});

  final AudioPlayerHandler audioHandler;

  final PlayController playController = Get.find<PlayController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, snapshot) {
        final mediaItem = snapshot.data;
        if (mediaItem != null && mediaItem.artUri != null) {
          int lastIndex = mediaItem.id.lastIndexOf('/');
          String id = mediaItem.id.substring(lastIndex + 1);
          developer.log('${mediaItem.id} + $id', name: 'PlayingPage');

          //根据歌曲获取歌词
          playController.currentSong = SongEntity(
              id: mediaItem.id,
              artist: mediaItem.artist!,
              title: mediaItem.title,
              duration: mediaItem.duration!.inMilliseconds,
              data: mediaItem.extras!['data']);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: QueryArtworkWidget(
                      id: int.parse(id),
                      type: ArtworkType.PLAYLIST,
                      keepOldArtwork: true,
                      artworkBorder: BorderRadius.circular(7.0),
                      nullArtworkWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Image(
                          fit: BoxFit.cover,
                          height: 100.0,
                          width: 100.0,
                          image: AssetImage(R.images.logo),
                        ),
                      ),
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
