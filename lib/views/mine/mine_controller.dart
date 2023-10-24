import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:images_picker/images_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';

class MineController extends GetxController {
  final box = Hive.box(Keys.hiveSongList);

  List<SongListEntity>? songList;

  // String? imagePath;

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

  addSongList(String? imageLocalPath) {

    var s = SongListEntity(
        id: Uuid().v1(),
        listTitle: songListNameContro.text.trim(),
        listAlbum: imageLocalPath ?? '',
        count: 0);
    songList!.add(s);
    box.put(Keys.localSongList, songList);
    songListNameContro.clear();
    imageLocalPath = null;
    update();
  }

  deleteSongList(String songListUUID) {
    int index = songList!
        .indexWhere((element) => element.id.compareTo(songListUUID) == 0);
    songList!.removeAt(index);
    box.put(Keys.localSongList, songList);
    update();
  }

  /// 创建歌单的中间弹窗
  addOrUpdateSongListDialog(SongListEntity? songListEntity) {
    String? imageLocalPath;
    if (songListEntity == null) {

    } else {
      songListNameContro.text = songListEntity.listTitle;
      imageLocalPath = songListEntity.listAlbum;
    }

    Get.defaultDialog(
      title: '请编辑歌单名称',
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: songListNameContro,
            ),
            SizedBox(
              height: 10,
            ),
            // TODO 选择完 不能立即显示  如何更新ui
            imageLocalPath != null
                ? Image.file(
                    File(imageLocalPath),
                    width: 50,
                    height: 50,
                  )
                : ElevatedButton(
                    onPressed: () async {
                      List<Media>? res = await ImagesPicker.pick(
                          count: 1,
                          pickType: PickType.image,
                          language: Language.System);
                      res?.forEach((element) {
                        developer.log(element.toString(), name: 'ImagesPicker');
                      });
                      imageLocalPath = res![0].path;
                    },
                    child: Icon(Icons.add_photo_alternate_outlined),
                  ),
          ],
        ),
      ),
      confirm: ElevatedButton(
          onPressed: () {
            addSongList(imageLocalPath);
            Get.back();
          },
          child: Text('确认')),
      cancel: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('取消')),
    );
  }
}
