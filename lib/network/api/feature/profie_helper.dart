import 'dart:convert';

import 'package:inbox_driver/feature/model/profile/driver_report_data.dart';
import 'package:inbox_driver/network/api/model/app_response.dart';
import 'package:inbox_driver/network/api/model/profile_api.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class ProfileHelper {
  ProfileHelper._();
  static final ProfileHelper getInstance = ProfileHelper._();
  var log = Logger();
  Future<AppResponse> logOut() async {
    var appResponse = await ProfileApi.getInstance.logOut(
      url: ConstanceNetwork.logOutEndPoint,
      header: ConstanceNetwork.header(4),
    );
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> deleteAccount() async {
    var appResponse = await ProfileApi.getInstance.deleteAccount(
      url: ConstanceNetwork.deleteAccountApi,
      header: ConstanceNetwork.header(2),
    );
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> editProfile(var body) async {
    var appResponse = await ProfileApi.getInstance.editProfile(
        body: body,
        url: ConstanceNetwork.editProfilEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }


  Future<DriverReportData> getDriverReport() async {
    var appResponse = await ProfileApi.getInstance.getDriverReport(
        url: ConstanceNetwork.driverReportRequestApi,
        header: ConstanceNetwork.header(4));
    Logger().d(appResponse.toJson());
    if (appResponse.status?.success == true ) {
        return DriverReportData.fromJson(appResponse.data);
    } else {
      return DriverReportData.fromJson({});
    }
  }

  Future<AppResponse> sendNote(Map<String, dynamic> body) async {
    var appResponse = await ProfileApi.getInstance.sendNote(
        body: body,
        url: "${ConstanceNetwork.createHelpDocPoint}",
        header: ConstanceNetwork.header(2));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }


}
