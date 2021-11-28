import 'dart:convert';

import 'package:get/utils.dart';
import 'package:inbox_driver/feature/model/app_setting_modle.dart';
import 'package:inbox_driver/feature/model/driver_modle.dart';
import 'package:inbox_driver/feature/model/language.dart';
import 'package:inbox_driver/util/constance.dart';
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
  final String tokenKey = "token";
  final String customrKey = "customerKey";
  final String userDataKey = "userData";

  var log = Logger();

  SharedPref._();

  static late SharedPreferences? _prefs;

  setAppSetting(var json) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String prfApiSettings = jsonEncode(json);
    pref.setString('$appSettingKey', prfApiSettings);
  }

  // setCurrentUserDate(Map<String,dynamic> customer) async {
  //   try {
  //     Map<String,dynamic> json = jsonDecode(customer.toString());
  //     String user = jsonEncode(Customer.fromJson(json));
  //     print("saved_Succeffully ${_prefs?.setString("$userDataKey","$user")}");
  //   } catch (e) {
  //     print("error $e");
  //   }
  // }

  // getCurrentUserData() {
//       print("msg_get_Current_user_data ${_prefs?.getString('$userDataKey')}");
//       try{
//         Customer currentUserObject = jsonDecode(_prefs!.getString('$userDataKey')!);
//       return currentUserObject;
//       }catch(e){
//         print(e);
//         return;
//       }
//   }
  setLocalization(String lang) {
    _prefs?.setString(_localizationKey, lang);
  }

  String getLocalization() {
    try {
      return _prefs?.getString(_localizationKey) ?? "${Constance.arabicKey}";
    } catch (e) {
      print(e);
      return "${Constance.arabicKey}";
    }
  }

  setCurrentUserData(String profileData) async {
    try {
      print("msg_profile_data_to_save $profileData");
      bool? isSaved =
          await _prefs?.setString("$userDataKey", profileData.toString());
      print(isSaved);
    } catch (e) {
      Logger().e(e);
      return "$e";
    }
  }

  Driver getCurrentUserData() {
    try {
      var string = _prefs?.getString("$userDataKey");
      var decode;
      if (GetUtils.isNull(json.decode(string!)["data"]["Driver"])) {
        print("get Current user if");
        decode = json.decode(string)["data"];
      }else{
       decode = json.decode(string)["data"]["Driver"];
      }
      Driver profileData = Driver.fromJson(decode);
      return profileData;
    } catch (e) {
      Logger().e(e);
      return Driver();
    }
  }

  getAppSetting() {
    try {
      Object appSetting = _prefs!.get("$appSettingKey")!;
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
          .languges;
    } catch (e) {
      // ignore: avoid_print
      print("e");
    }
  }

  isShowProgress(bool? isShow) {
    // ignore: unnecessary_statements
    isShow == null ? isShow = false : isShow;
    _prefs?.setBool("$isShowKey", isShow);
  }

  getShowProgress() {
    try {
      return _prefs?.getBool("$isShowKey") ?? false;
    } catch (e) {
      print(e);
    }
  }

  setAppLanguage(var local) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(languageKey, local.toString());
    print("exxx:${local.toString()}");

  }

  String getAppLanguageMain() {
    try {
      Object appLanguage = _prefs!.get(languageKey)!;
      return appLanguage.toString();
    } catch (e) {
      return "en";
    }
  }

  getUserType() {
    return _prefs!.getString("$customrKey");
  }

  setUserType(String customerType) {
    _prefs!.setString("$customrKey", customerType);
  }

  setUserLoginState(String state) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('$loginKey', '$state');
    } catch (e) {
      return "not Logined";
    }
  }
  final String _localizationKey = "Localization";

  getUserLoginState() {
    try {
      return SharedPref._prefs!.getString('$loginKey');
    } catch (e) {
      print(e);
      return "";
    }
  }

  init() async {
    _prefs = await SharedPreferences?.getInstance();
  }

  setFCMToken(String fcmToken) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("$fcmKey", fcmToken);
    } catch (e) {}
  }

  String getFCMToken() {
    return _prefs!.getString("$fcmKey") ?? "";
  }

  setUserToken(String token) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (!GetUtils.isNull(token)) {
        pref.setString("$tokenKey", token);
      }
    } catch (e) {}
  }

  getUserToken() {
    try {
      return SharedPref._prefs!.getString('$tokenKey');
    } catch (e) {
      print(e);
      return "";
    }
  }
}
