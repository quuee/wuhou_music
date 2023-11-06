import 'dart:convert';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/api/songs_list_api.dart';
import 'package:wuhoumusic/model/sl_songs_entity.dart';
import 'package:wuhoumusic/model/song_entity.dart';
import 'package:wuhoumusic/model/songs_list_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/views/songs_list/ui/create_song_list_dialog.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:developer' as developer;


class SongsListController extends GetxController {
  // final songsListBox = Hive.box(Keys.hiveSongsList);

  LoadingStatus _loadingStatus = LoadingStatus.loading;
  get loadingStatus => _loadingStatus;

  List<SongsListEntity> songsList = [];

  TextEditingController songListNameContro = TextEditingController();

  late EasyRefreshController easyRefreshController;

  static const String songListBuilder = 'songListBuilder';

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
    loadLocalSongsList();
    super.onReady();
  }

  @override
  onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }

  /// 加载本地歌单
  loadLocalSongsList() async {
    // 从hive获取本地歌单
    // 只要box更新或删除 一个值，这里取值就为空。debug时，是有值put进去，但是取为空。关闭应用重新查询又有值
    // var temp = Hive.box(Keys.hiveSongsList).get(Keys.localSongsList,defaultValue: <SongsListEntity>[]);
    // songsList = songListEntityFromJson(jsonEncode(temp));
    songsList = IsarHelper.instance.isarInstance.songsListEntitys.where().findAllSync();

    developer.log('加载本地歌单$songListEntityToJson(songList)',
        name: 'MineController loadSongList ');

    _loadingStatus = LoadingStatus.success;
    update([songListBuilder]);
  }

  /// 获取云端歌单
  fetchCloudSongsList() async {
    // todo 从服务端加载，比较云端和本地歌单，将本地不存在歌单写入hive
    var fetchList = await SongsListApi.fetchAllSongsList();
    List<SongsListEntity> cloudSongList = songListEntityFromJson(jsonEncode(fetchList));
    List<SongsListEntity> cloneList = List.from(songsList);
    if(cloneList.isEmpty){
      songsList.addAll(cloudSongList);
    }else{
      for (var songList in cloneList) {
        for (var cloudSongList in cloudSongList) {
          if(songList.slid?.compareTo(cloudSongList.slid!) != 0){
            songsList.add(cloudSongList);
          }
        }
      }
      // 存入本地hive
    }

    update([songListBuilder]);
  }

  /// 下拉刷新
  pullDownRefresh() async {
    developer.log('onRefresh', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    songsList.clear();
    loadLocalSongsList();
    fetchCloudSongsList();
    easyRefreshController.finishRefresh();
    easyRefreshController.resetFooter();
    update([songListBuilder]);
  }

  /// 上拉加载
  pullUponLoading() async {
    developer.log('onLoading', name: 'MineController');
    await Future.delayed(Duration(milliseconds: 500));
    loadLocalSongsList();
    fetchCloudSongsList();
    easyRefreshController.finishLoad(IndicatorResult.success);
    update([songListBuilder]);
  }

  /// 创建 更新一个歌单
  createOrUpdateSongList(int? apslid) {
    SongsListEntity s;
    if(apslid!=null){
      // 更新
      s = SongsListEntity(
        apslid: apslid,
        listTitle: songListNameContro.text.trim(),
        listAlbum: songListImagePath ?? '',
        count: 0,
      );
      // int index = songsList.indexWhere((element) => element.id.compareTo(songListUUID) == 0);
      // songsList[index] = s;

    }else{
      // 新增
      s = SongsListEntity(
        // apslid: Uuid().v1(),
        listTitle: songListNameContro.text.trim(),
        listAlbum: songListImagePath ?? '',
        count: 0,
      );

    }
    IsarHelper.instance.isarInstance.writeTxn(() async {
      return await IsarHelper.instance.isarInstance.songsListEntitys.put(s);
    });

    // Hive.box(Keys.hiveSongsList).put(Keys.localSongsList, songsList);

    songListNameContro.clear();
    songListImagePath = null;
    update([songListBuilder]);
  }

  /// 删除一个歌单
  deleteSongList(int apslid) {
    // int index = songsList
    //     .indexWhere((element) => element.id.compareTo(songListUUID) == 0);
    // songsList.removeAt(index);
    // Hive.box(Keys.hiveSongsList).put(Keys.localSongsList, songsList);
    IsarHelper.instance.isarInstance.writeTxn(() {
      return IsarHelper.instance.isarInstance.songsListEntitys.delete(apslid);

    });

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
            createOrUpdateSongList(songListEntity?.apslid);
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

  // computedCount(String songListUUID,List<SongEntity> songs){
  //   // var temp = Hive.box(Keys.hiveSongsList).get(Keys.localSongsList,defaultValue: <SongsListEntity>[]);
  //   // List<SongsListEntity> tempList2 = songListEntityFromJson(jsonEncode(temp));
  //   // 拿到songListBox
  //   // int index = songsList.indexWhere((element) => element.id.compareTo(songListUUID) == 0);
  //   // SongsListEntity gedan = songsList[index];
  //   // gedan.count = songs.length;
  //   // developer.log('更新歌单$songListUUID',name: 'songs_list_controller computedCount');
  //   // Hive.box(Keys.hiveSongsList).put(Keys.localSongsList, songsList);
  // }

  /// 将歌单同步到云
  syncSongsList(SongsListEntity songListEntity){
    // final songsBox = Hive.box(Keys.hiveSongs);
    // List<dynamic> temp = songsBox.get(songListEntity.id, defaultValue: []);
    // List<SongEntity> tempList = songEntityFromJson(jsonEncode(temp));
    List<SLSongsEntity> sls = IsarHelper.instance.isarInstance.sLSongsEntitys.filter().apslidEqualTo(songListEntity.apslid).findAllSync();
    List<int> ids = sls.map((e) => e.sid!).toList();
    List<SongEntity?> songs = IsarHelper.instance.isarInstance.songEntitys.getAllSync(ids);
    Map<String, dynamic> map = Map();
    map['listTitle'] = songListEntity.listTitle;
    map['appslid'] = songListEntity.apslid;
    map['count'] = songs.length;

    if(songListEntity.listAlbum!=null && !songListEntity.listAlbum!.startsWith('assets')){
      map['file'] = dio.MultipartFile.fromFileSync(songListEntity.listAlbum!,
          filename: songListEntity.listAlbum!
              .substring(songListEntity.listAlbum!.lastIndexOf('/')));
    }

    SongsListApi.syncSongsList(map);

    Map<String, dynamic> map2 = Map();
    map2['appslid'] = songListEntity.apslid;
    map2['songs'] = songs;
    // songs传上去是字符串，二次请求上传songs
    SongsListApi.syncSongs(map2);
  }
}
