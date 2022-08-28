// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:inbox_driver/feature/core/dialog_loading.dart';
import 'package:inbox_driver/feature/model/app_setting_modle.dart';
import 'package:inbox_driver/feature/model/payment/payment.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/widget/language_item_widget.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:sms_maintained/sms.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_color.dart';
import 'app_style.dart';
import 'constance.dart';
import 'localization/localization_service.dart';
import 'string.dart';

String? urlPlacholder =
    "https://user-images.githubusercontent.com/194400/49531010-48dad180-f8b1-11e8-8d89-1e61320e1d82.png";
String? urlUserPlacholder =
    "https://jenalk.ahdtech.com/dev/assets/img/no-user.png";

String? urlPlaceholder =
    "https://user-images.githubusercontent.com/194400/49531010-48dad180-f8b1-11e8-8d89-1e61320e1d82.png";
String? urlUserPlaceholder =
    "https://jenalk.ahdtech.com/dev/assets/img/no-user.png";

screenUtil(BuildContext context) {
  ScreenUtil.init(
      Get.context!,
      // BoxConstraints(
      //     maxWidth: MediaQuery.of(context).size.width,
      //     maxHeight: MediaQuery.of(context).size.height),

       deviceSize: const Size(392.72727272727275, 803.6363636363636) ,
       splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(392.72727272727275, 803.6363636363636),
      orientation: Orientation.portrait);
}

var safeAreaLight =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: colorBackground,
  statusBarColor: scaffoldColor,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
));

List<PaymentMethod> getPaymentMethod() {
  List<PaymentMethod> list =
      ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()))
              .paymentMethod ??
          [];

  /// todo:// [wallet and back] => Application
  /// List<PaymentMethod> list = [
  ///   PaymentMethod(id: "Cash", name: "Cash"),
  ///   PaymentMethod(id: "Application", name: "Application"),
  ///   PaymentMethod(id: "Card", name: "Card"),
  /// ];
  return list;
}

var safeAreaDark =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: colorBackground,
  statusBarColor: colorTrans,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.dark,
));

var bottomNavDark =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: colorPrimary,
  statusBarColor: colorPrimary,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.light,
));

// var hideStatusBar =
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
// var hideBottomBar =
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
// var hideAllBar = SystemChrome.setEnabledSystemUIOverlays([]);

void portraitOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

passwordValid(String val) {
  if (val.length < 6) {
    return errorPasswordLength; //key67
  } else {
    return null;
  }
}

emailValid(String val) {
  if (!GetUtils.isEmail(val)) {
    return messageMatcherEmail;
  } else {
    return;
  }
}

phoneVaild(String value) {
  if (value.isEmpty) {
    return txtErrorMobileNumber.tr;
  } else if (value.length > 10 || value.length < 8) {
    return txtErrorMobileNumber.tr;
  }
  return null;
}

phoneVaildAlternativeContact(String value) {
  if (value.length > 10 || value.length < 8) {
    return txtErrorMobileNumber.tr;
  } else {
    return;
  }
}

Widget simplePopup() => PopupMenuButton<int>(
      initialValue: 1,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text("First"),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text("Second"),
        ),
      ],
    );

String getDeviceLang() {
  Locale myLocale = Localizations.localeOf(Get.context!);
  String languageCode = myLocale.languageCode;
  return languageCode;
}

openwhatsapp({required String phoneNumber}) async {
  String whatsapp = phoneNumber;
  String whatsappAndroid = "whatsapp://send?phone=" + whatsapp + "&text=";
  String whatappIos = "https://wa.me/$whatsapp?text=}";

  if (Platform.isIOS) {
    if (await canLaunch(whatappIos)) {
      await launch(whatappIos, forceSafariVC: false);
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("whatsapp is not installed")));
    }
  } else {
    // android , web
    if (await canLaunch(whatsappAndroid)) {
      await launch(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("whatsapp is not installed")));
    }
  }
}

sendSmsOnMyWay({required String phoneNumber}) async {
  String number = phoneNumber;
  String sms = 'sms:$number?body=I\'m%20on%20my%20way';
  if(Platform.isAndroid){
    //FOR Android
    sms ='sms:$number?body=I\'m on myway';
    await launch(sms);
  }
  else if(Platform.isIOS){
    //FOR IOS
    String message = "I\'m on my way";
    List<String> recipents = ["$phoneNumber"];

    String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true)
        .catchError((onError) {
      Logger().e(onError);
    });

  }

}
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

