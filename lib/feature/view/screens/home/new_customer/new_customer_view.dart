import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/scan_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';
import 'Widgets/balance_widget.dart';
import 'Widgets/contract_signature_widget.dart';
import 'package:get/get.dart';
import 'Widgets/customer_signature_widget.dart';
import 'Widgets/scan_products_widget.dart';

class NewCustomer extends StatelessWidget {
 const NewCustomer({Key? key}) : super(key: key);

  Widget get contract => const ContractSignature();
  Widget get scanBox => const ScanBox();
  Widget get scanProducts => const ScanProducts();
  Widget get balance => const Balance();
  Widget get customerSignature => const CustomerSignature();
 static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  Widget get idVerification => Container(
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
            Get.to(() => const ScanScreen(
               isScanDeliverdBoxes: false,
               isBoxSalesScan: false,
                isProductScan: false,
            ));
          },
          child: SvgPicture.asset("assets/svgs/Scan.svg",
              color: colorRed, width: sizeW20, height: sizeH17),
        ),
      ],
    ),
  );

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: sizeH20),
            contract,
            SizedBox(height: sizeH10),
            idVerification,
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
    );
  }


}
