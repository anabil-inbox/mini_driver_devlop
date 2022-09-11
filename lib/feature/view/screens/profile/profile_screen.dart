import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/profile/cash_closure/cash_closure_view.dart';
import 'package:inbox_driver/feature/view/screens/profile/report/report_view.dart';
import 'package:inbox_driver/feature/view/screens/profile/setting/setting_screen.dart';
import 'package:inbox_driver/feature/view/screens/profile/widget/setting_item.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';

import '../../../view_model/profile_view_modle/profile_view_modle.dart';
import 'log/log_screen.dart';
import 'widget/header_profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static ProfileViewModle get _profileViewModel => Get.put(ProfileViewModle());
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          txtProfile.tr,
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/svgs/back_arrow_ar.svg"),
              )
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
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
                  onTap: () {
                    changeLanguageBottomSheet();
                  },
                  trailingTitle: "",
                  settingTitle: txtlanguage.tr,
                  iconPath: "assets/svgs/language_profile.svg",
                ),
                SizedBox(
                  height: sizeH12,
                ),
                SettingItem(
                  onTap: () {
                    Get.to(() => const LogScreen());
                  },
                  settingTitle: txtLog.tr,
                  trailingTitle: "",
                  iconPath: "assets/svgs/log_icon.svg",
                ),
                SizedBox(
                  height: sizeH12,
                ),
                SettingItem(
                  onTap: () {
                    Get.to(() =>  ReportView());
                  },
                  settingTitle: txtReport.tr,
                  trailingTitle: "",
                  iconPath: "assets/svgs/log_icon.svg",
                ),
                SizedBox(
                  height: sizeH12,
                ),
                SettingItem(
                  onTap: () {
                    Get.to(() => const SettingsScreen());
                  },
                  settingTitle: txtSetting.tr,
                  trailingTitle: "",
                  iconPath: "assets/svgs/setting.svg",
                ),
                SizedBox(
                  height: sizeH12,
                ),
                SettingItem(
                  onTap: () {
                    Get.to(() => const CashClosureView());
                  },
                  settingTitle: txtCashClosure.tr,
                  trailingTitle: "",
                  iconPath: "assets/svgs/setting.svg",
                ),
                SizedBox(
                  height: sizeH12,
                ),
                SettingItem(
                  onTap: () {
                    _profileViewModel.logOutBottomSheet();
                  },
                  settingTitle: txtLogOut.tr,
                  trailingTitle: "",
                  iconPath: "assets/svgs/logout_icons_ornage.svg",
                ), SizedBox(
                  height: sizeH12,
                ),
                SettingItem(
                  onTap: () {
                    _profileViewModel.deleteAccountBottomSheet();
                  },
                  settingTitle: txtDeleteAccount.tr,
                  trailingTitle: "",
                  iconPath: "assets/svgs/delete_account.svg",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
