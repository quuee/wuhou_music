import 'package:dio/dio.dart';
import 'package:wuhoumusic/model/user_entity.dart';
import 'package:wuhoumusic/utils/api_result.dart';
import 'package:wuhoumusic/utils/http_exception.dart';
import 'package:wuhoumusic/utils/request_client.dart';
import 'dart:developer' as developer;

class UserApi {
  // static Future<UserEntity?> getUserInfo() async {
  //   UserEntity userEntity;
  //   try {
  //     Response response = await RequestClient.instance.request(RequestClient.get,"/user/info");
  //     ApiResult apiResult = ApiResult.fromJson(response.data);
  //
  //     if (apiResult.data == null) {
  //       return null;
  //     }
  //     userEntity = UserEntity.fromJson(apiResult.data!);
  //     developer.log(userEntity.toRawJson(), name: 'UserApi getUserInfo');
  //   } on DioException catch (e) {
  //     String handleException = HttpException.handleException(e);
  //     developer.log(handleException, name: 'UserApi getUserInfo');
  //     return null;
  //   }
  //
  //   return userEntity;
  // }
}
