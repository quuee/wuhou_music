import 'package:android_content_provider/android_content_provider.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/resource/loading_status.dart';

class LocalMusicController extends GetxController {
  List<SongEntity> songs = [];
  LoadingStatus _loadingStatus = LoadingStatus.loading;
  get loadingStatus => _loadingStatus;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    _fetchSongs();
    // _fetchArts();
  }

  /// 扫描本地歌曲
  Future<void> _fetchSongs() async {
    developer.log('扫描本地歌曲...', name: 'LocalMusicPage _fetchSongs');

    final cursor = await AndroidContentResolver.instance.query(
      // MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
      uri: 'content://media/external/audio/media',
      // uri: 'content://media/internal/audio/media',
      projection: SongEntity.mediaStoreProjection,
      selection: '(mime_type = ? or mime_type = ?) and duration > ?',
      selectionArgs: <String>['audio/mpeg', 'audio/ogg', '60000'],
      sortOrder: null,
    );
    try {
      final songCount =
          (await cursor!.batchedGet().getCount().commit()).first as int;
      final batch = SongEntity.createBatch(cursor);
      final songsData = await batch.commitRange(0, songCount);
      songs = songsData
          .map((data) => SongEntity.fromMediaStore(data))
          .where((element) {
        // developer.log(
        //     'id:${element.id},'
        //     'album:${element.album},'
        //     'albumId:${element.albumId},'
        //     'artist:${element.artist},'
        //     'title${element.title},'
        //     'duration:${element.duration},'
        //     'data:${element.data},'
        //     'bucketDisplayName:${element.bucketDisplayName},',
        //     name: '_fetchSongs');
        return element.duration / 1000 > 60; // 大于60秒的音频
      }).toList();

      _loadingStatus = LoadingStatus.success;
    } on Exception catch (e) {
      //使用on 来指定异常类型， 使用 catch 来 捕获异常
      // catch (e, s) 可以多个参数
      // 可以多个catch
      _loadingStatus = LoadingStatus.failed;
      developer.log(e.toString(), name: '_fetchSongs exception');
    } finally {
      cursor?.close();
      update();
    }
  }

  /// 扫描本地歌曲 封面 不好用
  Future<void> _fetchArts() async {
    final cursor = await AndroidContentResolver.instance.query(
      // MediaStore.Audio.Albums.EXTERNAL_CONTENT_URI
      uri: 'content://media/external/audio/albums',
      projection: const ['_id', 'album_art'],
      selection: 'album_art != 0',
      selectionArgs: null,
      sortOrder: null,
    );
    try {
      final albumCount =
          (await cursor!.batchedGet().getCount().commit()).first as int;
      final batch = cursor.batchedGet()
        ..getInt(0)
        ..getString(1);
      final albumsData = await batch.commitRange(0, albumCount);

      for (final data in albumsData) {
        for (SongEntity song in songs) {
          if (song.albumId!.compareTo((data.first as int)) == 0) {
            song.artAlbum = data.last as String;
          }
        }
      }
    } finally {
      cursor?.close();
    }
  }
}
