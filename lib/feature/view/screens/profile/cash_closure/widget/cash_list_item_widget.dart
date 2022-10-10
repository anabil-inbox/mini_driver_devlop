import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/profile/cash_closer_data.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/logout_bottom_sheet.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/string.dart';

import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_shaerd_data.dart';
import '../../../../../../util/app_style.dart';
import '../../../../../../util/font_dimne.dart';
import '../../../../widgets/custome_text_view.dart';


class CashListItem extends StatelessWidget {
  const CashListItem({ Key? key, this.cashCloserData, this.logic,   }) : super(key: key);

  final CashCloserData? cashCloserData;
  final ProfileViewModle? logic;
  
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return InkWell(
      onTap: _onCashItemClick,
      splashColor: colorTrans,
      highlightColor: colorTrans,
      focusColor: colorTrans,
      hoverColor: colorTrans,

      child: Container(
        // height: sizeH65,
        padding: EdgeInsets.symmetric(vertical: sizeH4!),
        decoration: BoxDecoration(
                color: colorTextWhite,
          borderRadius: BorderRadius.circular(padding6!)
        ),
        margin: EdgeInsets.symmetric(vertical: padding6!),
        child: ListTile(

          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [

              Text(formatStringWithCurrency("${cashCloserData?.amount}" , "QR"),style: textStylePrimaryFont(),),
              Container(
                width: sizeW90,
                height: sizeH27,
                decoration: BoxDecoration(
                  color: colorGryBackgroundContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: CustomTextView(
                    txt: cashCloserData?.status == 0 ?txtNotPaid.tr : txtHandover.tr,
                    textStyle: textStyleNormal()?.copyWith(
                        fontSize: fontSize13, color: colorGreen),
                  ),
                ),
              )
            ]
          ),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sizeH10,),
              Text("${cashCloserData?.salesOrder}" ,style: textStyleIntroBody(),),
              SizedBox(height: sizeH4,),
              // Text("${DateUtility.convertDateTimeToAmPm(DateTime.now())}" , style: smallFontHint2TextStyle(),)
            ],

          ),
        ),
      ),
    );
  }

  void _onCashItemClick() {
    Get.bottomSheet(GlobalBottomSheet(
      title: composeText(),
      isTwoBtn: false,
      onOkBtnClick: (){
        logic?.applyCashCloser(cashCloserData?.id);
      },
    ));
  }

  String composeText() => (txtApplyCashCloser.tr + " " + cashCloserData!.salesOrder.toString()); //
}