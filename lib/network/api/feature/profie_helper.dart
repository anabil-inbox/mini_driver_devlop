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



}
