import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/widget/header_login_widget.dart';
import 'package:inbox_driver/feature/view/screens/auth/signUp_signIn/widget/shared_login_form_widget.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';

import 'package:inbox_driver/util/string.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: colorScaffoldRegistrationBody,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const HeaderLogin(),
          SizedBox(
            height: sizeH16,
          ),
          SizedBox(
            height: sizeH29,
          ),
          Text(
            txtWhatsIsyourMobileNumber.tr,
            style: textStyleHints(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: sizeH30,
          ),
          const LoginForm(),
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    );
  }
}
