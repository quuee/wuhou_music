import 'package:android_content_provider/android_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';

import 'tabs/directory_tab.dart';
import 'tabs/singer_tab.dart';
import 'tabs/single_song_tab.dart';

class LocalMusicController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<SongEntity> songs = [];
  LoadingStatus _loadingStatus = LoadingStatus.loading;

  get loadingStatus => _loadingStatus;

  final List tabs = ['单曲', '歌手', '文件夹'];

  List<Widget> tabsPage = [
    SingleSongTab(),
    SingerTab(),
    DirectoryTab(),
  ];
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this)
      ..addListener(() {
        LogD('LocalMusicController',
            '_tabController.index:${tabController?.index}');
      });
  }

  @override
  void onReady() {
    super.onReady();

    _fetchSongs();
    // _fetchArts();
  }

  /// 扫描本地歌曲
  Future<void> _fetchSongs() async {
    LogD('LocalMusicController _fetchSongs', '扫描本地歌曲...');

    final cursor = await AndroidContentResolver.instance.query(
      // MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
      uri: 'content://media/external/audio/media',
      // uri: 'content://media/internal/audio/media',
      projection: SongEntity.mediaStoreProjection,
      // selection: '(mime_type = ? or mime_type = ?) and duration > ?',
      // selectionArgs: <String>['audio/mpeg', 'audio/ogg', '60000'],
      selection: 'is_music != 0',
      selectionArgs: null,
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
        // LogD(
        //     'LocalMusicController _fetchSongs',
        //     'id:${element.id},'
        //         'album:${element.album},'
        //         'albumId:${element.albumId},'
        //         'artist:${element.artist},'
        //         'title${element.title},'
        //         'duration:${element.duration},'
        //         'data:${element.data},'
        //         'bucketDisplayName:${element.bucketDisplayName},');

        return element.duration! / 1000 > 60; // 大于60秒的音频
      }).toList();

      // TODO 将本地歌曲存入isra？ 不同的media id 会不会变化
      IsarHelper.instance.isarInstance.writeTxn(() async {
        await IsarHelper.instance.isarInstance.songEntitys.clear();
        await IsarHelper.instance.isarInstance.songEntitys.putAll(songs);
      });

      _loadingStatus = LoadingStatus.success;
    } on Exception catch (e) {
      //使用on 来指定异常类型， 使用 catch 来 捕获异常
      // catch (e, s) 可以多个参数
      // 可以多个catch
      _loadingStatus = LoadingStatus.failed;
      LogE('LocalMusicController _fetchSongs Exception', e.toString());
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
            song.albumArt = data.last as String;
          }
        }
      }
    } finally {
      cursor?.close();
    }
  }

// searchSongs(String searchWord){
//
// }
}
