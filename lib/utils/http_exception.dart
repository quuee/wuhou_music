import 'package:dio/dio.dart';

///错误类型处理
class HttpException {
  static String handleException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.cancel:
        return "请求取消";
      case DioExceptionType.connectionTimeout:
        return "连接超时";
      case DioExceptionType.sendTimeout:
        return "请求超时";
      case DioExceptionType.receiveTimeout:
        return "响应超时";
      case DioExceptionType.badResponse:
        return "出现异常";
      case DioExceptionType.unknown:
        return "未知错误";
      case DioExceptionType.badCertificate:
        return "错误凭证";
      case DioExceptionType.connectionError:
        return "连接错误";
      default:
        return "未知错误";
    }
  }
}