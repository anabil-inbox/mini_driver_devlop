
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class HeaderLogin extends GetWidget<AuthViewModle> {
  const HeaderLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return  SizedBox(
      height: sizeH200,
      child: Stack(
        children: [
          PositionedDirectional(
            top: padding0,
            bottom: padding0,
            start: padding0,
            end: padding0,
            child: SvgPicture.asset(
              "assets/svgs/header_background.svg",
               fit: BoxFit.cover
            ),
          ),
          PositionedDirectional(
            end: padding20,
            top: padding45,
            child: IconButton(
              onPressed: (){
                changeLanguageBottomSheet();
              },
              icon: SvgPicture.asset("assets/svgs/language_eye.svg" ,)),
          ),
          PositionedDirectional(
            start: padding0,
            end: padding0,
            top: padding80,
            bottom: padding40,
            child: SvgPicture.asset("assets/svgs/logo_horizantal.svg",),
          ),
        ],
      ),
    );
  
  }

}