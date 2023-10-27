
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/views/mine/mine_controller.dart';
import 'dart:developer' as developer;

class SongListDetailController extends GetxController{

  LoadingStatus _loadingStatus = LoadingStatus.loading;
  get loadingStatus => _loadingStatus;

  List<SongEntity> songList = [];
  final box = Hive.box(Keys.hiveSongList);

  /// 加载歌单歌曲
  loadSongs(){

    String? songListUUID = Get.parameters['songListUUID'];
    if(songListUUID == null || songListUUID.isEmpty){
      return ;
    }

    List<dynamic> temp = box.get(songListUUID,defaultValue: []);
    songList = songEntityFromJson(jsonEncode(temp));

    _loadingStatus = LoadingStatus.success;
    developer.log('加载歌单歌曲$songEntityToJson(songList)',name: 'SongListDetailController loadSongs');
    update();
  }

  @override
  void onReady() {
    super.onReady();
    loadSongs();
  }

  /// 将歌曲加到歌单
  addSongToSongList(String songListUUID, List<SongEntity> songs) {

    List<dynamic> temp = box.get(songListUUID,defaultValue: []);
    List<SongEntity> tempList = songEntityFromJson(jsonEncode(temp));
    tempList.addAll(songs);
    box.put(songListUUID, tempList);

    // 拿到songListBox
    MineController mineController = Get.find<MineController>();
    final songListBox = mineController.box;
    int index = mineController.songList.indexWhere((element) => element.id.compareTo(songListUUID) == 0);
    SongListEntity gedan = mineController.songList[index];
    gedan.count = tempList.length;
    developer.log('更新歌单$songEntityToJson(mineController.songList)',name: 'SongListDetailController addSongToSongList');
    songListBox.put(Keys.localSongList, mineController.songList);

    update(['songList']);// TODO 更新不了UI
  }

/// 从歌单删除歌曲

}