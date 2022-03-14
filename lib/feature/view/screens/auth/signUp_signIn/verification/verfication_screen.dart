import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/widget/header_code_verfication_widget.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerficationScreen extends StatefulWidget {
  final String mobileNumber;
  final String countryCode;
  final String id;

  const VerficationScreen({Key? key,
    required this.mobileNumber,
    required this.countryCode,
    required this.id})
      : super(key: key);

  @override
  State<VerficationScreen> createState() => _ChangeMobilScreenState();
}

class _ChangeMobilScreenState extends State<VerficationScreen> {
  AuthViewModle authViewModle = Get.find<AuthViewModle>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (authViewModle.timer?.isActive ?? false) {
        authViewModle.timer?.cancel();
        authViewModle.startTimerCounter = 60;
        authViewModle.startTimer();
        authViewModle.update();
      } else {
        authViewModle.startTimerCounter = 60;
        authViewModle.startTimer();
      }
    });
  }

  String _commingSms = 'Unknown';

  Future<void> initSmsListener() async {
    String? commingSms;
    try {
      commingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      commingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;

    // setState(() {
    //   _commingSms = commingSms!;
    // });
    Logger().d("sms_$commingSms");
    if (commingSms != null && commingSms.length > 33) {
      authViewModle.tdPinCode.text = commingSms.substring(33);
      authViewModle.update();
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AltSmsAutofill().unregisterListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScaffoldRegistrationBody,
        body: GetBuilder<AuthViewModle>(builder: (logic) {
          return ListView(padding: const EdgeInsets.all(0), children: [
            const HeaderCodeVerfication(),
            Column(
              children: [
                SizedBox(
                  height: sizeH16,
                ),
                Text(
                  txtEnterYourPasscode.tr,
                  style: textStyleHints(),
                ),
                SizedBox(
                  height: sizeH30!,
                ),
                bildeTextActiveCode(context),
                SizedBox(
                  height: sizeH190,
                ),
                GetBuilder<AuthViewModle>(
                  builder: (value) {
                    return Column(
                      children: [
                        value.startTimerCounter != 0
                            ? Text(
                          "${txtResendCodeIn.tr} : ${value.startTimerCounter}",
                          style: textStyleHint()!.copyWith(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontSize: fontSize14),
                        )
                            : const SizedBox(),
                        value.startTimerCounter == 0
                            ? InkWell(
                            splashColor: colorTrans,
                            highlightColor: colorTrans,
                            onTap: () {
                              value.reSendVerficationCode(
                                  countryCode: widget.countryCode,
                                  target: "sms",
                                  mobileNumber: widget.mobileNumber,
                                  udid: value.identifier,
                                  id: widget.id
                              );
                              value.startTimerCounter = 60;
                              value.startTimer();
                              value.update();
                            },
                            child: Text(
                              txtResned.tr,
                              style: textStyleUnderLinePrimary()!.copyWith(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: fontSize14),
                            ))
                            : const SizedBox()
                      ],
                    );
                  },
                )
              ],
            ),
          ]);
        }));
  }

  Widget bildeTextActiveCode(BuildContext context,) {
    return GetBuilder<AuthViewModle>(builder: (logic) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeW80!),
        child: PinCodeTextField(
          autoFocus: true,
          hintCharacter: "__",
          hintStyle: textStyleTitle(),
          length: 4,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            fieldHeight: 50,
            fieldWidth: 50,
            disabledColor: const Color(0xFFCECECE),
            selectedFillColor: colorTextWhite,
            activeFillColor: colorTextWhite,
            inactiveFillColor: colorTextWhite,
            inactiveColor: const Color(0xFFCECECE),
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: colorScaffoldRegistrationBody,
          enableActiveFill: true,
          keyboardType: TextInputType.number,
          onCompleted: (v) {
            authViewModle.checkVerficationCode(
                code: v,
                id: widget.id,
                mobileNumber: widget.mobileNumber,
                countryCode: widget.countryCode
            );
          },
          onChanged: (value) {},
          /*validator: (value) {
          if(value.isEmpty) {
            return kPleaseActiveCode.tr;
          }else if(value.length!=4) {
           // return kPleaseActiveCode.tr;
          }else{
            return null;
          }
        },*/
          beforeTextPaste: (text) {
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
          appContext: context,
        ),
      );
    });
  }
}
