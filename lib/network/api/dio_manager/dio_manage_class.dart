// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/log_in/log_in_screen.dart';
import 'package:inbox_driver/feature/view/screens/profile/log/log_screen.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'dart:async';

import 'package:logger/logger.dart';
import 'package:get/get.dart' as getx;

class DioManagerClass {
  DioManagerClass._();
  static final DioManagerClass getInstance = DioManagerClass._();
/*static*/ final String _baseUrlStage = "http://50.17.152.72/api/method/";
  /*static*/ final String _baseUrlLive = "http://mini.inbox.com.qa/api/method/";
  Dio? _dio;
  Dio init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrlLive,
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
    if(kDebugMode) {
      print("msg_request_url : $url");
      print("msg_request_header : $header");
      print("msg_request_body : $queryParameters");
    }
    return await _dio!.get(url,
        options: Options(headers: header), queryParameters: queryParameters);
  }

  Future<Response> dioPostMethod(
      {var url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? body}) async {
    if(kDebugMode) {
      print("msg_request_url : $url");
      print("msg_request_header : $header");
      print("msg_request_body : $body");
    }
    return await _dio!.post(
      url,
      options: Options(headers: header),
      data: body,
    );
  }

  Future<Response> dioPostFormMethod(
      {var url, Map<String, dynamic>? header, var body}) async {
    if(kDebugMode) {
      print("msg_request_url : $url");
      print("msg_request_header : $header");
      print("msg_request_body : $body");
    }
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
           print("msg_request_url : $url");
           if(kDebugMode) {
             print("msg_request_url : $url");
             print("msg_request_header : $header");
             print("msg_request_body : $body");
           }
    return await _dio!.put(url, options: Options(headers: header), data: body);
  }

  Future<Response> dioDeleteMethod(
      {var url,
      Map<String, dynamic>? header,
      Map<String, dynamic>? body}) async {
    if(kDebugMode) {
      print("msg_request_url : $url");
      print("msg_request_header : $header");
      print("msg_request_body : $body");
    }
    return await _dio!
        .delete(url, options: Options(headers: header), data: body);
  }
  handleNotAuthorized(var message){
    if (message.contains("غير مصرح له") || message.contains("Not Authorized") || message.contains("401")) {
      SharedPref.instance.setUserLoginState("${ConstanceNetwork.userEnterd}");
      getx.Get.offAll(() => const LoginScreen());
      return;
    }
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
    if (err.message.contains("غير مصرح له") || err.message.contains("Not Authorized") || err.message.contains("401")) {
      SharedPref.instance.setUserLoginState(ConstanceNetwork.userEnterd);
      getx.Get.offAll(() => const LoginScreen());
      return;
    }
  }
}
