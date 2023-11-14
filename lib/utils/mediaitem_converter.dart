import 'package:audio_service/audio_service.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';

class MediaItemConverter {
  static Map mediaItemToMap(MediaItem mediaItem) {
    return {
      'id': mediaItem.id,
      'album': mediaItem.album.toString(),
      'album_id': mediaItem.extras?['album_id'],
      'artist': mediaItem.artist.toString(),
      'duration': mediaItem.duration?.inSeconds.toString(),
    };
  }

  // static MediaItem mapToMediaItem() {}

  // static MediaItem onlineSongToMediaItem() {}

  static MediaItem songEntityToMediaItem(SongEntity songEntity) {

    Uri? uri;
    if(songEntity.data.toString().startsWith('file:')){
      uri = Uri.file(songEntity.data!);
    }else if(songEntity.url.toString().startsWith('http')){

    }else{
      uri = Uri.parse('content://media/external/audio/media/${songEntity.id}');
    }
    return MediaItem(
      id: songEntity.id,
      album: songEntity.album,
      artist: songEntity.artist,
      duration: Duration(milliseconds: songEntity.duration ?? 0),
      title: songEntity.title,
      artUri: uri,
      // genre: songEntity.,
      extras: <String, dynamic>{
        'id': songEntity.id,
        'albumArt': songEntity.albumArt,
        'data': songEntity.data,
        'url': songEntity.url,
      },
    );
  }
}