sendSmsArrivedHereOutside({required String phoneNumber}) async {
  String number = phoneNumber;

  if(Platform.isIOS){
    String message = "I arrived here outside";
    List<String> recipents = ["$phoneNumber"];

    String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true)
        .catchError((onError) {
      Logger().e(onError);
    });
  }else{
    String sms =/* Platform.isIOS ? 'sms:${number.replaceAll("+", "00")}?body=I%20arrived%20here%20outside':*/'sms:$number?body=I%20arrived%20here%20outside';
    launch(sms);
  }
}

sendSmsNoShow({required String phoneNumber}) async {
  String number = phoneNumber;
  if(Platform.isIOS){
    String message = "I\'ll report no show within 5 mins";
    List<String> recipents = ["$phoneNumber"];

    String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true)
        .catchError((onError) {
      Logger().e(onError);
    });
  }else {
    String sms =/* Platform.isIOS
        ? 'sms:${number.replaceAll(
        "+", "00")}?body=I\'ll%20report%20"no show"%20within 5 mins'
        :*/ 'sms:$number?body=I\'ll%20report%20"no show"%20within 5 mins';
    launch(sms);
  }
}

sendCustomizeSMS({required String phoneNumber}) async {
  String number = phoneNumber;
  String message = '';

  String sms = Platform.isIOS ? 'sms:${number.replaceAll("+", "00")}':'sms:$number?body=$message';
  launch(sms);
}

Future<void> startPhoneCall({required String phoneNumber}) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launch(launchUri.toString());
}

callNumber({required String phoneNumber}) async {
  try {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber) ?? false;
  } catch (e) {
    Logger().e(e);
  }
}

// Future<void> directSmsSend(
//     {required String phoneNumber, required String msg}) async {
//   try {
//     SmsSender sender = SmsSender();
//     SmsMessage message = SmsMessage(phoneNumber, msg);
//     message.onStateChanged.listen((state) {
//       if (state == SmsMessageState.Sent) {
//         snackSuccess(txtSuccess!.tr, "Sms Sended");
//       } else if (state == SmsMessageState.Delivered) {
//         snackSuccess(txtSuccess!.tr, "Sms Deliverd");
//       }
//     });
//     sender.sendSms(message);
//   } catch (e) {
//     snackError(txtError!.tr, e.toString());
//   }
// }

// snackSuccess(String title, String body) {
//   Future.delayed(const Duration(seconds: 0)).then((value) {
//     Get.snackbar(title, body,
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(8),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: const Color(0xFF10C995));
//   });
// }

// snackError(String title, String body) {
//   Future.delayed(const Duration(seconds: 0)).then((value) {
//     Get.snackbar(title, body,
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(8),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: const Color(0xFFF2AE56).withAlpha(150));
//   });
// }

snackSuccess(String? title, String? body) {
  mainSnack(body: body ?? "", backgroundColor: successColor);
}

snackError(String? title, String? body) {
  mainSnack(body: body ?? "", backgroundColor: errorColor);
}

mainSnack({String? title, required String body, Color? backgroundColor}) {
  Future.delayed(const Duration(seconds: 0)).then((value) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: backgroundColor ?? const Color(0xFF303030),
        message: body,
        duration: const Duration(seconds: 2),
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  });
}

snackConnection() {
  Future.delayed(const Duration(seconds: 0)).then((value) {
    Get.snackbar("$txtConnection", "$txtConnectionNote",
        colorText: Colors.white,
        duration: const Duration(seconds: 7),
        margin: const EdgeInsets.all(8),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF000000).withAlpha(150));
  });
}

showAnimatedDialog(dialog) {
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    context: Get.context!,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: dialog,
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim1),
        child: child,
      );
    },
  );
}

var paymentError = "https://cdn-icons-png.flaticon.com/512/189/189715.png";
var urlProduct =
    "https://images.unsplash.com/photo-1613177794106-be20802b11d3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xvY2slMjBoYW5kc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80";
Widget imageNetwork(
    {double? width,
    double? height,
    String? url,
    BoxFit? fit,
    bool isPayment = false}) {
  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                url ?? (isPayment ? paymentError : urlPlaceholder!)),
            fit: fit ?? BoxFit.contain,
          ),
        ),
      );
    },
    imageUrl: isPayment ? paymentError : urlPlaceholder!,
    errorWidget: (context, url, error) {
      return CachedNetworkImage(
          imageUrl: isPayment ? paymentError : urlPlaceholder!,
          fit: BoxFit.contain);
    },
    width: width ?? 74,
    height: height ?? 74,
    fit: BoxFit.cover,
    placeholder: (context, String? url) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/gif/loading_shimmer.gif") /* CachedNetworkImageProvider(url ?? urlUserPlacholder!)*/,
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
        ),
      );
    },
  );
}
// Future<void> askOnWhatsApp(String? phoneNumber) async {
//   final u =
//       "https://api.whatsapp.com/send?phone=+972${phoneNumber.toString().replaceFirst(RegExp(r'^0+'), "")}&text=";

