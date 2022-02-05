import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inbox_driver/fcm/app_fcm.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/sh_util.dart';

import 'feature/core/app_widget.dart';
import 'feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'network/api/dio_manager/dio_manage_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppFcm.fcmInstance.init();
  await SharedPref.instance.init();
  portraitOrientation();
  DioManagerClass.getInstance.init();
  enableHybridComposition();
  runApp(const AppWidget());
}

///To use Hybrid Composition to render the GoogleMap widget on Android,
/// set AndroidGoogleMapsFlutter.useAndroidViewSurface to true.
void enableHybridComposition(){
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
}




class BindingsController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashViewModle());
    Get.lazyPut(() => AuthViewModle());
    Get.lazyPut(() => ProfileViewModle());
    Get.lazyPut(() => HomeViewModel());
  }
}
