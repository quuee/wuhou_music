import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as Getx;
import 'package:isar/isar.dart';
import 'package:wuhoumusic/model/any_entity.dart';
import 'package:wuhoumusic/resource/constant.dart';
import 'package:wuhoumusic/routes/app_routes.dart';
import 'package:wuhoumusic/utils/isar_helper.dart';
import 'package:wuhoumusic/utils/log_util.dart';

class RequestClient {

  static const String apiPrefix=
      'http://192.168.2.143:10070/api-v1'; // dio不能解析127.0.0.1
  static const String imagesPrefix = 'http://192.168.2.124:9000/images/';
  static const String songsPrefix = 'http://192.168.2.124:9000/songs/';
  //请求时间
  static const int connectTimeout = 30;
  //响应时间
  static const int receiveTimeout = 30;

  static const int sendTimeout = 30;

  late Dio _mDio;
  late BaseOptions options;

  static const String get = 'get';
  static const String post = 'post';
  static const String put = 'put';
  static const String patch = 'patch';
  static const String delete = 'delete';

  static final RequestClient _instance = RequestClient._();
  factory RequestClient() => _instance;

  static RequestClient get instance => RequestClient();

  RequestClient._() {

    LogI('RequestClient', 'RequestClient._()');

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

          String? token = IsarHelper.instance.isarInstance
              .anyEntitys.filter().keyNameEqualTo(Keys.token).findFirstSync()?.anything;
          if(token!=null && token.isNotEmpty){
            Map<String,dynamic> header = Map();
            header['Authorization'] = token;
            options.headers.addAll(header);
          }

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。

          // 凭证过期
          bool b = response.data['code'] == 493;
          if(b){
            // 可能多个请求 跳转多次
            Fluttertoast.showToast(msg: '登录已过期请重新登录');
            Getx.Get.offAllNamed(Routes.login);
            IsarHelper.instance.isarInstance.writeTxn(() async {
              AnyEntity? t = await IsarHelper.instance.isarInstance.anyEntitys.filter().keyNameEqualTo(Keys.token).findFirst();
              if(t!=null){
               await IsarHelper.instance.isarInstance.anyEntitys.delete(t.id!);
              }
            });
            return;
          }

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

  ///query参数是拼接到url问号后面的，data是在请求体里的，由于get方法没有请求体，所以只能接受query
  Future<Response<T>> request<T>(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
        Options? options
  }) async {

     Response<T> resp = await _mDio.request(url,
          data: data,//data是在请求体里的
          queryParameters: params,//query参数是拼接到url问号后面的
          options: options);
      return resp;

  }



}
