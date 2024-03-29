import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class BackBtnWidget extends StatelessWidget {
  final Function()? onTap;

  const BackBtnWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return InkWell(
        onTap: onTap ?? _getBack,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: isArabicLang()
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svgs/back_arrow_ar.svg"),
                )
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ));
  }

  _getBack() => Get.back();
}
