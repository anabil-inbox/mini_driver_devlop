import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/payment_item.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:logger/logger.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH38,
            child: GetBuilder<HomeViewModel>(
              builder: (home) {
                if (home.operationTask.totalDue! <=
                    0) {
                  return const SizedBox();
                }
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: getPaymentMethod()
                      .map((e) {
                        Logger().d(e.toJson());
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
            height: sizeH25,
          ),
        ],
      ),
    );
  }
}
