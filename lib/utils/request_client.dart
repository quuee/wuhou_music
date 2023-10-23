import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class RequestClient {
  /// default options
  static const String apiPrefix=
      'http://192.168.2.143:10068/api-v1'; // dio不能解析127.0.0.1
  //请求时间
  static const int connectTimeout = 60;
  //响应时间
  static const int receiveTimeout = 60;

  static const int sendTimeout = 60;

  late Dio _mDio;
  late BaseOptions options;

  static const String get = 'get';
  static const String post = 'post';
  static const String put = 'put';
  static const String patch = 'patch';
  static const String delete = 'delete';

  static RequestClient get instance => RequestClient._internal();

  RequestClient._internal() {
    developer.log('RequestClient._internal()', name: 'RequestClient');

    /// 全局属性：请求前缀、连接超时时间、响应超时时间
    BaseOptions options = BaseOptions(
        baseUrl: apiPrefix,
        connectTimeout: const Duration(seconds: connectTimeout),
        receiveTimeout: const Duration(seconds: receiveTimeout),
        sendTimeout: const Duration(seconds: sendTimeout),
        contentType: Headers.jsonContentType);

    _mDio = Dio(options);

    _mDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
          // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
          return handler.next(e);
        },
      ),
    );
    _mDio.interceptors.add(LogInterceptor(responseBody: true));

  }

  factory RequestClient() {
    return instance;
  }

  ///query参数是拼接到url问号后面的，data是在请求体里的，由于get方法没有请求体，所以只能接受query
  Future<Response<T>> request<T>(
    String method,
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
  }) async {

     Response<T> resp = await _mDio.request(url,
          data: data,
          queryParameters: params,
          options: Options(method: method));
      return resp;

  }


}
