import 'package:flutter/cupertino.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_style.dart';
import '../../../../../../util/font_dimne.dart';
import '../../../../../../util/string.dart';
import '../../../../widgets/custome_text_view.dart';
import 'package:get/get.dart';

class StatusCompletedTaskWidget extends StatelessWidget {
  const StatusCompletedTaskWidget({Key? key,required this.taskCount, this.isTodo = false}) : super(key: key);
  final String taskCount;
  final bool? isTodo;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
        decoration: BoxDecoration(
            color:isTodo!?colorGreen: colorRed,
            boxShadow: [boxShadowLight()!],
            borderRadius: BorderRadius.circular(sizeRadius10!)),
        padding: EdgeInsets.symmetric(horizontal: sizeW12!, vertical: sizeH22!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextView(
              txt: taskCount,
              textAlign: TextAlign.center,
              textStyle: textStyleAppbar()!.copyWith(fontWeight: FontWeight.bold,fontSize: fontSize16 , color: colorTextWhite),
              textOverflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: sizeW15,
            ),
            CustomTextView(
              txt:isTodo! ? txtToDo.tr:txtInProgressing.tr,
              textAlign: TextAlign.center,
              textStyle: textStyleAppbar()!.copyWith(
                  fontSize: fontSize12, fontWeight: FontWeight.normal, color: colorTextWhite),
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ));
  }
}
