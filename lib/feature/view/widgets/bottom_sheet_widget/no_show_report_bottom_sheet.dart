import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:logger/logger.dart';

import '../../../../util/app_color.dart';
import 'Widgets/bottom_sheet_card.dart';

class NoShowReportBottomSheet extends StatelessWidget {
  const NoShowReportBottomSheet({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: sizeH20),
              SvgPicture.asset('assets/svgs/Indicator.svg'),
              SizedBox(height: sizeH17),
              Text(
                txtNoShowReport!.tr,
                style: textStyleTitle(),
              ),
              SizedBox(height: sizeH12),
              // GetBuilder<HomeViewModel>(
              //   builder: (home) {
              //     return Center(
              //       child: CustomTextView(
              //         txt: home.start.toString(),
              //         textStyle: textStyleLargeText()?.copyWith(fontSize: 48),
              //       ),
              //     );
              //   },
              // ),
              TweenAnimationBuilder<Duration>(
                  duration: homeViewModel.wateTime,
                  tween: Tween(begin: homeViewModel.wateTime , end: Duration.zero),
                  onEnd: () {
                    Logger().e('Timer ended');
                  },
                  builder: (BuildContext context, Duration value, Widget? child) {
                    final minutes = value.inMinutes;
                    final seconds = value.inSeconds % 60;
                    homeViewModel.wateTime = Duration(minutes: minutes , seconds: seconds);
                   
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '$minutes:$seconds',
                          style: Theme.of(context).textTheme.headline5,
                        ));
                  }),
              SizedBox(height: sizeH20),
              BottomSheetCard(
                text: txtReSchedule!.tr,
                textStyleColor: colorRed,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
              BottomSheetCard(
                text: txtNoShow!.tr,
                textStyleColor: colorRed,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
              SizedBox(
                height: sizeH18,
              ),
              PrimaryButton(
                  isLoading: false,
                  textButton: txtCancelOrder!.tr,
                  onClicked: () {
                    Get.back();
                  },
                  isExpanded: true),
              SizedBox(
                height: sizeH34,
              )
            ],
          );
        },
      ),
    );
  }
}
