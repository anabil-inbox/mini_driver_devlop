import 'package:dio/dio.dart';
import 'dart:async';

import 'package:logger/logger.dart';

class DioManagerClass {
  DioManagerClass._();
  static final DioManagerClass getInstance = DioManagerClass._();

  Dio? _dio;
  Dio init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://50.17.152.72/api/method/",
        connectTimeout: 2000 * 60,
        receiveTimeout: 2000 * 60,
        sendTimeout: 2000 * 60,
        receiveDataWhenStatusError: true,
      ),
    );
    _dio?.interceptors.add(ApiInterceptors());
    return _dio!;
  }

  Future<Response> dioGetMethod(
      {var url, Map<String, dynamic>? header, var queryParameters}) async {
    return await _dio!.get(url,
        options: Options(headers: header), queryParameters: queryParameters);
  }

  Future<Response> dioPostMethod(
      {var url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? body}) async {
    return await _dio!.post(
      url,
      options: Options(headers: header),
      data: body,
    );
  }

  Future<Response> dioPostFormMethod(
      {var url, Map<String, dynamic>? header, var body}) async {
    print("msg_request_url : $url");
    print("msg_request_header : $header");
    print("msg_request_body : $body");
    return await _dio!.post(
      url,
      options: Options(headers: header),
      data: FormData.fromMap(body),
    );
  }

  Future<Response> dioUpdateMethod(
      {var url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? body}) async {
    return await _dio!.put(url, options: Options(headers: header), data: body);
  }

  Future<Response> dioDeleteMethod(
      {var url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? body}) async {
    return await _dio!
        .delete(url, options: Options(headers: header), data: body);
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    Logger().d(
        "onRequest : ${options.path} \n ${options.data} \n ${options.method}");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    Logger().d("onResponse : ${response.statusCode}");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    Logger().d("onError : ${err.message}");
  }
}