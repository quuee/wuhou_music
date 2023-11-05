import 'dart:convert';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wuhoumusic/api/songs_list_api.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/model/songs_list_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/views/songs_list/ui/create_song_list_dialog.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:developer' as developer;


class SongsListController extends GetxController {
  final box = Hive.box(Keys.hiveSongList);

  LoadingStatus _loadingStatus = LoadingStatus.loading;
  get loadingStatus => _loadingStatus;

  List<SongsListEntity> songList = [];

  TextEditingController songListNameContro = TextEditingController();

  late EasyRefreshController easyRefreshController;

  final String songListBuilder = 'songListBuilder';

  String? songListImagePath;

  @override
  void onInit() {
    easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    super.onInit();
  }

  @override
  void onReady() {
    loadSongList();
    super.onReady();
  }

  @override
  onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }

  /// 加载本地歌单
  loadSongList() async {
    //  从hive获取本地歌单
    var temp = box.get(Keys.localSongList, defaultValue: <SongsListEntity>[]);
    songList = songListEntityFromJson(jsonEncode(temp));
    developer.log('加载本地歌单$songListEntityToJson(songList)',
        name: 'MineController loadSongList ');

    // todo 从服务端加载，比较云端和本地歌单，将本地不存在歌单写入hive
    var fetchList = await SongsListApi.fetchAllSongsList();
    List<SongsListEntity> cloudSongList = songListEntityFromJson(jsonEncode(fetchList));
    if (songList.isEmpty || songList.length < cloudSongList.length) {

      songList.addAll(cloudSongList);
    }
    _loadingStatus = LoadingStatus.success;
    update([songListBuilder]);
  }

  /// 下拉刷新
  pullDownRefresh() async {
    developer.log('onRefresh', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    loadSongList();
    // update([songListBuilder]);
    easyRefreshController.finishRefresh();
    easyRefreshController.resetFooter();
  }

  /// 上拉加载
  pullUponLoading() async {
    developer.log('onLoading', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    loadSongList();
    // update([songListBuilder]);
    easyRefreshController.finishLoad(IndicatorResult.success);
  }

  /// 创建 更新一个歌单
  createOrUpdateSongList(String? songListUUID) {

    if(songListUUID!=null){
      // 更新
      var s = SongsListEntity(
        id: songListUUID,
        listTitle: songListNameContro.text.trim(),
        listAlbum: songListImagePath ?? '',
        count: 0,
      );
      int index = songList.indexWhere((element) => element.id.compareTo(songListUUID) == 0);
      songList[index] = s;
    }else{
      // 新增
      var s = SongsListEntity(
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
  createOrUpdateSongListDialog(SongsListEntity? songListEntity) {

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
            songListImagePath = null;
            Get.back();
          },
          child: Text('取消')),
    );
  }

  computedCount(String songListUUID,List<SongEntity> tempList){
    // 拿到songListBox
    int index = songList.indexWhere((element) => element.id.compareTo(songListUUID) == 0);
    SongsListEntity gedan = songList[index];
    gedan.count = tempList.length;
    developer.log('更新歌单$songEntityToJson(mineController.songList)',name: 'SongListDetailController addSongToSongList');
    box.put(Keys.localSongList, songList);
  }

  /// 将歌单同步到云
  syncSongsList(SongsListEntity songListEntity){
    List<dynamic> temp = box.get(songListEntity.id, defaultValue: []);
    List<SongEntity> tempList = songEntityFromJson(jsonEncode(temp));

    Map<String, dynamic> map = Map();
    map['listTitle'] = songListEntity.listTitle;
    map['appslid'] = songListEntity.id;
    map['count'] = tempList.length;

    if(songListEntity.listAlbum.isNotEmpty && !songListEntity.listAlbum.startsWith('assets')){
      map['file'] = dio.MultipartFile.fromFileSync(songListEntity.listAlbum,
          filename: songListEntity.listAlbum
              .substring(songListEntity.listAlbum.lastIndexOf('/')));
    }

    SongsListApi.syncSongsList(map);

    Map<String, dynamic> map2 = Map();
    map2['appslid'] = songListEntity.id;
    map2['songs'] = tempList;
    // songs传上去是字符串，二次请求上传songs
    SongsListApi.syncSongs(map2);
  }
}
