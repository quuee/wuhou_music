import 'dart:convert';
import 'dart:io';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as developer;

import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';

class MineController extends GetxController {
  final box = Hive.box(Keys.hiveSongList);

  List<SongListEntity> songList = [];

  TextEditingController songListNameContro = TextEditingController();

  late EasyRefreshController easyRefreshController;

  final ImagePicker _picker = ImagePicker();



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
  onClose(){
    easyRefreshController.dispose();
    super.onClose();
  }

  /// 加载本地歌单
  loadSongList() {
    //  从hive获取本地歌单
    var temp = box.get(Keys.localSongList, defaultValue: <SongListEntity>[]);
    songList = songListEntityFromJson(jsonEncode(temp));
    developer.log('加载本地歌单$songListEntityToJson(songList)',name: 'MineController loadSongList ');
    if (songList.isEmpty) {
      // todo 从服务端加载
    }

  }

  /// 下拉刷新
  pullDownRefresh() async {
    developer.log('onRefresh', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    loadSongList();
    update(['songListBuilder']);
    easyRefreshController.finishRefresh();
    easyRefreshController.resetFooter();
  }

  /// 上拉加载
  pullUponLoading() async {
    developer.log('onLoading', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    loadSongList();
    update(['songListBuilder']);
    easyRefreshController.finishLoad(IndicatorResult.success);
  }


  /// 创建一个歌单
  createSongList(String? imageLocalPath) {
    //如果两个字符串相等，返回0 ，否则返回非零数
    int index = songList.indexWhere((element) =>
        element.listTitle.compareTo(songListNameContro.text.trim()) == 0);
    if (index > 0) {
      Fluttertoast.showToast(
          msg: "已存在同名歌单",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    var s = SongListEntity(
        id: Uuid().v1(),
        listTitle: songListNameContro.text.trim(),
        listAlbum: imageLocalPath ?? '',
        count: 0,
        );
    songList.add(s);
    box.put(Keys.localSongList, songList);
    songListNameContro.clear();
    imageLocalPath = null;
    update(['songList']);
  }

  /// 删除一个歌单
  deleteSongList(String songListUUID) {
    int index = songList
        .indexWhere((element) => element.id.compareTo(songListUUID) == 0);
    songList.removeAt(index);
    box.put(Keys.localSongList, songList);
    update(['songListBuilder']);
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
                      XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      imageLocalPath = image != null ? image.path : null;
                    },
                    child: Icon(Icons.add_photo_alternate_outlined),
                  ),
          ],
        ),
      ),
      confirm: ElevatedButton(
          onPressed: () {
            createSongList(imageLocalPath);
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
