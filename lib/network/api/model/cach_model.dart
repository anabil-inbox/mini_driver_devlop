import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_driver/network/api/dio_manager/dio_manage_class.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class CashModel {
  CashModel._();
  static final CashModel getInstance = CashModel._();
  var log =  Logger();
  Future<AppResponse> getCashCloser({var url , var header , var queryParameters })async{
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(url: url, header: header , queryParameters: queryParameters);
      return AppResponse.fromJson(json.decode(response.toString()));
    }  on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message??{});
    }

  }


  Future<AppResponse> applyCashCloser({var url , var header , var body })async{
    try {
      var response = await DioManagerClass.getInstance.dioPostMethod(url: url, header: header , body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    }  on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message??{});
    }
  }
}