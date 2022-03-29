import 'package:flutter/material.dart';
import 'package:inbox_driver/util/date/date_time_util.dart';

import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_shaerd_data.dart';
import '../../../../../../util/app_style.dart';
import '../../../../../../util/font_dimne.dart';
import '../../../../widgets/custome_text_view.dart';


class CashListItem extends StatelessWidget {
  const CashListItem({ Key? key, this.title, this.date, this.cash , }) : super(key: key);

  final String? title;
  final String? date;
  final String? cash;
  
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
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

            Text(formatStringWithCurrency("$cash" , "\$"),style: textStylePrimaryFont(),),
            Container(
              width: sizeW90,
              height: sizeH27,
              decoration: BoxDecoration(
                color: colorGryBackgroundContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CustomTextView(
                  txt: "received",
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
            Text("$title" ,style: textStyleIntroBody(),),
            SizedBox(height: sizeH4,),
            Text("${DateUtility.convertDateTimeToAmPm(DateTime.now())}" , style: smallFontHint2TextStyle(),)
          ],
          
        ),
      ),
    );
  }
}