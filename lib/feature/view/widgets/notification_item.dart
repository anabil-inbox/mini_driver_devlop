import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/notification/notification_model.dart';
import 'package:inbox_driver/feature/view/screens/details/order_details_started_screen.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/date/date_time_util.dart';

import '../../../util/app_shaerd_data.dart';
import '../../../util/constance.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return InkWell(
      onTap: () => _onItemClick(),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: sizeH20!, vertical: sizeH5!),
        padding: EdgeInsets.symmetric(horizontal: sizeH12!, vertical: sizeH12!),
        decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius: BorderRadius.circular(sizeH6!)),
        child: Row(
          children: [
            SizedBox(
              width: sizeW15,
            ),
            SvgPicture.asset("assets/svgs/orange_notifications.svg"),
            SizedBox(
              width: sizeW10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextView(
                      txt: notification.title.toString(),
                      textStyle: textStyleAppbar()!.copyWith(
                        fontSize: 14,
                      )),
                  SizedBox(
                    height: sizeW2,
                  ),
                  CustomTextView(
                    txt: notification.message.toString(),
                    maxLine: Constance.maxLineTwo,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: sizeW2,
                  ),
                  Text(
                    DateUtility.dateFormatNamed(
                        txtDate: notification.date.toString()),
                    style: smallHintTextStyle(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onItemClick() {
    // Get.to(OrderDetailsStarted(
    //     index: index,
    //     salesOrder: salesOrder,
    //     salesData: salesData,
    //     task: task,
    //     isFromCompleted: isFromCompleted));
  }
}
