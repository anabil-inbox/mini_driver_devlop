import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:logger/logger.dart';

import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_style.dart';
import '../../../../../../util/string.dart';

class WattingTime extends StatelessWidget {
  const WattingTime({Key? key, required this.isFreeTime}) : super(key: key);

  final bool isFreeTime;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    if (isFreeTime) {
      return Container(
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeH14,
            ),
            CustomTextView(
              txt: txtWaitingTime.tr,
              textStyle: textStyleNormal(),
            ),
            SizedBox(
              height: sizeH7,
            ),
            TweenAnimationBuilder<Duration>(
                duration: Duration(
                    minutes: homeViewModel.operationTask.waitingTime?.toInt() ?? 0),
                tween: Tween(
                    begin: Duration(
                        minutes:
                            homeViewModel.operationTask.waitingTime?.toInt() ??
                                0),
                    end: Duration.zero),
                onEnd: () {
                  Logger().e('Timer ended');
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  final minutes = value.inMinutes;
                  final seconds = value.inSeconds % 60;
                  homeViewModel.waiteTimeOperation =
                      Duration(minutes: minutes, seconds: seconds);
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        '$minutes:$seconds',
                        style:
                            textStylePrimaryBold()?.copyWith(color: colorBlack),
                      ));
                }),
            SizedBox(
              height: sizeH14,
            ),
          ],
        ),
      );
      // return const SizedBox();
    } else {
      return Container(
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeH14,
            ),
            CustomTextView(
              txt: txtWaitingTime.tr,
              textStyle: textStyleNormal(),
            ),
            SizedBox(
              height: sizeH7,
            ),
            TweenAnimationBuilder<Duration>(
                duration: const Duration(minutes: 1000),
                tween: Tween(
                    begin: homeViewModel.operationTask.timer == null
                        ? Duration.zero
                        : homeViewModel.waiteTimeOperation,
                    end: const Duration(minutes: 1000)),
                onEnd: () {
                  Logger().e('Timer ended');
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  final minutes = value.inMinutes;
                  final seconds = value.inSeconds % 60;
                  homeViewModel.waiteTimeOperation = Duration(minutes: minutes, seconds: seconds);
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        '$minutes:$seconds',
                        style:
                            textStylePrimaryBold()?.copyWith(color: colorBlack),
                      ));
                }),
            SizedBox(
              height: sizeH14,
            ),
          ],
        ),
      );
    }
  }
}
