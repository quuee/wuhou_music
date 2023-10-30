import 'dart:convert';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/views/mine/ui/create_song_list_dialog.dart';

class MineController extends GetxController {
  final box = Hive.box(Keys.hiveSongList);

  List<SongListEntity> songList = [];

  TextEditingController songListNameContro = TextEditingController();

  late EasyRefreshController easyRefreshController;

  final String songListBuilder = 'songListBuilder';

  String? songListImagePath;

  @override
  void onInit() {
    loadSongList();
    easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    super.onInit();
  }

  @override
  onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }

  /// 加载本地歌单
  loadSongList() {
    //  从hive获取本地歌单
    var temp = box.get(Keys.localSongList, defaultValue: <SongListEntity>[]);
    songList = songListEntityFromJson(jsonEncode(temp));
    developer.log('加载本地歌单$songListEntityToJson(songList)',
        name: 'MineController loadSongList ');
    if (songList.isEmpty) {
      // todo 从服务端加载
    }
  }

  /// 下拉刷新
  pullDownRefresh() async {
    developer.log('onRefresh', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    loadSongList();
    update([songListBuilder]);
    easyRefreshController.finishRefresh();
    easyRefreshController.resetFooter();
  }

  /// 上拉加载
  pullUponLoading() async {
    developer.log('onLoading', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    loadSongList();
    update([songListBuilder]);
    easyRefreshController.finishLoad(IndicatorResult.success);
  }

  /// 创建 更新一个歌单
  createOrUpdateSongList(String? songListUUID) {

    if(songListUUID!=null){
      // 更新
      var s = SongListEntity(
        id: songListUUID,
        listTitle: songListNameContro.text.trim(),
        listAlbum: songListImagePath ?? '',
        count: 0,
      );
      int index = songList.indexWhere((element) => element.id.compareTo(songListUUID) == 0);
      songList[index] = s;
    }else{
      // 新增
      var s = SongListEntity(
        id: Uuid().v1(),
        listTitle: songListNameContro.text.trim(),
        listAlbum: songListImagePath ?? '',
        count: 0,
      );
      songList.add(s);
    }
    box.put(Keys.localSongList, songList);
    songListNameContro.clear();
    songListImagePath = null;
    update([songListBuilder]);
  }

  /// 删除一个歌单
  deleteSongList(String songListUUID) {
    int index = songList
        .indexWhere((element) => element.id.compareTo(songListUUID) == 0);
    songList.removeAt(index);
    box.put(Keys.localSongList, songList);
    update([songListBuilder]);
  }

  /// 创建歌单的中间弹窗
  createOrUpdateSongListDialog(SongListEntity? songListEntity) {

    if (songListEntity == null) {
      // songListNameContro.clear();
      // songListImagePath = null;
    } else {
      songListNameContro.text = songListEntity.listTitle;
      songListImagePath = songListEntity.listAlbum;
    }
    Get.defaultDialog(
      title: '请编辑歌单名称',
      content: CreateSongListDialog(),
      confirm: ElevatedButton(
          onPressed: () {
            createOrUpdateSongList(songListEntity?.id);
            Get.back();
          },
          child: Text('确认')),
      cancel: ElevatedButton(
          onPressed: () {
            songListNameContro.clear();
            Get.back();
          },
          child: Text('取消')),
    );
  }

  computedCount(String songListUUID,List<SongEntity> tempList){
    // 拿到songListBox
    int index = songList.indexWhere((element) => element.id.compareTo(songListUUID) == 0);
    SongListEntity gedan = songList[index];
    gedan.count = tempList.length;
    developer.log('更新歌单$songEntityToJson(mineController.songList)',name: 'SongListDetailController addSongToSongList');
    box.put(Keys.localSongList, songList);
  }
}
