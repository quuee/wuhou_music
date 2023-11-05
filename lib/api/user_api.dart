import 'package:dio/dio.dart';
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

  static Future<ApiResult?> accountLogin(
      String account, String password) async {
    Map<String, dynamic> map = Map();
    map['accountName'] = account;
    map['password'] = password;
    var op = Options(
        contentType: Headers.jsonContentType, method: RequestClient.post);
    try {
      var response = await RequestClient.instance
          .request('/account/login', data: map, options: op);
      ApiResult apiResult = ApiResult.fromJson(response.data);
      if (apiResult.data == null) {
        return null;
      }
      developer.log(apiResult.toString(), name: 'UserApi accountLogin');
      return apiResult;
    } on DioException catch (e) {
      String handleException = HttpException.handleException(e);
      developer.log(handleException, name: 'UserApi accountLogin');
      return null;
    }
  }
}
