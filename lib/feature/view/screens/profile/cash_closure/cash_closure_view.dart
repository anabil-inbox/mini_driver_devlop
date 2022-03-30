import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/profile/cash_closure/widget/cash_list_item_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

import '../../../../../util/app_style.dart';
import '../../../../../util/constance.dart';
import '../../../../../util/string.dart';
import '../../../widgets/custome_text_view.dart';
import 'widget/cash_money_widget.dart';

class CashClosureView extends StatelessWidget {
  const CashClosureView({Key? key}) : super(key: key);

  PreferredSizeWidget get myAppbar => CustomAppBarWidget(
      
        titleWidget: CustomTextView(
          
          txt: txtCashClosure.tr,
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      );

  Widget get myCashStatus =>  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(child: CashMoneyItem(value: '', title: txtTotalAmount.tr,)),
      SizedBox(width: sizeW10,),
      Expanded(child: CashMoneyItem(value: '', title: txtPaidAmount.tr,)),
      SizedBox(width: sizeW10,),
      Expanded(child: CashMoneyItem(value: '', title: txtRemainingAmount.tr,)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: myAppbar,
      body: Padding(
        padding: EdgeInsets.only(left: sizeW20!, right: sizeW20!, top: sizeH20!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myCashStatus,
            SizedBox(
              height: sizeH20!,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  clipBehavior: Clip.hardEdge,
                  itemCount: 20,
                  itemBuilder: (context, index) =>const CashListItem(
                    title: "Recall box",
                    date:"s",
                    cash: "d",
                  ),),
            ),
            SizedBox(
              height: sizeH20!,
            ),
          ],
        ),
      ),
    );
  }
}
