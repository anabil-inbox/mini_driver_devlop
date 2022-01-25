import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/call_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/emergency_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/instant_order_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/no_show_report_bottom_sheet.dart';
import 'package:inbox_driver/util/string.dart';

class Log extends StatelessWidget {
  const Log({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          'log',
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()
              ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => const CallBottomSheet(),
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                  );
                },
                color: colorPrimary,
                child: CustomTextView(
                  txt: 'call',
                  textStyle: textStyleBtn(),
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        const InstantOrderBottomSheet(),
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                  );
                },
                color: colorPrimary,
                child: CustomTextView(
                  txt: 'instant Order',
                  textStyle: textStyleBtn(),
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => const EmergencyBottomSheet(),
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                  );
                },
                color: colorPrimary,
                child: CustomTextView(
                  txt: 'Emergency',
                  textStyle: textStyleBtn(),
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        const NoShowReportBottomSheet(),
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                  );
                },
                color: colorPrimary,
                child: CustomTextView(
                  txt: txtNoShowReport,
                  textStyle: textStyleBtn(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
