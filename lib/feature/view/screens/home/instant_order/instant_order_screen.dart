import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/balance_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/contract_signature_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/scan_products_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/new_customer_view.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';
import 'Widgets/customer_signature_instant_order.dart';
import 'Widgets/scan_box_instant_order.dart';
import 'Widgets/scan_delivered_box.dart';

class InstantOrderScreen extends StatelessWidget {
  const InstantOrderScreen({Key? key, this.isNewCustomer = false})
      : super(key: key);

  final bool isNewCustomer;
  Widget get waitingTime => Container(
        height: sizeH80,
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextView(
              txt: txtWaitingTime.tr,
              textStyle: textStyleNormal(),
            ),
            SizedBox(
              height: sizeH7,
            ),
            CustomTextView(
              txt: txtTimer.tr,
              textStyle: textStylePrimaryBold()?.copyWith(color: colorBlack),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: CustomTextView(
          txt: txtInstantOrder.tr,
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: sizeH27),
                  if (isNewCustomer) const ContractSignature(),
                  if (isNewCustomer) SizedBox(height: sizeH10),
                  if (isNewCustomer) const NewCustomer(),
                  const ScanDeliveredBox(),
                  SizedBox(height: sizeH10),
                  const ScanBoxInstantOrder(),
                  SizedBox(height: sizeH10),
                  const ScanProducts(),
                  SizedBox(height: sizeH10),
                  const Balance(),
                  SizedBox(height: sizeH10),
                  const CustomerSignatureInstantOrder(),
                  SizedBox(height: sizeH10),
                  waitingTime,
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    isExpanded: false,
                    isLoading: false,
                    onClicked: () {},
                    textButton: "Delivered",
                  ),
                  SizedBox(
                    width: sizeW12,
                  ),
                  SizedBox(
                    width: sizeW150,
                    child: SeconderyFormButton(
                      buttonText: "No Show",
                      onClicked: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sizeH27,
            ),
          ],
        ),
      ),
    );
  }
}
