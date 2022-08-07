import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/view/screens/auth/terms/terms_view.dart';
import 'package:inbox_driver/feature/view/screens/profile/setting/help_center/help_center_screen.dart';
import 'package:inbox_driver/feature/view/screens/profile/widget/setting_item_no_padding.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          txtSetting.tr,
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
      body: ListView(
        children: [
          // SizedBox(
          //   height: sizeH20,
          // ),
          // SettingItemNoPadding(
          //     settingTitle: txtHelpCenter.tr,
          //     onTap: () {
          //       Get.to(const HelpCenterScreen());
          //     }),
          SizedBox(
            height: sizeH16,
          ),
          SettingItemNoPadding(
              settingTitle: txtAboutInbox.tr,
              onTap: () {
                Get.to(() => const TermsScreen(
                      isAboutUs: true,
                    ));
              }),
          SizedBox(
            height: sizeH16,
          ),
          SettingItemNoPadding(
              settingTitle: txtTirms.tr,
              onTap: () {
                Get.to(() => const TermsScreen());
              }),
        ],
      ),
    );
  }
}
