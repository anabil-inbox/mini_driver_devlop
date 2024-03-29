// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as multipart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_driver/feature/model/country.dart';
import 'package:inbox_driver/feature/model/profile/driver_report_data.dart';
import 'package:inbox_driver/feature/model/profile/log_model.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/log_in/log_in_screen.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/logout_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/secondery_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/network/api/feature/home_helper.dart';
import 'package:inbox_driver/network/api/feature/cash_helper.dart';
import 'package:inbox_driver/network/api/feature/profie_helper.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/base_controller.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:logger/logger.dart';

import '../../model/profile/cash_closer_data.dart';

class ProfileViewModle extends BaseController {
  TextEditingController tdUserFullNameEdit = TextEditingController();
  TextEditingController tdUserEmailEdit = TextEditingController();
  TextEditingController tdUserMobileNumberEdit = TextEditingController();
  Country defCountry =
      Country(prefix: SharedPref.instance.getCurrentUserData()?.countryCode);
  final picker = ImagePicker();
  File? img;
  List<Map<String, dynamic>> contactMap = [];

  bool isLoading = false;
  DriverReportData? driverReportData;
  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  List<Log> userLogs = [];
  List<CashCloserData> listCashCloser = [];
  num totalAmount = 0;
  num padAmount = 0;
  num remainingAmount = 0;

//   //-- for log out

  logOutBottomSheet() {
    Get.bottomSheet(GlobalBottomSheet(
      title: txtLogOutChecking.tr,
      onOkBtnClick: () {
        logOut();
        Get.back();
      },
      onCancelBtnClick: () {
        Get.back();
      },
    ));
  }

  logOut() async {
    isLoading = true;
    update();
    try {
      await ProfileHelper.getInstance.logOut().then((value) => {
            Logger().i("${value.status!.message}"),
            if (value.status!.success!)
              {
                // snackSuccess(txtSuccess!.tr, "${value.status!.message}"),

                isLoading = false,
                Get.put(AuthViewModle()),
                update(),
                SharedPref.instance
                    .setUserLoginState(ConstanceNetwork.userEnterd),
                Get.offAll(() => const LoginScreen()),
                Get.put(AuthViewModle()),
                Get.find<HomeViewModel>().tasksDone.clear(),
                Get.find<HomeViewModel>().tasksInProgress.clear(),
              }
            else
              {
                isLoading = false,
                update(),
                snackError(txtError!.tr, "${value.status!.message}"),
                SharedPref.instance
                    .setUserLoginState(ConstanceNetwork.userEnterd),
                Get.offAll(() => const LoginScreen()),
                Get.put(AuthViewModle()),
                Get.find<HomeViewModel>().tasksDone.clear(),
                Get.find<HomeViewModel>().tasksInProgress.clear(),
              }
          });
    } catch (e) {
      printError();
    }
  }


  deleteAccountBottomSheet() {
    Get.bottomSheet(GlobalBottomSheet(
      title: txtDeleteYouAccount.tr,
      onOkBtnClick: () {
        deleteAccount();
        Get.back();
      },
      onCancelBtnClick: () {
        Get.back();
      },
    ));
  }
  deleteAccount() async {
    isLoading = true;
    update();
    try {
      await ProfileHelper.getInstance.deleteAccount().then((value) => {
            Logger().i("${value.status!.message}"),
            if (value.status!.success!)
              {
                // snackSuccess(txtSuccess!.tr, "${value.status!.message}"),

                isLoading = false,
                Get.put(AuthViewModle()),
                update(),
                SharedPref.instance
                    .setUserLoginState(ConstanceNetwork.userEnterd),
                Get.offAll(() => const LoginScreen()),
                Get.put(AuthViewModle()),
                Get.find<HomeViewModel>().tasksDone.clear(),
                Get.find<HomeViewModel>().tasksInProgress.clear(),
              }
            else
              {
                isLoading = false,
                update(),
                snackError(txtError!.tr, "${value.status!.message}"),
                Get.offAll(() => const LoginScreen()),
                Get.put(AuthViewModle()),
                Get.find<HomeViewModel>().tasksDone.clear(),
                Get.find<HomeViewModel>().tasksInProgress.clear(),
              }
          });
    } catch (e) {
      printError();
    }
  }

//   //-- for user Edit profile:

  editProfileUser({required String udid}) async {
    isLoading = true;
    update();
    File? myImg;
    hideFocus(Get.context!);
    Map<String, dynamic> myMap = {};
    if (img != null) {
      myImg = await compressImage(img!);
    }

    myMap = {
      "full_name": tdUserFullNameEdit.text,
      "image":
          myImg != null ? multipart.MultipartFile.fromFileSync(myImg.path) : "",
      "contact_number": jsonEncode(contactMap),
      "email": tdUserEmailEdit.text,
      "udid": udid
    };

    try {
      await ProfileHelper.getInstance.editProfile(myMap).then((value) => {
            if (value.status!.success!)
              {
                snackSuccess(txtSuccess!.tr, "${value.status!.message}"),
                isLoading = false,
                update(),
                Get.back()
              }
            else
              {
                isLoading = false,
                update(),
                snackError(txtError!.tr, "${value.status!.message}")
              }
          });
    } catch (e) {
      printError();
    }
  }

