
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:inbox_driver/fcm/app_fcm.dart';
import 'package:inbox_driver/feature/model/app_setting_modle.dart';
import 'package:inbox_driver/network/api/feature/splash_feature_helper.dart';
import 'package:logger/logger.dart';

class SplashViewModle extends GetxController{
    var log = Logger();
    ApiSettings? apiSettings;  
    // var pref = SharedPref.instance.init();
    // List<CompanySector> arrCompanySector = [];
    // List<String> arrSecName = [];
     
  getAppSetting()async{
     await SplashHelper.getInstance.getAppSettings().then((value) =>{
        if(!GetUtils.isNull(value)){
          apiSettings = value,
          update()
    }
   });
  }


  @override
  void onInit() async{
    getAppSetting();
    await AppFcm.fcmInstance.getTokenFCM();
    super.onInit();
  }

}