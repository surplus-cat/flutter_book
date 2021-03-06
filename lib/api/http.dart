import 'package:dio/dio.dart';


class HttpRequest {
  final Dio dio = Dio();

  httpRequest () {
    // api地址
    dio.options.baseUrl = 'http://172.20.10.9:8080/v1/';
    // 请求超时时间
    dio.options.receiveTimeout = 15000;
    // 增加拦截器
    dio.interceptors
      ..add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print('加入token>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        // 请求加入token
        options.headers['csrfToken'] = 'csrfToken';
        return options;
      }, onResponse: (Response response) {
        print('onResponse------------------');
        // 在返回响应数据之前做一些预处理
        return response;
      }, onError: (DioError error) {
        print('---------------->>>>>>>>>>>>>>>>>>error');
        print(error);
        // 当请求失败时做一些预处理
        return error;  //continue
      }))..add(LogInterceptor());
  }
}