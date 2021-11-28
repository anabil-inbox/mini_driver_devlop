import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/view/screens/profile/setting/setting_screen.dart';
import 'package:inbox_driver/feature/view/screens/profile/widget/setting_item.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';

import 'widget/header_profile_card.dart';




class ProfileScreen extends GetWidget<ProfileViewModle> {
  const ProfileScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          txtProfile,
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()?SvgPicture.asset("assets/svgs/back_arrow_ar.svg"):SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: Column(
        children: [
         const HeaderProfileCard(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                SettingItem(
                  onTap: (){
                   changeLanguageBottomSheet();
                  },
                  trailingTitle: "",
                  settingTitle: txtlanguage.tr,
                  iconPath: "assets/svgs/language_profile.svg",
                ),
                SizedBox(height: sizeH12,), 
                SettingItem(
                  onTap: (){
                    
                  },
                  settingTitle: txtLog.tr ,
                  trailingTitle: "",
                  iconPath: "assets/svgs/log_icon.svg",
                ),
              SizedBox(height: sizeH12,),  
                SettingItem(
                  onTap: (){
                   Get.to(() => const SettingsScreen());
                  },
                  settingTitle: txtSetting.tr,
                  trailingTitle: "",
                  iconPath: "assets/svgs/setting.svg",
                ),

                SizedBox(height: sizeH12,),  
                SettingItem(
                  onTap: (){
                   controller.logOutBottomSheet();
                  },
                  settingTitle: txtLogOut.tr,
                  trailingTitle: "",
                  iconPath: "assets/svgs/logout.svg",
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}