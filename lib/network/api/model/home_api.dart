import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_driver/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_driver/network/api/model/app_response.dart';
import 'package:logger/logger.dart';

class HomeApi {
  HomeApi._();
  static final HomeApi getInstance = HomeApi._();

  Future<AppResponse> getHomeTasks({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> getSpecificTask({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }

    Future<AppResponse> scanBox({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }
  
}
