
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:wuhoumusic/api/songs_list_api.dart';
import 'package:wuhoumusic/model/audio/sl_songs_entity.dart';
import 'package:wuhoumusic/model/audio/song_entity.dart';
import 'package:wuhoumusic/model/audio/songs_list_entity.dart';
import 'package:wuhoumusic/resource/loading_status.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/views/songs_list/ui/create_song_list_dialog.dart';
import 'package:dio/dio.dart' as dio;

class SongsListController extends GetxController {
  LoadingStatus _loadingStatus = LoadingStatus.loading;
  get loadingStatus => _loadingStatus;

  List<SongsListEntity> songsList = [];

  TextEditingController songListNameContro = TextEditingController();

  late EasyRefreshController easyRefreshController;

  // static const String songListBuilder = 'songListBuilder';

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
  loadLocalSongsList() {
    // 从hive获取本地歌单
    // 只要box更新或删除 一个值，这里取值就为空。debug时，是有值put进去，但是取为空。关闭应用重新查询又有值
    // var temp = Hive.box(Keys.hiveSongsList).get(Keys.localSongsList,defaultValue: <SongsListEntity>[]);
    // songsList = songListEntityFromJson(jsonEncode(temp));
    songsList =
        IsarHelper.instance.isarInstance.songsListEntitys.where().findAllSync();
    LogD('SongsListController', '加载本地歌单');
    _loadingStatus = LoadingStatus.success;
    update();
  }

  // 获取云端歌单
  // fetchCloudSongsList() async {
  //   从服务端加载，比较云端和本地歌单，将本地不存在歌单写入hive
  //   var fetchList = await SongsListApi.fetchAllSongsList();
  //   List<SongsListEntity> cloudSongList = songListEntityFromJson(jsonEncode(fetchList));
  //   List<SongsListEntity> cloneList = List.from(songsList);
  //   if(cloneList.isEmpty){
  //     songsList.addAll(cloudSongList);
  //   }else{
  //     for (var songList in cloneList) {
  //       for (var cloudSongList in cloudSongList) {
  //         if(songList.slid?.compareTo(cloudSongList.slid!) != 0){
  //           songsList.add(cloudSongList);
  //         }
  //       }
  //     }
  //     // 存入本地hive
  //   }
  //
  //   update([songListBuilder]);
  // }

  /// 下拉刷新
  pullDownRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    songsList.clear();
    songsList =
        IsarHelper.instance.isarInstance.songsListEntitys.where().findAllSync();
    LogD('SongsListController', '下拉刷新');
    _loadingStatus = LoadingStatus.success;
    easyRefreshController.finishRefresh();
    easyRefreshController.resetFooter();
    update();
  }

  /// 上拉加载
  pullUponLoading() async {
    await Future.delayed(Duration(milliseconds: 500));
    // loadLocalSongsList();
    easyRefreshController.finishLoad(IndicatorResult.success);
    update();
  }

  /// 创建 更新一个歌单
  createOrUpdateSongList(int? apslid) {
    SongsListEntity s;
    if (apslid != null) {
      // 更新
      s = SongsListEntity(
        apslid: apslid,
        listTitle: songListNameContro.text.trim(),
        listAlbum: songListImagePath ?? '',
        count: 0,
      );
    } else {
      // 新增
      s = SongsListEntity(
        listTitle: songListNameContro.text.trim(),
        listAlbum: songListImagePath ?? '',
        count: 0,
      );
    }
    IsarHelper.instance.isarInstance.writeTxnSync(() {
      return IsarHelper.instance.isarInstance.songsListEntitys.putSync(s);
    });
    songListNameContro.clear();
    songListImagePath = null;

    loadLocalSongsList();
  }

  /// 删除一个歌单
  deleteSongList(int apslid) {
    IsarHelper.instance.isarInstance.writeTxn(() {
      return IsarHelper.instance.isarInstance.songsListEntitys.delete(apslid);
    });
    loadLocalSongsList();
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
          // style: ButtonStyle(),
          child: Text('确认',style: TextStyle(fontSize: 16),)),
      cancel: ElevatedButton(
          onPressed: () {
            songListNameContro.clear();
            songListImagePath = null;
            Get.back();
          },
          child: Text('取消',style: TextStyle(fontSize: 16))),
    );
  }

  /// 将歌单同步到云
  _syncSongsList(SongsListEntity songListEntity) {
    List<SLSongsEntity> sls = IsarHelper.instance.isarInstance.sLSongsEntitys
        .filter()
        .apslidEqualTo(songListEntity.apslid!)
        .findAllSync();
    List<int> ids = sls.map((e) => e.sid).toList();
    List<SongEntity?> songs =
        IsarHelper.instance.isarInstance.songEntitys.getAllSync(ids);
    Map<String, dynamic> map = Map();
    map['listTitle'] = songListEntity.listTitle;
    map['appslid'] = songListEntity.apslid;
    map['count'] = songs.length;

    if (songListEntity.listAlbum != null &&
        !songListEntity.listAlbum!.startsWith('assets')) {
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
