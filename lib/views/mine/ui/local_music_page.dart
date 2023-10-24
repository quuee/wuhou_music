import 'package:android_content_provider/android_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wuhoumusic/common_widgets/play_bar.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/utils/audio_service/AudioPlayerHandlerImpl.dart';
import 'package:wuhoumusic/utils/audio_service/play_invoke.dart';
import 'dart:developer' as developer;



class LocalMusicPage extends StatefulWidget {
  const LocalMusicPage({super.key});

  @override
  State<LocalMusicPage> createState() => _LocalMusicPageState();
}

class _LocalMusicPageState extends State<LocalMusicPage> {
  late AudioPlayerHandler _audioHandler;

  @override
  void initState() {
    _audioHandler = GetIt.I.get<AudioPlayerHandler>();

    super.initState();
  }

  /// 扫描本地
  Future<List<SongEntity>> _fetchSongs() async {
    developer.log('_fetchSongs...', name: 'LocalMusicPage _fetchSongs');

    final cursor = await AndroidContentResolver.instance.query(
      // MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
      uri: 'content://media/external/audio/media',
      // uri: 'content://media/internal/audio/media',
      projection: SongEntity.mediaStoreProjection,
      selection: '(mime_type = ? or mime_type = ?) and duration > ?',
      selectionArgs: <String>['audio/mpeg','audio/ogg','60000'],
      sortOrder: null,
    );
    try {
      final songCount =
          (await cursor!.batchedGet().getCount().commit()).first as int;
      final batch = SongEntity.createBatch(cursor);
      final songsData = await batch.commitRange(0, songCount);
      List<SongEntity> localSongs = songsData
          .map((data) => SongEntity.fromMediaStore(data))
      //     .where((element) {
      //   developer.log(
      //       'id:${element.id},album:${element.album},albumId:${element.albumId},artist:${element.artist},title${element.title},duration:${element.duration}',
      //       name: '_fetchSongs');
      //   return element.duration / 1000 > 60; // 大于60秒的音频
      // })
          .toList();
      return localSongs;
    } finally {
      cursor?.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget child;

    child = FutureBuilder(
        future: _fetchSongs(),
        builder: (context, snapshot) {
          List<SongEntity> list = snapshot.data ?? [];
          return ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) newIndex--;
              _audioHandler.moveQueueItem(oldIndex, newIndex);
            },
            children: [
              for (var i = 0; i < list.length; i++)
                Dismissible(
                  key: ValueKey(list[i].id),
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  onDismissed: (dismissDirection) {

                    _audioHandler.removeQueueItemAt(i);
                  },
                  child: Material(

                    child: ListTile(
                      title: Text(list[i].title),
                      onTap: () {
                        PlayInvoke.init(songList: list, index: i);
                      },
                    ),
                  ),
                )
            ],
          );
        });

    return Scaffold(
      appBar: AppBar(
        title: const Text('本地音乐'),
      ),
      bottomNavigationBar: PlayBar(),
      body: child,
    );
  }
}
