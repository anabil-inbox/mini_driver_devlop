import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/string.dart';

import '../../../../../../util/app_shaerd_data.dart';

class QtyBottomSheet extends StatelessWidget {
  QtyBottomSheet({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sizeH16),
            Text(txtChooseQuantity.tr,
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: sizeH16),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: homeViewModel.tdQty,
                textDirection: TextDirection.ltr,
                validator: (e) {
                  if (e!.trim().isEmpty) {
                    return txtPleaseEnterQuantity.tr;
                  }
                  return null;
                },
                maxLength: 10,
                decoration: InputDecoration(
                    filled: true, fillColor: colorBtnGray, counterText: ""),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: sizeH16),
            PrimaryButton(
                textButton: txtADD.tr,
                isLoading: false,
                onClicked: () {

                  hideFocus(context);
                  Future.delayed(const Duration(milliseconds: 500),(){
if (_formKey.currentState!.validate()) {
                    Get.to(() => const ScanScreen(
                       isScanDeliverdBoxes: false,
                          isFromScanSalesBoxs: false,
                          isProductScan: true,
                        ));
                  }
                  });
                  
                },
                isExpanded: true),
            SizedBox(height: sizeH16),
          ],
        ),
      ),
    );
  }
}
