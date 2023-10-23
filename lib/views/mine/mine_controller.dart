import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';

class MineController extends GetxController {
  final box = Hive.box(Keys.hiveSongList);

  List<SongListEntity>? songList;

  String? imagePath;

  TextEditingController songListNameContro = TextEditingController();

  /// 加载本地歌单
  loadSongList() {
    var box = Hive.box(Keys.hiveSongList);
    //  从hive获取本地歌单
    var temp = box.get(Keys.localSongList, defaultValue: <SongListEntity>[]);
    songList = songListFromJson(jsonEncode(temp));
    if (songList == null || songList!.isEmpty) {
      // todo 从服务端加载
    }
  }

  @override
  void onInit() {
    loadSongList();
    super.onInit();
  }

  addSongList() {
    var s = SongListEntity(
        id: Uuid().v1(),
        songList: songListNameContro.text.trim(),
        songListAlbum: imagePath ?? '',
        count: 0);
    songList!.add(s);
    box.put(Keys.localSongList, songList);
    songListNameContro.clear();
    imagePath = null;
    update();
  }

  deleteSongList(String songListUUID) {
    int index = songList!
        .indexWhere((element) => element.id.compareTo(songListUUID) == 0);
    songList!.removeAt(index);
    box.put(Keys.localSongList, songList);
    update();
  }
}
