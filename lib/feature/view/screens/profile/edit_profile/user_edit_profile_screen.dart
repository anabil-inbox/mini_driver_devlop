import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/auth/country/choose_country_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';

import 'contact_item_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();

  @override
  State<EditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<EditProfileScreen> {
  ProfileViewModle profileViewModle = Get.put(ProfileViewModle());
  AuthViewModle authViewModle = Get.put(AuthViewModle());

  @override
  void initState() {
    super.initState();

    profileViewModle.tdUserFullNameEdit.text =
        SharedPref.instance.getCurrentUserData().driverName ?? "";
    profileViewModle.tdUserEmailEdit.text =
        SharedPref.instance.getCurrentUserData().email ?? "";
    profileViewModle.contactMap.clear();
    profileViewModle.contactMap =
        SharedPref.instance.getCurrentUserData().contactNumber ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          txtEditProfile.tr,
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()
              ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: sizeH20!),
                child: Form(
                  key: EditProfileScreen._formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: sizeH25,
                      ),
                      Stack(
                        children: [
                          GetBuilder<ProfileViewModle>(
                            builder: (_) {
                              return InkWell(
                                  splashColor: colorTrans,
                                  highlightColor: colorTrans,
                                  onTap: () async {
                                    profileViewModle.getImageBottomSheet();
                                  },
                                  child: profileViewModle.img != null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundImage: Image.file(
                                            profileViewModle.img!,
                                            fit: BoxFit.cover,
                                          ).image,
                                          backgroundColor:
                                              colorPrimary.withOpacity(0.5),
                                        )
                                      : GetUtils.isNull(SharedPref.instance
                                                  .getCurrentUserData()
                                                  .image) ||
                                              SharedPref.instance
                                                  .getCurrentUserData()
                                                  .image
                                                  .toString()
                                                  .isEmpty
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  colorPrimary.withOpacity(0.5),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  "${SharedPref.instance.getCurrentUserData().image}"),
                                            ));
                            },
                          ),
                          PositionedDirectional(
                            end: 0,
                            child:
                                SvgPicture.asset("assets/svgs/update_red.svg"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: sizeH25,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: profileViewModle.tdUserFullNameEdit,
                        onSaved: (e) {
                          profileViewModle.tdUserFullNameEdit.text = e!;
                          profileViewModle.update();
                        },
                        decoration: InputDecoration(hintText: txtFullName.tr),
                        validator: (e) {
                          if (e.toString().trim().isEmpty) {
                            return txtErrorFillYourName.tr;
                          } else if (e!.length < 2) {
                            return txtErrorFillYourName.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: sizeH16,
                      ),
                      TextFormField(
                        controller: profileViewModle.tdUserEmailEdit,
                        onSaved: (e) {
                          profileViewModle.tdUserEmailEdit.text = e!;
                          profileViewModle.update();
                        },
                        decoration: InputDecoration(hintText: txtEmail!.tr),
                        validator: (e) {
                          if (e!.isEmpty) {
                            return txtErrorFillYourEmail.tr;
                          } else if (!GetUtils.isEmail(e)) {
                            return txtErrorFillYourEmail.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: sizeH16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Text(
                            txtAlternativeContact.tr,
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                        height: sizeH10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(() => const ChooseCountryScreen());
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                height: sizeH54,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: colorTextWhite,
                                ),
                                child: Row(
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    SizedBox(
                                      width: sizeW18,
                                    ),
                                    GetBuilder<AuthViewModle>(
                                      init: AuthViewModle(),
                                      initState: (_) {},
                                      builder: (value) {
                                        return Row(
                                          children: [
                                            Text(
                                              "${value.defCountry.prefix}",
                                              textDirection: TextDirection.ltr,
                                            ),
                                            const VerticalDivider(),
                                            SizedBox(
                                              width: sizeH5!,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        enabled: true,
                                        textDirection: TextDirection.ltr,
                                        maxLength: 10,
                                        onSaved: (newValue) {
                                          profileViewModle
                                              .tdUserMobileNumberEdit
                                              .text = newValue.toString();
                                          profileViewModle.update();
                                        },
                                        decoration: const InputDecoration(
                                          counterText: "",
                                        ),
                                        validator: (e) =>
                                            phoneVaild(e.toString()),
                                        controller: profileViewModle
                                            .tdUserMobileNumberEdit,
                                        keyboardType: TextInputType.number,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: sizeW4,
                          ),
                          GetBuilder<AuthViewModle>(
                            init: AuthViewModle(),
                            initState: (_) {},
                            builder: (logic) {
                              return InkWell(
                                onTap: () {
                                  addNewContact("${logic.defCountry.prefix}");
                                },
                                child: SvgPicture.asset(
                                  "assets/svgs/add.svg",
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: sizeH20,
                      ),
                      GetBuilder<ProfileViewModle>(builder: (logic) {
                        return ListView(
                            shrinkWrap: true,
                            primary: false,
                            children: logic.contactMap
                                .asMap()
                                .map((index, value) => MapEntry(
                                    index,
                                    ContactItemWidget(
                                        deleteContact: () {
                                          logic.contactMap
                                              .removeWhere((element) {
                                            return element == value;
                                          });

                                          logic.update();
                                        },
                                        mobileNumber: logic.contactMap[index]
                                            [ConstanceNetwork.mobileNumberKey],
                                        onChange: (_) {
                                          logic.contactMap[index][
                                              ConstanceNetwork
                                                  .mobileNumberKey] = _;
                                          logic.update();
                                        },
                                        prefix: logic.contactMap[index]
                                            [ConstanceNetwork.countryCodeKey])))
                                .values
                                .toList());
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeH20!),
            child: GetBuilder<ProfileViewModle>(
              builder: (value) {
                return PrimaryButton(
                    textButton: txtSave.tr,
                    isLoading: value.isLoading,
                    onClicked: () {
                      if (EditProfileScreen._formKey.currentState!.validate()) {
                        value.editProfileUser();
                      }
                    },
                    isExpanded: true);
              },
            ),
          ),
          SizedBox(
            height: sizeH31,
          ),
        ],
      ),
    );
  }

  addNewContact(String countryCode) {
    if (profileViewModle.tdUserMobileNumberEdit.text.isEmpty) {
      return;
    }
    if (EditProfileScreen._formKey.currentState!.validate()) {
      Map<String, String> map = {
        ConstanceNetwork.countryCodeKey: countryCode,
        ConstanceNetwork.mobileNumberKey:
            profileViewModle.tdUserMobileNumberEdit.text,
      };
      profileViewModle.contactMap.add(map);
      profileViewModle.tdUserMobileNumberEdit.clear();
      profileViewModle.update();
    }
  }
}
