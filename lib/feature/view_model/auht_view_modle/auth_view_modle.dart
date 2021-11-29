import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/country.dart';
import 'package:inbox_driver/feature/model/driver_modle.dart';
import 'package:inbox_driver/feature/model/features_modle.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/verification/verfication_screen.dart';
import 'package:inbox_driver/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_driver/network/api/feature/auth_helper.dart';
import 'package:inbox_driver/network/api/feature/country_helper.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

class AuthViewModle extends GetxController {
  var indexdPage = 0;
  var log = Logger();
  List<Feature>? features = [];
  int selectedIndexLang = -1;
  String? selectedLang;
  String? temproreySelectedLang;

  //user text Controllers

  TextEditingController tdSearch = TextEditingController();
  TextEditingController tdMobileNumber = TextEditingController();
  TextEditingController tdName = TextEditingController();
  TextEditingController tdEmail = TextEditingController();
  TextEditingController tdPinCode = TextEditingController();

  //Company text Controllers
  TextEditingController tdcrNumber = TextEditingController();
  TextEditingController tdCompanyName = TextEditingController();
  TextEditingController tdCompanyEmail = TextEditingController();
  TextEditingController tdNameOfApplicant = TextEditingController();
  TextEditingController tdApplicantDepartment = TextEditingController();

  //terms & condistion variable
  bool isAccepte = false;

  //timer For Verfication code
  Timer? timer;
  int startTimerCounter = 60;

  Set<String> arraySectors = {};
  int selectedIndex = -1;

  String? deviceName;
  String? identifier;

  Set<Country> countres = {};
  String? dropDown;
  // for defoult country
  Country defCountry = Country(name: "Qatar", flag: "", prefix: "+974");
  bool isSelectedCountry = false;
  String deviceType = "";
  // for loading var
  bool isLoading = false;

  void changeAcception(bool newValue) {
    isAccepte = newValue;
    update();
  }

  void onChangeDropDownList(String newValue) {
    dropDown = newValue;
    update();
  }

