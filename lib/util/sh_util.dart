// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/utils.dart';
import 'package:inbox_driver/feature/model/app_setting_modle.dart';
import 'package:inbox_driver/feature/model/driver_modle.dart';
import 'package:inbox_driver/feature/model/language.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref instance = SharedPref._();

  final String appSettingKey = "settings";
  final String languageKey = "language";
  final String isShowKey = "loading";
  final String currentUser = "currentUser";
  final String loginKey = "login";
  final String fcmKey = "fcm";
  final String tokenKey = "token_driver";
  final String customrKey = "customerKey";
  final String userDataKey = "userData";
  final String taskKey = "taskKey";
  final String isStartedTimerKey = "isStartedTimerKey";
  final String timerValueKey = "timerValueKey";
  final String deliveredDateTime = "DeliveredDateTime";
  final String taskIdKey = "taskIdKey";

  var log = Logger();

  SharedPref._();

  static SharedPreferences? _prefs;

  setAppSetting(var json) async {
    String prfApiSettings = jsonEncode(json);
    _prefs?.setString(appSettingKey, prfApiSettings);
  }

  // setCurrentTaskResponse({required String taskResponse}) {
  //   try {
  //     _prefs?.remove(taskKey);
  //     _prefs?.setString(taskKey, jsonEncode(jsonDecode(taskResponse)));
  //   } catch (e) {
  //     Logger().e(e);
  //   }
  // }

  setIsStartedTimerKey({required bool isStarted}) {
    _prefs?.setBool(isStartedTimerKey, isStarted);
  }

  bool getIsStartedTimerKey() {
    return _prefs?.getBool(isStartedTimerKey) ?? false;
  }

  setTimeValue({required int timerNewValue}) {
    _prefs?.setInt(timerValueKey, timerNewValue);
  }

  int getTimerValue() {
    return _prefs?.getInt(timerValueKey) ??
        ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()))
            .waitingTime ??
        5 * 60;
  }

  // TaskResponse? getCurrentTaskResponse() {
  //   try {
  //     String? objectStr = _prefs?.getString(taskKey);
  //     Map<String, dynamic> map = jsonDecode(objectStr!);
  //     return TaskResponse.fromJson(map);
  //   } catch (e) {
  //     Logger().e(e);
  //     return null;
  //   }
  // }

  setLocalization(String lang) {
    _prefs?.setString(_localizationKey, lang);
  }

  String getLocalization() {
    try {
      return _prefs?.getString(_localizationKey) ?? Constance.englishKey;
    } catch (e) {
      print(e);
      return Constance.englishKey;
    }
  }

  setCurrentUserData(String profileData) async {
    try {
      print("msg_profile_data_to_save $profileData");
      bool? isSaved =
          await _prefs?.setString(userDataKey, profileData.toString());
      print(isSaved);
    } catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  Driver? getCurrentUserData() {
    try {
      var string = _prefs?.getString(userDataKey);
      var decode;
      if (GetUtils.isNull(json.decode(string!)["data"]["Driver"])) {
        print("get Current user if");
        decode = json.decode(string)["data"];
      } else {
        decode = json.decode(string)["data"]["Driver"];
      }
      Driver profileData = Driver.fromJson(decode);
      return profileData;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  getAppSetting() {
    try {
      Object appSetting = _prefs!.get(appSettingKey)!;
      return appSetting;
    } catch (e) {
      log.d("$e");
    }
  }

  // List<CompanySector>? getAppSectors() {
  //   try {
  //     return ApiSettings.fromJson(
  //             json.decode(_prefs!.get("$appSettingKey").toString()))
  //         .companySectors;
  //   } catch (e) {
  //     print("e");
  //   }
  // }

  List<Language>? getAppLanguage() {
    try {
      return ApiSettings.fromJson(
              json.decode(_prefs!.get(appSettingKey).toString()))
          .languges ;
    } catch (e) {
      print(e);
       return null;
    }
  }

  getShowProgress() {
    try {
      return _prefs?.getBool(isShowKey) ?? false;
    } catch (e) {
      print(e);
    }
  }

  setAppLanguage(var local) async {
    _prefs?.setString(languageKey, local.toString());
    print("exxx: ${local.toString()}");
  }

  String getAppLanguageMain() {
    try {
      Object appLanguage = _prefs!.get(languageKey) ?? "en";
      return appLanguage.toString();
    } catch (e) {
      return "en";
    }
  }

  getUserType() {
    return _prefs!.getString(customrKey);
  }

  setUserType(String customerType) {
    _prefs!.setString(customrKey, customerType);
  }

  setUserLoginState(String state) async {
    try {
      _prefs?.setString(loginKey, state);
    } catch (e) {
      return "not Logined";
    }
  }

  final String _localizationKey = "Localization";

  getUserLoginState() {
    try {
      return SharedPref._prefs!.getString(loginKey);
    } catch (e) {
      printError();
      return "";
    }
  }

  // setBoxesList({required List<BoxModel> boxes}) {
  //   removeBoxess();
  //   _prefs?.setString(boxessKey, jsonEncode(boxes));
  // }

  // List<BoxModel> getBoxesList() {
  //   try {
  //     String? objectStr = _prefs?.getString(boxessKey);
  //     return List<BoxModel>.from(
  //         json.decode(objectStr!).map((x) => BoxModel.fromJson(x)));
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // removeBoxess() async {
  //   try {
  //     await _prefs?.remove(boxessKey);
  //   } catch (e) {
  //     Logger().e(e);
  //   }
  // }

  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }

  setFCMToken(String fcmToken) async {
    try {
      await _prefs?.setString(fcmKey, fcmToken);
    } catch (e) {
      printError();
    }
  }

  String getFCMToken() {
    return _prefs!.getString(fcmKey) ?? "";
  }

  setUserToken(String token) async {
    try {
      if (!GetUtils.isNull(token)) {
        _prefs!.setString(tokenKey, token);
      }
    } catch (e) {
      printError();
    }
  }

  getUserToken() {
    try {
      return _prefs!.getString(tokenKey);
    } catch (e) {
      print(e);
      return "";
    }
  }

  String getPriceWithFormate({required num price}) {
    final numberFormatter = NumberFormat("###.00#", "en_US");
    const num initNumber = 0.00;
    print("getting Price ${numberFormatter.format(initNumber + price)}");
    return numberFormatter.format(initNumber + price) + " ${Constance.qrCoin}";
  }

  // clear() {
  //   removeBoxess();
  // }

  setDeliverdTime({required int deliverdTime}){
    _prefs?.setInt(deliveredDateTime, deliverdTime);
  }

  int getDeliverdTime(){
    return _prefs?.getInt(deliveredDateTime) ?? 0;
  }

  setCurrentTaskId ({required String taskId}){
    _prefs?.setString(taskIdKey, taskId);
  }

  String getCurrentTaskId(){
    return _prefs?.getString(taskIdKey) ?? "";
  }

}
