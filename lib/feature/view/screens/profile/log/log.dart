import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/bottom_sheets/bottom_sheets.dart';
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
                    builder: (BuildContext context) => callBottomSheet(),
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
                        instantOrderBottomSheet(),
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
                    builder: (BuildContext context) => emergencyBottomSheet(),
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
                        noShowReportBottomSheet(),
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
