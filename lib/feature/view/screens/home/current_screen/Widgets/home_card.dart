import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/wh_loading.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/date/date_time_util.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.task, required this.index})
      : super(key: key);

  final TaskModel task;
  final int index;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GestureDetector(
      onTap: () {
        Get.to(() => WhLoading(
              index: index,
              task: task,
            ));
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: padding9!,
            left: padding20!,
            right: padding20!,
            top: padding12!),
        decoration: BoxDecoration(
          color: (index != 0 && task.status == Constance.inProgress)
              ? colorTextWhite.withOpacity(0.5)
              : colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          color: (index != 0 && task.status == Constance.inProgress)
              ? colorTextWhite.withOpacity(0.5)
              : colorTextWhite,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH17!),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextView(
                  txt: task.taskName,
                  textStyle: textStyleBlack16(),
                ),
                SizedBox(height: sizeH5),
                CustomTextView(
                  txt: DateUtility.getChatTime(task.date.toString()),
                  textStyle: textStyleNormal(),
                ),
                SizedBox(height: sizeH7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: sizeW90,
                      height: sizeH27,
                      decoration: BoxDecoration(
                        color: colorGryBackgroundContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(padding12!),
                      ),
                      child: Center(
                        child: CustomTextView(
                          txt: "${task.totalTasks} ${txtTotalTask.tr}",
                          textStyle: textStyleNormal()
                              ?.copyWith(fontSize: fontSize13, color: colorRed),
                        ),
                      ),
                    ),
                    SizedBox(width: sizeW5),
                    Container(
                      width: sizeW90,
                      height: sizeH27,
                      decoration: BoxDecoration(
                        color: colorGryBackgroundContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomTextView(
                          txt: "${task.totalDone} ${txtClosedTask.tr}",
                          textStyle: textStyleNormal()?.copyWith(
                              fontSize: fontSize13, color: colorGreen),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
