import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/payment_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  Widget paymentMethod({required HomeViewModel homeViewModel}) {
    if ((homeViewModel.operationTask.totalDue ?? 0) > 0) {
      return  PaymentWidget(operationTask:homeViewModel.operationTask);
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: sizeH13),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextView(
                txt: txtTotal.tr,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              GetBuilder<HomeViewModel>(
                builder: (home) {
                  return CustomTextView(
                    txt: getPriceWithFormate(
                        price: home.operationTask.total ?? 0),
                    textStyle: textStyleMeduimPrimaryBold(),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: sizeH14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextView(
                txt: txtPaid.tr,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              GetBuilder<HomeViewModel>(
                builder: (home) {
                  return CustomTextView(
                    txt: getPriceWithFormate(
                        price: home.operationTask
                                .totalPaid
                            ??
                            0),
                    textStyle: textStyleMeduimPrimaryBold(),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: sizeH14),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextView(
                txt: txtAmountDue.tr,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              GetBuilder<HomeViewModel>(
                builder: (home) {
                  return CustomTextView(
                    txt: getPriceWithFormate(
                        price: home.operationTask
                                .totalDue
                            ??
                            0),
                    textStyle: textStyleMeduimPrimaryBold(),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: sizeH22),
          GetBuilder<HomeViewModel>(
            initState: (init){

            },
            builder: (homeViewModel) {
              return paymentMethod(homeViewModel: homeViewModel);
            },
          ),
        ],
      ),
    );
  }

  //this for calc if [waitingTime] > mFrom && [waitingTime] < mTo
  num? waitingTimeReques(HomeViewModel home) {
    if (home.operationTask.waitingTime != 0 &&
        home.operationTask.lateFees != null &&
        home.operationTask.lateFees!.isNotEmpty) {
      return home.operationTask.lateFees
          ?.where((element) =>
              element.mFrom! < home.operationTask.waitingTime! &&
              element.mTo! > home.operationTask.waitingTime!)
          .first
          .fees;
    } else {
      return 0;
    }
  }
}