//   final uri = Uri.encodeFull(u);
//   if (await canLaunch(uri)) {
//     try {
//       await launch(uri);
//     } catch (e) {
//       //Crashlytics.instance.recordError('Manuel Reporting Crash $e', s);
//       snackError(
//           "خطا",
//           'لم نتمكن من فتح الواتساب في جهازك، برجاء التأكد من تنصيبه او ارسل لنا استفسارك علي'
//               '\n'
//               '$phoneNumber'
//               '\n'
//               'مع الرقم المرجعي للمنتج');
//     }
//   } else {
//     final u =
//         "whatsapp://send?phone=+972${phoneNumber.toString().replaceFirst(RegExp(r'^0+'), "")}&text=";

//     final uri = Uri.encodeFull(u);
//     try {
//       await launch(uri);
//     } catch (e) {
//       //Crashlytics.instance.recordError('Manuel Reporting Crash $e', s);
//       snackError(
//           "خطا",
//           'لم نتمكن من فتح الواتساب في جهازك، برجاء التأكد من تنصيبه او ارسل لنا استفسارك علي'
//               '\n'
//               '$phoneNumber'
//               '\n'
//               'مع الرقم المرجعي للمنتج');
//     }
//   }
// }

// Future<void> makePhoneCall(String? phone) async {
//   try {
//     await launch(
//         "tel://+972${phone.toString().replaceFirst(RegExp(r'^0+'), "")}");
//   } catch (e) {
//     print(e);
//   }
// }

// void launchWaze(double lat, double lng) async {
//   var url = 'waze://?ll=${lat.toString()},${lng.toString()}&navigate=yes';
//   var fallbackUrl =
//       'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';
//   try {
//     bool launched =
//         await launch(url, forceSafariVC: false, forceWebView: false);
//     if (!launched) {
//       await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
//     } else {
//       //launchGoogleMaps(lat, lng);
//     }
//   } catch (e) {
//     await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
//     Logger().d(e);
//   }
// }

// launchGoogleMaps(var lat, var lng) async {
//   var url = 'google.navigation:q=${lat.toString()},${lng.toString()}';
//   var fallbackUrl =
//       'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lng.toString()}';
//   try {
//     bool launched =
//         await launch(url, forceSafariVC: false, forceWebView: false);
//     if (!launched) {
//       await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
//     }
//   } catch (e) {
//     await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
//   }
// }

hideFocus(context) {
  FocusScopeNode currentFocus = FocusScope.of(context ?? Get.context!);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    currentFocus.focusedChild!.unfocus();
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

mainShowProgress() {
  showDialog(
    context: Get.context!,
    builder: (context) => const DialogLoading(),
  );
}

hideProgress() async {
  if (await SharedPref.instance.getShowProgress()) {
    Future.delayed(Duration.zero).then((value) => Get.back());
  }
}

mainHideProgress() {
  Get.back();
}

//todo this is second
Future<String>? convertToBase64(File file) async {
  List<int> imageBytes = file.readAsBytesSync();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

//todo this is first
Future<File>? compressImage(File file) async {
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  int rand = math.Random().nextInt(10000);

  img.Image? images = img.decodeImage(file.readAsBytesSync());
  img.Image? smallerImage = img.copyResize(images!,
      width: 500,
      height: 500); // choose the size here, it will maintain aspect ratio

  var compressedImage = File('$path/img_$rand.jpg')
    ..writeAsBytesSync(img.encodeJpg(/*image*/ smallerImage, quality: 85));
  return compressedImage;
}

DateTime convertStringToDate(DateTime? date) {
  Logger().d("date befor ${date.toString()}");
  var stringDate = date.toString();
  Logger().d("date after $stringDate");
  return DateFormat("yyyy-MM-dd T hh:mm a").parse(stringDate);
}

compareToTime(TimeOfDay oneVal, TimeOfDay twoVal) {
  var format = DateFormat("HH:mm a");
  var one = format.parse(oneVal.format(Get.context!));
  var two = format.parse(twoVal.format(Get.context!));
  return one.isBefore(two);
}

double convertStringToDouble(String value) {
  return double.tryParse(value)!.toDouble();
}

double sumStringVal(String? valOne, String? valTwo) {
  return (convertStringToDouble(valOne.toString()) +
      convertStringToDouble(valTwo.toString()));
}

updateLanguage(Locale locale) {
  Get.updateLocale(locale);
}

void changeLanguageBottomSheet() {
  screenUtil(Get.context!);
  Get.bottomSheet(Container(
    // height: sizeH350,
    decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
    padding: EdgeInsets.symmetric(horizontal: sizeH20!),
    child: GetBuilder<AuthViewModle>(
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sizeH42),
            Text(
              txtlanguage.tr,
              style: textStyleTitle(),
            ),
            SizedBox(height: sizeH25),
            Expanded(
              child: ListView.builder(
                itemCount: SharedPref.instance.getAppLanguage()!.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.selectedIndexLang = index;
                        controller.temproreySelectedLang =
                            SharedPref.instance.getAppLanguage()![index].name;
                        controller.update();
                      },
                      child: LanguageItem(
                          selectedIndex: controller.selectedIndexLang,
                          cellIndex: index,
                          name:
                              "${SharedPref.instance.getAppLanguage()![index].languageName}"),
                    ),
                    SizedBox(
                      height: sizeH12,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: sizeH18,
            ),
            PrimaryButton(
                isLoading: false,
                textButton: txtSelect.tr,
                onClicked: () async {
                  try {
                    controller.selectedLang = controller.temproreySelectedLang;
                    if (controller.selectedLang!.toLowerCase().contains("ar")) {
                      LocalizationService().changeLocale(Constance.arabicKey);
                      await SharedPref.instance
                          .setLocalization(Constance.arabicKey);
                    } else if (controller.selectedLang!
                        .toLowerCase()
                        .contains("en")) {
                      LocalizationService().changeLocale(Constance.englishKey);
                      await SharedPref.instance
                          .setLocalization(Constance.englishKey);
                    } else {}

                    Get.back();
                    SplashViewModle().getAppSetting();
                    controller.update();
                  } catch (e) {}
                },
                isExpanded: true),
            SizedBox(
              height: sizeH34,
            )
          ],
        );
      },
    ),
  ));
}

