// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as multipart;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_driver/feature/model/country.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/log_in/log_in_screen.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/logout_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/secondery_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
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

//   //-- for log out

  logOutBottomSheet() {
    Get.bottomSheet(GlobalBottomSheet(
      title: txtLogOutChecking.tr,
      
      onOkBtnClick: () async{
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
                snackSuccess(txtSuccess!.tr, "${value.status!.message}"),
                isLoading = false,
                Get.put(AuthViewModle()),
                update(),
                SharedPref.instance
                    .setUserLoginState(ConstanceNetwork.userEnterd),
                Get.offAll(() => const LoginScreen()),
                Get.put(AuthViewModle())
              }
            else
              {
                isLoading = false,
                update(),
                snackError(txtError!.tr, "${value.status!.message}"),
                Get.offAll(() => const LoginScreen()),
                Get.put(AuthViewModle())
              }
          });
    } catch (e) {}
  }

//   //-- for user Edit profile:

  editProfileUser({required String udid}) async {
    isLoading = true;
    update();
    File? myImg;
    hideFocus(Get.context!);
    Map<String, dynamic> myMap = Map<String, dynamic>();
    if (img != null) {
      myImg = await compressImage(img!);
    }

    myMap = {
      "full_name": tdUserFullNameEdit.text,
      "image": myImg != null ? multipart.MultipartFile.fromFileSync(myImg.path) : "",
      "contact_number": jsonEncode(contactMap),
      "email" : tdUserEmailEdit.text,
      "udid" : udid
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
    } catch (e) {}
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


//   // fot timer on change number :
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