  void getImageBottomSheet() {
    Get.bottomSheet(Container(
      height: sizeH240,
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Column(
        children: [
          SizedBox(
            height: sizeH20,
          ),
          Container(
            height: sizeH5,
            width: sizeH50,
            decoration: BoxDecoration(
                color: colorUnSelectedWidget,
                borderRadius: BorderRadius.circular(2.5)),
          ),
          SizedBox(
            height: sizeH20,
          ),
          Text(
            txtSelectImage.tr,
            style: textStyleAppBarTitle(),
          ),
          SizedBox(
            height: sizeH25,
          ),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: txtCamera.tr,
            onClicked: () async {
              await getImage(ImageSource.camera);
              Get.back();
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: txtGallery.tr,
            onClicked: () async {
              await getImage(ImageSource.gallery);
              Get.back();
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    ));
  }

  Future getImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      img = File(pickedImage.path);
      update();
    }
  }

  Future<void> getUserLog() async {
    startLoading();
    try {
      await HomeHelper.getInstance.getLog().then((value) => {
            userLogs = value,
            Logger().e(value),
          });
    } catch (e) {
      Logger().e(e.toString());
    }
    stopLoading();
  }

  Future<void> getCashCloser() async {
    try {
      isLoading = true;
      update();
      totalAmount = 0;
      padAmount = 0;
      remainingAmount = 0;
      await CashCloserFeature.getInstance.getCashCloser().then((value) {
        Logger().d(value.length);
        if (value.isNotEmpty) {
          listCashCloser.clear();
          listCashCloser = value;
          isLoading = false;
          totalAmountCalc();
          padAmountCalc();
          remainingAmountCalc();
          update();
        } else {
          isLoading = false;
          update();
        }
      });
    } catch (e) {
      Logger().e(e);
      isLoading = false;
      update();
    }
  }

  Future<void> applyCashCloser(var id) async {
    try {
      isLoading = true;
      update();
      await CashCloserFeature.getInstance.applyCashCloser(
          {ConstanceNetwork.idKey: id.toString()}).then((value) {
        if (value.status!.success!) {
          getCashCloser();
          Get.back();
          isLoading = false;
          update();
        } else {
          isLoading = false;
          update();
        }
      });
    } catch (e) {
      Logger().e(e);
      isLoading = false;
      update();
    }
  }

  void totalAmountCalc() {
    for (var item in listCashCloser) {
      totalAmount = totalAmount + item.amount!;
    }
    update();
  }

  void padAmountCalc() {
    for (var item in listCashCloser) {
      if (item.status != 0) {
        padAmount = padAmount + item.amount!;
      }
    }
    update();
  }

  void remainingAmountCalc() {
    for (var item in listCashCloser) {
      if (item.status == 0) {
        remainingAmount = remainingAmount + item.amount!;
      }
    }
    update();
  }

  Future<void> getDriverReport() async {
    try {
      isLoading = true;
      update();
      await ProfileHelper.getInstance.getDriverReport().then((value) {
        driverReportData = DriverReportData();
        driverReportData =value;
        Logger().d(driverReportData?.toJson());
        isLoading = false;
        update();
      });
    } catch (e) {
      print(e);
      isLoading = false;
      update();
    }
  }

  void sendNote(TextEditingController emailController,
      TextEditingController noteController) {
    if (emailController.text.isEmpty) {
      return;
    }
    if (noteController.text.isEmpty) {
      return;
    }
    Map<String, dynamic> map = {
      ConstanceNetwork.emailKey: emailController.text.toString(),
      ConstanceNetwork.notesKey: noteController.text.toString(),
    };
    _sendNote(map, emailController, noteController);
  }

  Future<void> _sendNote(
      Map<String, dynamic> map,
      TextEditingController emailController,
      TextEditingController noteController) async {
    startLoading();
    await ProfileHelper.getInstance.sendNote(map).then((value) {
      if (value.status!.success!) {
        emailController.clear();
        noteController.clear();
        snackSuccess("", value.status?.message.toString());
      } else {
        snackError("", value.status?.message.toString());
      }
      isLoading = false;
      update();
    }).catchError((value) {
      isLoading = false;
      update();
      Logger().d(value);
    });
  }//   // fot timer on change number :
//   Timer? timer;
//   int startTimerCounter = 60;

//   void startTimer() {
//     const oneSec = const Duration(seconds: 1);
//     timer = new Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (startTimerCounter == 0) {
//           timer.cancel();
//           update();
//         } else {
//           startTimerCounter--;
//           update();
//         }
//       },
//     );
//   }

}
