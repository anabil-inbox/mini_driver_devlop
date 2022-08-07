import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/log_in/log_in_screen.dart';
import 'package:inbox_driver/feature/view/screens/home/home_screen.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/sh_util.dart';

import '../../../../../util/app_shaerd_data.dart';

class SplashScreen extends GetWidget<SplashViewModle> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Future.delayed(const Duration(seconds: 3), () => moveToIntro());
    return Scaffold(
        body: Center(child: SvgPicture.asset("assets/svgs/logo_new.svg"/*logo.svg*/)));
  }
}

moveToIntro() {
  String? state = SharedPref.instance.getUserLoginState();

  if (state?.toLowerCase() == ConstanceNetwork.userEnterd) {
    Get.off(() => const LoginScreen());
  } else if (state?.toLowerCase() == ConstanceNetwork.userLoginedState) {
    Get.offAll(() => HomeScreen());
    Get.put(AuthViewModle());
    Get.put(ProfileViewModle());

    //  Get.off(() => const LoginScreen());
  } else {
    Get.off(() => const LoginScreen());
  }
}
