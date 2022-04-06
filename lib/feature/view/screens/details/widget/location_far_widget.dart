import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/model/app_setting_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/sh_util.dart';

import '../../../../../util/app_shaerd_data.dart';

class LocationFarWdiget extends StatelessWidget {
  const LocationFarWdiget({Key? key}) : super(key: key);

  static ApiSettings settings =
      ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
          color: colorDark, borderRadius: BorderRadius.circular(padding6!)),
      margin: EdgeInsets.symmetric(horizontal: padding20!),
      padding: EdgeInsets.all(padding6!),
      width: double.infinity,
      child: Text(
        "Your location in far away more than ${settings.deliveryFactor}km from the destination",
        textAlign: TextAlign.center,
        style: textStyleBlack16()!
            .copyWith(fontSize: fontSize12, color: colorBackground),
      ),
    );
  }
}
