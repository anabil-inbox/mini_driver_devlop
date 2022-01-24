import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/details/order_details_started_screen.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/localization/localization_service.dart';
import 'package:inbox_driver/util/sh_util.dart';


import '../../main.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 803.6363636363636),
      builder: () => GetMaterialApp(
        title: 'Inbox Driver',
        locale: SharedPref.instance.getLocalization() == Constance.arabicKey
              ? LocalizationService.localeAr
              : LocalizationService.localeEn,
        initialBinding: BindingsController(),
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        debugShowCheckedModeBanner: false,
        enableLog: true,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          fontFamily: Constance.Font_regular,
          cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: colorPrimary,
          ),
          backgroundColor: scaffoldColor,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: colorPrimary,
            selectionColor: colorPrimary,
            selectionHandleColor: colorPrimary,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: textStyleHints(),
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorTrans),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorPrimary),
            ),
            fillColor: colorTextWhite,
            contentPadding: EdgeInsets.symmetric(
                horizontal: padding18!, vertical: padding16!),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(padding4!)),
          ),
          primaryColor: colorPrimary,
          secondaryHeaderColor: seconderyColor,
          scaffoldBackgroundColor: scaffoldColor,
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          )),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
        ),
       home: const OrderDetailsStarted()
        // home: const ProfileScreen(),
      ),
    );
  }
}
