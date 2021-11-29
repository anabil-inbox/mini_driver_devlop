import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/widget/header_code_verfication_widget.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';

class ChangeMobileScreen extends StatelessWidget {
  ChangeMobileScreen({Key? key, required this.mobileNumber}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final String mobileNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderCodeVerfication(),
              SizedBox(height: sizeH25),
              Text(txtChangeMobileNumber.tr),
              SizedBox(height: sizeH10),
              Text(txtWhatIsYourNewPhoneNumber.tr),
              SizedBox(
                height: sizeH22,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeH16!),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.put(AuthViewModle());
                            Get.to(() => const ChooseCountryScreen());
                          },
                          child: Container(
                            height: sizeH60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: colorTextWhite,
                            ),
                            child: GetBuilder<AuthViewModle>(
                              builder: (value) {
                                return Row(
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    SizedBox(
                                      width: sizeW10,
                                    ),
                                    GetBuilder<AuthViewModle>(
                                      init: AuthViewModle(),
                                      initState: (_) {},
                                      builder: (value) {
                                        return Text(
                                          value.defCountry.prefix!.isEmpty
                                              ? "${SharedPref.instance.getCurrentUserData().country?[0].prefix}"
                                              : "${value.defCountry.prefix}",
                                          textDirection: TextDirection.ltr,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: sizeW5,
                                    ),

                                    // GetBuilder<AuthViewModle>(
                                    //   init: AuthViewModle(),
                                    //   initState: (_) {},
                                    //   builder: (value) {
                                    //     var s =
                                    //     print("msg_val ${ConstanceNetwork.imageUrl +
                                    //                 SharedPref.instance
                                    //                     .getCurrentUserData()
                                    //                     .country![0]
                                    //                     .flag!
                                    //                     .trim()} ");
                                    //     return value.defCountry.prefix!.isEmpty
                                    //         ? imageNetwork(
                                    //             url: ConstanceNetwork.imageUrl +
                                    //                 SharedPref.instance
                                    //                     .getCurrentUserData()
                                    //                     .country![0]
                                    //                     .flag!
                                    //                     .trim(),
                                    //             height: sizeH36,
                                    //             width: sizeW26)
                                    //         : imageNetwork(
                                    //             url: value.defCountry.flag,
                                    //             height: sizeH36,
                                    //             width: sizeW26);
                                    //   },
                                    // ),

                                    const VerticalDivider(),
                                    SizedBox(
                                      width: sizeW10,
                                    ),
                                    Expanded(
                                      child: GetBuilder<AuthViewModle>(
                                        builder: (_) {
                                          return TextFormField(
                                            textDirection: TextDirection.ltr,
                                            maxLength: 10,
                                            onSaved: (newValue) {
                                              logic.tdMobileNumber.text =
                                                  newValue.toString();
                                              logic.update();
                                            },
                                            decoration: const InputDecoration(
                                              counterText: "",
                                            ),
                                            controller: logic.tdMobileNumber,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return txtErrorMobileNumber;
                                              } else if (value.length > 10 ||
                                                  value.length < 8) {
                                                return txtErrorMobileNumber;
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeH31,
                        ),
                        GetBuilder<AuthViewModle>(
                          builder: (value) {
                            return PrimaryButton(
                                textButton: txtSave.tr,
                                isLoading: value.isLoading,
                                onClicked: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await logic.reSendVerficationCode(
                                        id: SharedPref.instance
                                            .getCurrentUserData()
                                            .id,
                                        udid: logic.identifier,
                                        target: "sms",
                                        mobileNumber: logic.tdMobileNumber.text,
                                        countryCode: logic.defCountry.prefix,
                                        isFromChange: true);
                                  }
                                },
                                isExpanded: true);
                          },
                        )
                      ],
                    )),
              )
            ],
          );
        },
      ),
    );
  }
}
