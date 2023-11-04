import 'package:dio/dio.dart';
import 'package:wuhoumusic/model/song_list_entity.dart';
import 'package:wuhoumusic/utils/api_result.dart';
import 'package:wuhoumusic/utils/http_exception.dart';
import 'package:wuhoumusic/utils/request_client.dart';
import 'dart:developer' as developer;

class SongsListApi {
  static Future<dynamic?> createSongsList(SongListEntity songListEntity) async {
    Map<String, dynamic> map = Map();
    map['listTitle'] = songListEntity.listTitle;
    map['appid'] = songListEntity.id;
    map['count'] = songListEntity.count;
    map['file'] = MultipartFile.fromFileSync(songListEntity.listAlbum,
        filename: songListEntity.listAlbum
            .substring(songListEntity.listAlbum.lastIndexOf('/')));

    var formData = FormData.fromMap(map);

    try{
      var op = Options(
        contentType: Headers.multipartFormDataContentType,
        method: RequestClient.post
      );

      Response response = await RequestClient.instance
          .request( '/songsList/create', data: formData,options:op );

      ApiResult apiResult = ApiResult.fromJson(response.data);

      if (apiResult.data == null) {
        return null;
      }
      developer.log(apiResult.toString(), name: 'SongsListApi createSongsList');
    }on DioException catch (e) {
      String handleException = HttpException.handleException(e);
      developer.log(handleException, name: 'SongsListApi createSongsList');
      return null;
    }

  }
}
