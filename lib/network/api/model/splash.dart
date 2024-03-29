import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_driver/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_driver/network/api/model/app_response.dart';
import 'package:logger/logger.dart';

class SplashApi {
  SplashApi._();
  static final SplashApi getInstance = SplashApi._();

  Future<AppResponse> getAppSettings({var url , var header})async{
    try {
      var response = await DioManagerClass.getInstance.dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  } 

}