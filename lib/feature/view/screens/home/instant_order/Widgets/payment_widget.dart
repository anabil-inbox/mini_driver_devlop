import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_driver/feature/model/payment/payment.dart';
import 'package:inbox_driver/feature/model/tasks/task_response.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/payment_item.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:logger/logger.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key, this.operationTask, }) : super(key: key);
  final TaskResponse? operationTask;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: padding10),
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH38,
            child: GetBuilder<HomeViewModel>(
              initState: (_){
                // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                //   _.controller?.operationTask.paymentMethod = operationTask?.paymentMethod ;
                //   _.controller?.update();
                // });

              },
              builder: (home) {
                if (home.operationTask.totalDue! <=
                    0) {
                  return const SizedBox();
                }
                // return ListView(
                //   shrinkWrap: true,
                //   scrollDirection: Axis.horizontal,
                //   children: getPaymentMethod()
                //       .map((e) {
                //         return PaymentItem(
                //             paymentMethod: e,
                //           );
                //       })
                //       .toList(),
                // );
                return Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: getPaymentMethod()
                      .map((e) {
                    // Logger().w("pay_${home.operationTask.toJson()} e_${e.toJson()}");
                        return PaymentItem(
                            paymentMethod: e,
                          );
                      })
                      .toList(),
                );
              },
            ),
          ),
          SizedBox(
            height: sizeH16,
          ),
          if (Platform.isIOS) ...[
            SizedBox(
              height: sizeH36,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.14,
              child: PaymentItem(
                paymentMethod: PaymentMethod(
                    id: Constance.applePay,
                    name: Constance.applePay,
                    image: Constance.appleImage),
              ),
            ),
          ],
          SizedBox(
            height: sizeH25,
          ),

        ],
      ),
    );
  }
}
