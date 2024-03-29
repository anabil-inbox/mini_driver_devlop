import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inbox_driver/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class ProfileApi {
  ProfileApi._();
  static final ProfileApi getInstance = ProfileApi._();

  // Future<AppResponse> addNewAddress({var url, var header, var body}) async {
  //   try {
  //     var response = await DioManagerClass.getInstance
  //         .dioPostMethod(url: url, header: header, body: body);
  //     return AppResponse.fromJson(json.decode(response.toString()));
  //   } on DioError catch (ex) {
  //     var message = json.decode(ex.response.toString());
  //     Logger().e(message);
  //     return AppResponse.fromJson(message);
  //   }
  // }

  // Future<AppResponse> getMyAddress({var url, var header, var body}) async {
  //   try {
  //     var response = await DioManagerClass.getInstance
  //         .dioGetMethod(url: url, header: header);
  //     return AppResponse.fromJson(json.decode(response.toString()));
  //   } on DioError catch (ex) {
  //     var message = json.decode(ex.response.toString());
  //     Logger().e(message);
  //     return AppResponse.fromJson(message);
  //   }
  // }

  // Future<AppResponse> uppdateAddress({var url, var header, var body}) async {
  //   try {
  //     var response = await DioManagerClass.getInstance
  //         .dioPostMethod(url: url, header: header, body: body);
  //     return AppResponse.fromJson(json.decode(response.toString()));
  //   } on DioError catch (ex) {
  //     var message = json.decode(ex.response.toString());
  //     Logger().e(message);
  //     return AppResponse.fromJson(message);
  //   }
  // }

  // Future<AppResponse> deleteAddress({var url, var header, var body}) async {
  //   try {
  //     var response = await DioManagerClass.getInstance
  //         .dioPostMethod(url: url, header: header, body: body);
  //     return AppResponse.fromJson(json.decode(response.toString()));
  //   } on DioError catch (ex) {
  //     var message = json.decode(ex.response.toString());
  //     Logger().e(message);
  //     return AppResponse.fromJson(message);
  //   }
  // }

  Future<AppResponse> logOut({var url, var header}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> deleteAccount({var url, var header}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> editProfile({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header, body: body);

      // Logger().i("editProfile_response ${response.statusCode}");
      // if (response.toString().toLowerCase().contains("success:false")) {
      //   print("msg_if_false");
      // } else {
      //   print("msg_if_true");
      //   await SharedPref.instance.setCurrentUserData(response.toString());
      // }
      
       var jsonMap = json.decode(response.toString());
       Logger().e("msg_res_map $jsonMap");
      if (jsonMap["status"]["success"] != false) {
        SharedPref.instance.setCurrentUserData(response.toString());
        SharedPref.instance.setUserToken(jsonMap["data"]["access_token"] ??
            "${SharedPref.instance.getUserToken()}");
      }


      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }

Future<AppResponse> getDriverReport({var url, var header, var body}) async {
  try {
    var response = await DioManagerClass.getInstance
        .dioGetMethod(url: url, header: header);
    return AppResponse.fromJson(json.decode(response.toString()));
  } on DioError catch (ex) {
    var message = json.decode(ex.response.toString());
    Logger().e(message);
    DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
    return AppResponse.fromJson(message);
  }
}

  Future<AppResponse> sendNote({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostMethod(url: url, header: header, body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      DioManagerClass.getInstance.handleNotAuthorized(message["status"]["message"]);
      return AppResponse.fromJson(message);
    }
  }

}
