import 'package:inbox_driver/feature/model/app_setting_modle.dart';
import 'package:inbox_driver/network/api/model/splash.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:logger/logger.dart';

class SplashHelper {
  SplashHelper._();
  static final SplashHelper getInstance = SplashHelper._();
  var log = Logger();

  Future<ApiSettings> getAppSettings() async {
    try {
      var response = await SplashApi.getInstance.getAppSettings(
          url: ConstanceNetwork.settingeEndPoint,
          header: ConstanceNetwork.header(0));
      if (response.status?.success == true) {
        await SharedPref.instance.setAppSetting(response.data);
        return ApiSettings.fromJson(response.data);
      } else {
        return ApiSettings.fromJson({});
      }
    } catch (e) {
      log.d(e.toString());
      return ApiSettings.fromJson({});
    }
  }
}
