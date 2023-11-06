import 'dart:convert';
import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/sl_songs_entity.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';

class SongListDetailController extends GetxController {
  LoadingStatus _loadingStatus = LoadingStatus.loading;
  get loadingStatus => _loadingStatus;

  List<SongEntity> songs = [];

  // final songsBox = Hive.box(Keys.hiveSongs);

  int? songListId; // 歌单本地id
  String? slid; // 云端歌单id

  getSongListUUID() {
    songListId = int.parse(Get.parameters['songListId']!);
    slid = Get.parameters['slid'] ?? '';
  }

  /// 加载歌单歌曲
  loadSongs() {
    // List<dynamic> temp = Hive.box(Keys.hiveSongs).get(songListUUIDContro, defaultValue: []);
    List<SLSongsEntity> tempSongs = IsarHelper
        .instance.isarInstance.sLSongsEntitys
        .filter()
        .apslidEqualTo(songListId)
        .findAllSync();

    if (tempSongs.isEmpty) {
      // TODO 从服务端拉取数据
      if (slid != null && slid!.isNotEmpty) {}
    }
    List<int> apslidlist = tempSongs.map((e) => e.sid!).toSet().toList();

    List<SongEntity?> a = IsarHelper.instance.isarInstance.songEntitys.getAllSync(apslidlist);
    songs = songEntityFromJson(jsonEncode(a));
    // songs = songEntityFromJson(jsonEncode(tempSongs));
    _loadingStatus = LoadingStatus.success;
    developer.log('加载歌单歌曲$songEntityToJson(songs)',
        name: 'SongListDetailController loadSongs');
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
    IsarHelper.instance.isarInstance.writeTxn(() async {
      await IsarHelper.instance.isarInstance.sLSongsEntitys.putAll(s);
    });

    loadSongs();
  }

  /// 从歌单删除歌曲
  deleteSongInSongList(int sid) {
    // songs.removeWhere((element) => element.id.compareTo(songId) == 0);
    // Hive.box(Keys.hiveSongs).put(songListUUIDContro, songs);
    IsarHelper.instance.isarInstance.writeTxnSync(
        () => IsarHelper.instance.isarInstance.sLSongsEntitys.delete(sid));

    // 拿到songListBox
    // SongsListController mineController = Get.find<SongsListController>();
    // mineController.computedCount(songListUUIDContro, songs);
  }
}
