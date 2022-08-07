import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:get/utils.dart';
import 'package:inbox_driver/feature/model/driver_modle.dart';
import 'package:inbox_driver/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/widget/primary_button_finger_pinter.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';

class LoginForm extends GetWidget<AuthViewModle> {
  const LoginForm({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GetBuilder<AuthViewModle>(
              init: AuthViewModle(),
              initState: (_) {},
              builder: (_) {
                return Container(
                  color: colorTextWhite,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const ChooseCountryScreen());
                    },
                    child: Row(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: sizeW18,
                        ),
                        controller.defCountry.name!
                                    .toLowerCase()
                                    .contains("qatar") ||
                                controller.defCountry.name!.isEmpty
                            ? SvgPicture.asset("assets/svgs/qatar_flag.svg")
                            : imageNetwork(
                                url:
                                    "${ConstanceNetwork.imageUrl}${controller.defCountry.flag}",
                                width: 36,
                                height: 26),
                        const VerticalDivider(),
                        GetBuilder<AuthViewModle>(
                          init: AuthViewModle(),
                          initState: (_) {},
                          builder: (value) {
                            return Text(
                              value.defCountry.prefix ?? "+974",
                              textDirection: TextDirection.ltr,
                            );
                          },
                        ),
                        Expanded(
                          child: TextFormField(
                            textDirection: TextDirection.ltr,
                            maxLength: 10,
                            decoration: const InputDecoration(counterText: ""),
                            onSaved: (newValue) {
                              controller.tdMobileNumber.text =
                                  newValue.toString();
                              controller.update();
                            },
                            controller: controller.tdMobileNumber,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return txtErrorMobileNumber.tr;
                              } else if (value.length > 10 || value.length < 8) {
                                return txtErrorMobileNumber.tr;
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: sizeH28),
            (SharedPref.instance .getUserToken() != null && !GetUtils.isNull(SharedPref.instance.getCurrentUserData()?.id) &&"${SharedPref.instance.getCurrentUserData()?.id.toString()}".isNotEmpty )
                ? Row(
                    children: [
                      GetBuilder<AuthViewModle>(
                        init: AuthViewModle(),
                        builder: (logic) {
                          return PrimaryButtonFingerPinter(
                            isExpanded: false,
                            textButton: txtContinue.tr,
                            isLoading: controller.isLoading,
                            onClicked: () {
                              if (_formKey.currentState!.validate()) {
                                logic.signInUser(
                                    user: Driver(
                                  countryCode:
                                      "${controller.defCountry.prefix}",
                                  mobileNumber: controller.tdMobileNumber.text,
                                  udId: controller.identifier,
                                  deviceType: controller.deviceType,
                                  fcm: SharedPref.instance.getFCMToken(),
                                ));
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(width: sizeW10),
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            controller.logInWithTouchId();
                          },
                          icon:
                              SvgPicture.asset("assets/svgs/finger_pinter.svg"))
                    ],
                  )
                : GetBuilder<AuthViewModle>(
                    init: AuthViewModle(),
                    initState: (_) {},
                    builder: (logic) {
                      return PrimaryButtonFingerPinter(
                        isExpanded: true,
                        onClicked: () {
                          if (_formKey.currentState!.validate()) {
                            logic.signInUser(
                                    user: Driver(
                                  countryCode: "${controller.defCountry.prefix}",
                                  mobileNumber: controller.tdMobileNumber.text,
                                  udId: controller.identifier,
                                  deviceType: controller.deviceType,
                                  fcm: SharedPref.instance.getFCMToken(),
                                ));
                            
                          }
                        },
                        isLoading: controller.isLoading,
                        textButton: txtContinue.tr,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
