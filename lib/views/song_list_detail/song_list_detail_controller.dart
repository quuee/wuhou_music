import 'dart:convert';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/sl_songs_entity.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/model/songs_list_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';

class SongListDetailController extends GetxController {
  LoadingStatus _loadingStatus = LoadingStatus.loading;
  get loadingStatus => _loadingStatus;

  List<SongEntity> songs = [];

  // final songsBox = Hive.box(Keys.hiveSongs);

  int? songListId; // 歌单本地id
  String? slid; // 云端歌单id

  getSongListUUID() {
    // TODO 在本地歌曲页面添加到歌单 需要调用SongListDetailController，但是没有页面传递歌单id 空指针

    songListId = int.parse(Get.parameters['songListId']!);
    slid = Get.parameters['slid'] ?? '';
  }

  /// 加载歌单歌曲
  loadSongs() {
    List<SLSongsEntity> tempSongs = IsarHelper
        .instance.isarInstance.sLSongsEntitys
        .filter()
        .apslidEqualTo(songListId)
        .findAllSync();

    if (tempSongs.isEmpty) {
      // 从服务端拉取数据
      if (slid != null && slid!.isNotEmpty) {}
    }
    List<int> apslidlist = tempSongs.map((e) => e.sid!).toSet().toList();

    List<SongEntity?> a =
        IsarHelper.instance.isarInstance.songEntitys.getAllSync(apslidlist);
    songs = songEntityFromJson(jsonEncode(a));

    _loadingStatus = LoadingStatus.success;

    LogD('SongListDetailController loadSongs', '加载歌单歌曲');

    update();
  }

  @override
  void onReady() {
    getSongListUUID();
    loadSongs();
    super.onReady();
  }

  /// 将歌曲加到歌单
  addSongToSongList(int id, List<SongEntity> songs) {
    songListId ??= id;

    // List<dynamic> temp = Hive.box(Keys.hiveSongs).get(songListUUID, defaultValue: []);
    // List<SongEntity> tempList = songEntityFromJson(jsonEncode(temp));
    // tempList.addAll(songs);
    // Hive.box(Keys.hiveSongs).put(songListUUID, tempList);
    List<SLSongsEntity> s = songs
        .map((e) => SLSongsEntity(sid: e.sid, apslid: songListId))
        .toList();

    SongsListEntity songsListEntity =
        IsarHelper.instance.isarInstance.songsListEntitys.getSync(songListId!)!;
    List<SLSongsEntity> slsList = IsarHelper
        .instance.isarInstance.sLSongsEntitys
        .filter()
        .apslidEqualTo(songListId)
        .findAllSync();
    songsListEntity.count = slsList.length + songs.length;

    IsarHelper.instance.isarInstance.writeTxnSync(() {
      IsarHelper.instance.isarInstance.sLSongsEntitys.putAllSync(s);
      IsarHelper.instance.isarInstance.songsListEntitys
          .putSync(songsListEntity);
    });

    loadSongs();
  }

  /// 从歌单删除歌曲
  deleteSongInSongList(int sid) {
    // songs.removeWhere((element) => element.id.compareTo(songId) == 0);
    // Hive.box(Keys.hiveSongs).put(songListUUIDContro, songs);

    SongsListEntity songsListEntity =
        IsarHelper.instance.isarInstance.songsListEntitys.getSync(songListId!)!;
    if (songsListEntity.count == null) {
      songsListEntity.count = 0;
    }
    if (songsListEntity.count! - 1 < 0) {
      songsListEntity.count = 0;
    }
    songsListEntity.count = songsListEntity.count! - 1;
    IsarHelper.instance.isarInstance.writeTxnSync(() {
      IsarHelper.instance.isarInstance.sLSongsEntitys.deleteSync(sid);
      IsarHelper.instance.isarInstance.songsListEntitys.putSync(songsListEntity);
    });

    // 拿到songListBox
    // SongsListController mineController = Get.find<SongsListController>();
    // mineController.computedCount(songListUUIDContro, songs);
  }
}
