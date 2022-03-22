import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:inbox_driver/feature/view/screens/profile/edit_profile/change_mobile/change_mobile_screen.dart';
import 'package:inbox_driver/feature/view/screens/profile/edit_profile/user_edit_profile_screen.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';

import '../../../../../util/app_shaerd_data.dart';

class HeaderProfileCard extends StatelessWidget {
  const HeaderProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
        color: scaffoldColor,
      ),
      child: Column(
        children: [
          SizedBox(
            height: sizeH20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: sizeH16,
              ),
              GetBuilder<ProfileViewModle>(
                init: ProfileViewModle(),
                initState: (_) {},
                builder: (_) {
                  return GetUtils.isNull(
                              SharedPref.instance.getCurrentUserData()?.image) ||
                          "${SharedPref.instance.getCurrentUserData()?.image.toString()}".isEmpty
                      ? CircleAvatar(
                          backgroundColor: colorPrimary,
                          radius: 35,
                        )
                      : CircleAvatar(
                          backgroundColor: colorPrimary,
                          backgroundImage: NetworkImage(
                              "${SharedPref.instance.getCurrentUserData()?.image}"),
                          radius: 35,
                        );
                },
              ),
              SizedBox(
                width: sizeH10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<ProfileViewModle>(
                    init: ProfileViewModle(),
                    initState: (_) {},
                    builder: (_) {
                      return Text(
                          "${SharedPref.instance.getCurrentUserData()?.driverName}");
                    },
                  ),
                 //  const Text("Ahmed Ali Abdullah"),
                  SizedBox(
                    height: sizeH4,
                  ),
                  Row(
                    children: [
                      GetBuilder<ProfileViewModle>(
                        init: ProfileViewModle(),
                        initState: (_) {},
                        builder: (_) {
                          return Text(
                              "${SharedPref.instance.getCurrentUserData()?.countryCode} ${SharedPref.instance.getCurrentUserData()?.mobileNumber}",
                          //    "+974 2228 0808",
                              style: textStyleHint()!
                                  .copyWith(fontWeight: FontWeight.normal),
                              textDirection: TextDirection.ltr);
                        },
                      ),
                      SizedBox(
                        width: sizeH9,
                      ),
                        InkWell(
                            onTap: () {
                              Get.to(() => ChangeMobileScreen(
                                    mobileNumber:
                                        "${SharedPref.instance.getCurrentUserData()?.countryCode} ${SharedPref.instance.getCurrentUserData()?.mobileNumber}",
                                  ));
                            },
                            child: SvgPicture.asset("assets/svgs/edit_pen.svg"))
                      
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: sizeH16,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: sizeH20!),
              child: PrimaryButtonOpacityColor(
                  textButton: txtEditProfile.tr,
                  isLoading: false,
                  onClicked: () {
                      Get.put(AuthViewModle());
                      Get.put(ProfileViewModle());
                     Get.to(() => const EditProfileScreen());
                  },
                  isExpanded: true)),
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    );
  }
}
