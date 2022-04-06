import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/profile/cash_closure/widget/cash_list_item_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

import '../../../../../util/app_style.dart';
import '../../../../../util/constance.dart';
import '../../../../../util/string.dart';
import '../../../widgets/custome_text_view.dart';
import 'widget/cash_money_widget.dart';

class CashClosureView extends StatelessWidget {
  const CashClosureView({Key? key}) : super(key: key);

  PreferredSizeWidget get myAppbar =>
      CustomAppBarWidget(

        titleWidget: CustomTextView(

          txt: txtCashClosure.tr,
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      );

  Widget  myCashStatus(ProfileViewModle logic) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: CashMoneyItem(value: logic.totalAmount.toString(), title: txtTotalAmount.tr,)),
          SizedBox(width: sizeW10,),
          Expanded(child: CashMoneyItem(value: logic.padAmount.toString(), title: txtPaidAmount.tr,)),
          SizedBox(width: sizeW10,),
          Expanded(
              child: CashMoneyItem(value: logic.remainingAmount.toString(), title: txtRemainingAmount.tr,)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: myAppbar,
      body: GetBuilder<ProfileViewModle>(
          init: ProfileViewModle(),
          initState: (state){
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.getCashCloser();
            });
          },
          builder: (logic) {
        return Padding(
          padding: EdgeInsets.only(
              left: sizeW20!, right: sizeW20!, top: sizeH20!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(!logic.isLoading && logic.listCashCloser.isNotEmpty)
              myCashStatus(logic),
              SizedBox(
                height: sizeH20!,
              ),
              if(logic.isLoading)...[
                 Expanded(child: Center(child: CircularProgressIndicator(color: colorPrimary,),))
              ]
              else if(logic.listCashCloser.isNotEmpty)...[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    clipBehavior: Clip.hardEdge,
                    itemCount: logic.listCashCloser.length,
                    itemBuilder: (context, index) =>
                        CashListItem(
                          logic:logic,
                            cashCloserData: logic.listCashCloser[index]
                        ),),
                ),
              ],
              SizedBox(
                height: sizeH20!,
              ),
            ],
          ),
        );
      }),
    );
  }
}
