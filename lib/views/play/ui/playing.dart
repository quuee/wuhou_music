import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:wuhoumusic/resource/r.dart';
import 'package:wuhoumusic/utils/log_util.dart';


class PlayingPage extends StatelessWidget {
  PlayingPage({super.key, required this.mediaItem,});

  final MediaItem mediaItem;

  @override
  Widget build(BuildContext context) {

    if (mediaItem.artUri != null) {
      int lastIndex = mediaItem.id.lastIndexOf('/');
      String id = mediaItem.id.substring(lastIndex + 1);
      LogD('PlayingPage', '${mediaItem.id} + $id');

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

  }
}
