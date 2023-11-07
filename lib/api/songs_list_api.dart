import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wuhoumusic/utils/api_result.dart';
import 'package:wuhoumusic/utils/http_exception.dart';
import 'package:wuhoumusic/utils/log_util.dart';
import 'package:wuhoumusic/utils/request_client.dart';


class SongsListApi {

  /// 将歌单同步到云
  static Future<dynamic> syncSongsList(Map<String, dynamic> map) async {

    // Map<String, dynamic> map = Map();
    // map['listTitle'] = songListEntity.listTitle;
    // map['appid'] = songListEntity.id;
    // map['count'] = songListEntity.count;
    // if(songListEntity.listAlbum.isNotEmpty && !songListEntity.listAlbum.startsWith('assets')){
    //   map['file'] = MultipartFile.fromFileSync(songListEntity.listAlbum,
    //       filename: songListEntity.listAlbum
    //           .substring(songListEntity.listAlbum.lastIndexOf('/')));
    // }

    var formData = FormData.fromMap(map);

    try{
      Options op = Options(
        contentType: Headers.multipartFormDataContentType,
        method: RequestClient.post
      );

      Response response = await RequestClient.instance
          .request( '/songsList/sync', data: formData,options:op );

      ApiResult apiResult = ApiResult.fromJson(response.data);

      if (apiResult.data == null) {
        return null;
      }
      LogD("SongsListApi syncSongsList",jsonEncode(apiResult));

      return apiResult;
    }on DioException catch (e) {
      String handleException = HttpException.handleException(e);
      LogE("SongsListApi syncSongsList DioException",handleException);
      return null;
    }

  }

  /// 将歌单中的歌曲同步到云
  static Future<dynamic> syncSongs(Map<String, dynamic> map) async {
    Options op = Options(
        contentType: Headers.jsonContentType,
        method: RequestClient.post
    );
    Response response = await RequestClient.instance
        .request( '/songsList/syncSongs', data: map,options:op );
    ApiResult apiResult = ApiResult.fromJson(response.data);
    if (apiResult.data == null) {
      return null;
    }
    LogD("SongsListApi syncSongs",jsonEncode(apiResult));

    return apiResult;
  }

  /// 拉取服务端歌单
  static Future<dynamic> fetchAllSongsList() async {
    Options op = Options(
        contentType: Headers.jsonContentType,
        method: RequestClient.get
    );
    Response response = await RequestClient.instance
        .request( '/songsList/fetchAll',options:op );

    ApiResult apiResult = ApiResult.fromJson(response.data);
    if (apiResult.data == null) {
      return null;
    }
    LogD("SongsListApi fetchAllSongsList",jsonEncode(apiResult));

    return apiResult.data;
  }

  /// 根据歌单id查询歌曲
  static Future<dynamic> fetchSongsBySLID(String slid) async {
    Options op = Options(
        contentType: Headers.jsonContentType,
        method: RequestClient.get
    );
    Map<String,dynamic> map = Map();
    map['slid'] = slid;
    Response response = await RequestClient.instance
        .request( '/songsList/fetchAll', params: map,options:op );

    ApiResult apiResult = ApiResult.fromJson(response.data);
    if (apiResult.data == null) {
      return null;
    }
    LogD("SongsListApi fetchSongsBySLID",jsonEncode(apiResult));

    return apiResult.data;
  }

  /// TODO 将歌曲文件上传到云
}
