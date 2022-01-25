import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/scan_box.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'Widgets/balance.dart';
import 'Widgets/contract_signature.dart';
import 'package:get/get.dart';
import 'Widgets/customer_signature.dart';
import 'Widgets/scan_products.dart';

class NewCustomer extends StatelessWidget {
  Widget get contract => ContractSignature();
  Widget get scanBox => const ScanBox();
  Widget get scanProducts => const ScanProducts();
  Widget get balance => const Balance();
  Widget get customerSignature => const CustomerSignature();
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: CustomTextView(
          txt: txtNewCustomer,
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding20!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sizeH20),
              contract,
              SizedBox(height: sizeH10),
              idVer,
              SizedBox(height: sizeH10),
              scanBox,
              SizedBox(height: sizeH10),
              scanProducts,
              SizedBox(height: sizeH10),
              balance,
              SizedBox(height: sizeH10),
              customerSignature,
            ],
          ),
        ),
      ),
    );
  }

  Widget get idVer => Container(
        height: sizeH50,
        padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            CustomTextView(
              txt: txtIDVerification.tr,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => const ScanScreen());
              },
              child: SvgPicture.asset("assets/svgs/Scan.svg",
                  color: colorRed, width: sizeW20, height: sizeH17),
            ),
          ],
        ),
      );
}
