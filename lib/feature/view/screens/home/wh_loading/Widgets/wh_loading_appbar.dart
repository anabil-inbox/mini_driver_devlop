import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/map_view_model/map_view_model.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

import '../../../../widgets/bottom_sheet_widget/emergency_bottom_sheet.dart';

class WhLoadingAppBar extends StatelessWidget {
  const WhLoadingAppBar({Key? key, required this.title ,  this.salesData , this.taskModel}) : super(key: key);

  final String title;
  final TaskModel? taskModel;
  final SalesData? salesData;

  static MapViewModel mapViewModel = Get.put(MapViewModel() , permanent: true);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SizedBox(
      // height: sizeH50,
      child: CustomAppBarWidget(
        elevation: 0,
        appBarColor: colorBackground,
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: title,
          textStyle: textStyleBlack16(),
        ),
        onBackBtnClick: () {
          Navigator.pop(context);
        },
        leadingWidget: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: isArabicLang()
              ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),

        // leadingWidget: GestureDetector(
        //   onTap: () {
        //     Get.back();
        //   },
        //   child:
        //       // IconBtn(
        //       //   onPressed: () {
        //       //     Navigator.pop(Get.context!);
        //       //   },
        //       //   icon: isArabicLang()
        //       //       ? "assets/svgs/back_arrow_ar.svg"
        //       //       : "assets/svgs/back_arrow.svg",
        //       //   width: sizeW48,
        //       //   height: sizeH48,
        //       //   backgroundColor: colorBtnGray,
        //       //   iconColor: Colors.black,
        //       //   borderColor: Colors.transparent,
        //       // )
        //       IconButton(
        //     onPressed: () {
        //       Navigator.pop(Get.context!);
        //     },
        //     icon: isArabicLang()
        //         ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
        //         : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        //   ),
        //   // IconBtn(
        //   //   iconColor: colorTextWhite,
        //   //   width: sizeW48,
        //   //   height: sizeH48,
        //   //   backgroundColor: colorRed,
        //   //   onPressed: () {
        //   //     // Get.to(() => QrScreen());
        //   //   },
        //   //   borderColor: colorTrans,
        //   //   icon: "assets/svgs/Scan.svg",
        //   // ),
        // ),
        // leadingWidth: sizeW48,

        actionsWidgets: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: sizeW2!, vertical: sizeH7!),
            child: IconBtn(
              icon: "assets/svgs/Call Missed.svg",
              iconColor: colorRed,
              width: sizeW36,
              height: sizeH36,
              backgroundColor: Colors.transparent,
              onPressed: () {
                mapViewModel.getMyCurrentPosition();
                
                Get.bottomSheet( 
                  EmergencyBottomSheet(
                  taskModel: taskModel,
                  lat: mapViewModel.myLatLng.latitude,
                  long: mapViewModel.myLatLng.longitude,
                  
                ),
                    isScrollControlled: true);
              },
              borderColor: colorRed,
            ),
          ),
          SizedBox(
            width: sizeW20,
          )
        ],
      ),
    );
  }
}