class CustomMaterialPageRoute extends MaterialPageRoute {
  @override
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomMaterialPageRoute({
    @required WidgetBuilder? builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder!,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}

String getPriceWithFormate({required num price}) {
  final numberFormatter = NumberFormat("##0.00#", "en_US");
  const num initNumber = 0.00;
  return numberFormatter.format(initNumber + price) + " ${Constance.qrCoin}";
}

String formatStringWithCurrency(var data, String currency) {
  try {
    var number = data.toString().replaceAll("\$", "").replaceAll(",", "");
    number =
        "${currency.isEmpty ? "QR" : currency} ${NumberFormat("#0.00", "en_US").format(double.parse(number))}";
    //var numbers = "${currency}${double.parse(number).toStringAsFixed(2)}";
    return number.toString();
  } catch (e) {
    return "0.00";
  }
}

bool isArabicLang() {
  return (SharedPref.instance.getLocalization() == "Arabic" ? true : false);
  // return isRTL;
}

class DismissKeyboard extends StatelessWidget {
  final Widget? child;

   const DismissKeyboard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // screenUtil(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
Future<void> askOnWhatsApp(String? phoneNumber) async {
  if(phoneNumber == null || phoneNumber.isEmpty){
    return ;
  }
  final u =
      "https://api.whatsapp.com/send?phone=+972${phoneNumber.toString().replaceFirst(RegExp(r'^0+'), "")}&text=";

  final uri = Uri.encodeFull(u);
  if (await canLaunch(uri)) {
    try {
      await launch(uri);
    } catch (e) {
      //Crashlytics.instance.recordError('Manuel Reporting Crash $e', s);
      snackError(
          "خطا",
          'لم نتمكن من فتح الواتساب في جهازك، برجاء التأكد من تنصيبه او ارسل لنا استفسارك علي'
              '\n'
              '$phoneNumber'
              '\n'
              'مع الرقم المرجعي للمنتج');
    }
  } else {
    final u =
        "whatsapp://send?phone=+972${phoneNumber.toString().replaceFirst(RegExp(r'^0+'), "")}&text=";

    final uri = Uri.encodeFull(u);
    try {
      await launch(uri);
    } catch (e) {
      //Crashlytics.instance.recordError('Manuel Reporting Crash $e', s);
      snackError(
          "خطا",
          'لم نتمكن من فتح الواتساب في جهازك، برجاء التأكد من تنصيبه او ارسل لنا استفسارك علي'
              '\n'
              '$phoneNumber'
              '\n'
              'مع الرقم المرجعي للمنتج');
    }
  }
}

openBrowser(url)async{//openBrowser
  if(url == null ){
    return;
  }
  if (await canLaunch(url)) {
    // await launch(url, /*forceSafariVC: false, forceWebView: false*/);
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      // statusBarBrightness: Brightness.dark,
    );
  }

}