  Future<List<String>> getDeviceDetails() async {
    String? deviceVersion;

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
      update();
    } on PlatformException {
      Logger().e("PlatformException");
    }
    return [deviceName!, deviceVersion!, identifier!];
  }

  Future<Set<Country>> getCountries(int page, int pageSize) async {
    await CountryHelper.getInstance
        .getCountryApi({"page": page, "page_size": pageSize.toString()}).then(
            (value) => {
                  if (!GetUtils.isNull(value))
                    {
                      countres = value,
                      update(),
                    }
                });
    return countres;
  }


  Future<void> signInUser({Driver? user}) async {
    isLoading = true;
    update();
    FocusScope.of(Get.context!).unfocus();
    await AuthHelper.getInstance.loginUser(user!.toJson()).then((value) => {
          if (value.status!.success!)
            {
              Logger().d(value.data["Driver"]),
              isLoading = false,
              Get.put(AuthViewModle()),
              update(),
              snackSuccess(txtSuccess!.tr, "${value.status!.message}"),
              Get.to(() => VerficationScreen(
                    id: value.data["Driver"]["id"],
                    mobileNumber: user.mobileNumber!,
                    countryCode: user.countryCode!,
                  )),
               Get.put(AuthViewModle()),   
            }
          else
            {
              isLoading = false,
              update(),
              snackError(txtError!.tr, "${value.status!.message}")
            }
        });
  }

  checkVerficationCode(
      {String? code,
      String? id,
      String? mobileNumber,
      String? countryCode}) async {
    await AuthHelper.getInstance.checkVerficationCode({
      "id": "$id",
      "udid": "$identifier",
      "code": "$code",
      "mobile_number": "$mobileNumber",
      "country_code": "$countryCode"
    }).then((value) => {
          if (value.status!.success!)
            {
              snackSuccess(txtSuccess!.tr, "${value.status!.message}"),
              Get.offAll(() => const ProfileScreen()),
              Get.put(AuthViewModle())
            }
          else
            {snackError(txtError!.tr, "${value.status!.message}")}
        });
  }

  reSendVerficationCode({
    String? udid,
    String? id,
    String? target,
    String? mobileNumber,
    String? countryCode,
    bool isFromChange = false,
  }) async {
    isLoading = true;
    update();
    await AuthHelper.getInstance.reSendVerficationCode({
      "id": "$id",
      "udid": "$udid",
      "target": "$target",
      ConstanceNetwork.mobileNumberKey: "$mobileNumber",
      "country_code": "$countryCode"
    }).then((value) => {
          if (value.status!.success!)
            {
              isLoading = false,
              startTimerCounter = 60,
              startTimer(),
              update(),
              snackSuccess(txtSuccess!.tr, "${value.status!.message}"),
              isFromChange ? Get.to(() => VerficationScreen(
                id: id ?? "",
                mobileNumber: mobileNumber ?? "",
                countryCode: countryCode ?? "",
              )) : {},
            }
          else
            {snackError(txtError!.tr, "${value.status!.message}")}
        });
  }

  //this for Touch/face (Id) Bottom Sheet :
  // logInWithTouchId() async {
  //   try {
  //     isLoading = true;
  //     update();
  //     await _checkBiometrics();
  //     await _getAvailableBiometrics();
  //     await _authenticate();
  //     if (isAuth! &&
  //         SharedPref.instance
  //             .getCurrentUserData()
  //             .crNumber
  //             .toString()
  //             .isEmpty) {
  //       await signInUser(
  //           user: User(
  //               countryCode:
  //                   "${SharedPref.instance.getCurrentUserData().countryCode}",
  //               mobile: "${SharedPref.instance.getCurrentUserData().mobile}",
  //               udid: "$identifier",
  //               deviceType: "$deviceType",
  //               fcm: "${SharedPref.instance.getFCMToken()}"));
  //     }

  //     isLoading = false;
  //     update();
  //   } catch (e) {
  //     isLoading = false;
  //     update();
  //   }
  // }

  // void showFingerPrinterDiloag() {
  //   Get.bottomSheet(Container(
  //       padding: EdgeInsets.symmetric(horizontal: 16),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(sizeH16!),
  //         color: colorTextWhite,
  //       ),
  //       height: sizeH200,
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: sizeH32,
  //           ),
  //           Text(
  //             "${tr.choose_way_to_sign_in}",
  //             style: textStyleHint()!.copyWith(color: colorBlack),
  //           ),
  //           SizedBox(
  //             height: sizeH16,
  //           ),
  //           GetBuilder<AuthViewModle>(
  //             init: AuthViewModle(),
  //             initState: (_) {},
  //             builder: (_) {
  //               return PrimaryButton(
  //                   isExpanded: true,
  //                   isLoading: isLoading,
  //                   textButton:
  //                       "${tr.touch_id}",
  //                   onClicked: isLoading
  //                       ? () {}
  //                       : () async {
  //                           isLoading = true;
  //                           update();
  //                           await _checkBiometrics();
  //                           await _getAvailableBiometrics();
  //                           await _authenticate();
  //                           if (isAuth!) {
  //                             await signInUser(
  //                                 user: User(
  //                                     countryCode:
  //                                         "${SharedPref.instance.getCurrentUserData().countryCode}",
  //                                     mobile:
  //                                         "${SharedPref.instance.getCurrentUserData().mobile}",
  //                                     udid: "$identifier",
  //                                     deviceType: "$deviceType",
  //                                     fcm:
  //                                         "${SharedPref.instance.getFCMToken()}"));
  //                           }
  //                           isLoading = false;
  //                           update();
  //                         });
  //             },
  //           ),
  //           SizedBox(
  //             height: sizeH16,
  //           ),
  //           GetBuilder<AuthViewModle>(
  //             builder: (_) {
  //               return PrimaryButton(
  //                   isExpanded: true,
  //                   isLoading: isLoading,
  //                   textButton: "${tr.face_id}",
  //                   onClicked: () async {
  //                     isLoading = true;
  //                     // update();
  //                     // await _checkBiometrics();
  //                     // await _getAvailableBiometrics();
  //                     // await _authenticate();
  //                     // if (isAuth!) {
  //                     //   await signInUser(
  //                     //       user: User(
  //                     //           countryCode:
  //                     //               "${SharedPref.instance.getCurrentUserData().countryCode}",
  //                     //           mobile:
  //                     //               "${SharedPref.instance.getCurrentUserData().mobile}",
  //                     //           udid: "$identifier",
  //                     //           deviceType: "$deviceType",
  //                     //           fcm: "${SharedPref.instance.getFCMToken()}"));
  //                     // }
  //                     // isLoading = false;
  //                     // update();
  //                       Get.to(()=> FacePage());
  //                   });
  //             },
  //           )
  //         ],
  //       )));
  // }
  //this for Touch/face (Id) Bottom Sheet :

  logInWithTouchId() async {
    try {
      isLoading = true;
      update();
      await _checkBiometrics();
      await _getAvailableBiometrics();
      await _authenticate();
      if (isAuth! &&
          SharedPref.instance.getCurrentUserData().id.toString().isNotEmpty) {
        await signInUser(
            user: Driver(
                countryCode:
                    "${SharedPref.instance.getCurrentUserData().countryCode}",
                mobileNumber:
                    "${SharedPref.instance.getCurrentUserData().mobileNumber}",
                udId: identifier,
                deviceType: deviceType));
      }
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  bool? isAuth = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    _canCheckBiometrics = canCheckBiometrics;
    update();
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = <BiometricType>[];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    _availableBiometrics = availableBiometrics;
    update();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        biometricOnly: true,
        stickyAuth: false,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    isAuth = authenticated ? true : false;
    update();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startTimerCounter == 0) {
          timer.cancel();
          update();
        } else {
          startTimerCounter--;
          update();
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getDeviceDetails();
    update();
  }
}
