import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/payment/payment.dart';
import 'package:inbox_driver/feature/model/tasks/task_response.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';

import '../../../../../../util/app_shaerd_data.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({Key? key, required this.paymentMethod}) : super(key: key);

  final PaymentMethod paymentMethod;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return InkWell(
      onTap: () {
        TaskResponse taskResponse = homeViewModel.operationTask;
        taskResponse.paymentMethod = paymentMethod.name;
        homeViewModel.operationTask = taskResponse;
        homeViewModel.update();
        homeViewModel.sendPaymentRequest(
            paymentMethod: paymentMethod.id ?? paymentMethod.name ?? "");
        // if (paymentMethod.id == Constance.walletKey || paymentMethod.id == Constance.bankKey ) {//applications
        //   homeViewModel.sendPaymentRequest();
        // }
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width /4,
        // margin: EdgeInsets.symmetric(horizontal: padding4!),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(padding6!),
          border: Border.all(
              width: 2 /*0.5*/,
              color:
                  homeViewModel.operationTask.paymentMethod != paymentMethod.id
                      ? colorContainerGrayLight
                      : colorPrimary),
          /*color: homeViewModel.operationTask.paymentMethod != paymentMethod.id
                ? colorTextWhite
                : colorPrimary*/
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 1 /*padding9!*/, horizontal: 1 /*padding14!*/),
        child: Column(
          children: [
            if (paymentMethod.image != null && paymentMethod.image != "") ...[
              imageNetwork(
                  isPayment: true,
                  url:paymentMethod.id == Constance.applePay  ? paymentMethod.image.toString(): ConstanceNetwork.imageUrl +
                      paymentMethod.image.toString(),
                  fit: BoxFit.contain,
                  width: sizeH90,
                  height: sizeH60!),
            ] else ...[
              imageNetwork(
                  isPayment: true,
                  width: sizeH90,
                  height: sizeH60,
                  fit: BoxFit.contain)
            ],
            if(paymentMethod.id != Constance.applePay)...[
            SizedBox(
              width: sizeW12,
            ),
            CustomTextView(
              txt: "${paymentMethod.name}",
              textStyle:
                  /*homeViewModel.operationTask.paymentMethod == paymentMethod.id
                      ? textStylebodyWhite()
                      : textStyleHints()!
                          .copyWith(fontSize: fontSize14, color: colorHint2)*/
                  textStyleHints()!.copyWith(
                      fontSize: fontSize14, color: colorBlack /*colorHint2*/),
            ),
            ],
          ],
        ),
      ),
    );
  }
}
