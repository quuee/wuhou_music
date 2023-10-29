
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

  List<SongEntity> songs = [];

  final box = Hive.box(Keys.hiveSongList);

  String? songListUUID;

  /// 加载歌单歌曲
  loadSongs(){

    songListUUID = Get.parameters['songListUUID'];
    if(songListUUID == null || songListUUID!.isEmpty){
      return ;
    }

    List<dynamic> temp = box.get(songListUUID,defaultValue: []);
    songs = songEntityFromJson(jsonEncode(temp));

    _loadingStatus = LoadingStatus.success;
    developer.log('加载歌单歌曲$songEntityToJson(songs)',name: 'SongListDetailController loadSongs');
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
    mineController.computedCount(songListUUID, tempList);
    mineController.pullDownRefresh();//可以更新UI
    // update(['songListBuilder']);//更新不了UI
  }

  /// 从歌单删除歌曲
  deleteSongInSongList(String songId){

    songs.removeWhere((element) => element.id.compareTo(songId)==0);
    box.put(songListUUID, songs);

    // 拿到songListBox
    MineController mineController = Get.find<MineController>();
    mineController.computedCount(songListUUID!, songs);
    mineController.pullDownRefresh();//可以更新UI

  }
}