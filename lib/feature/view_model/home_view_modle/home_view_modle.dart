import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeViewModel extends GetxController {
  int selectedTab = 0;
  void changeTab(int x) {
    selectedTab = x;
    update();
  }

  // open Scaner Qr :
  var scanArea = (MediaQuery.of(Get.context!).size.width < 400 ||
          MediaQuery.of(Get.context!).size.height < 400)
      ? 150.0
      : 300.0;

  Barcode? result;
  QRViewController? controller;

  onQRViewCreated(QRViewController controller,
      {bool? isFromAtHome, int? index}) {
    try {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        result = scanData;
      }).onData((data) async {});
    } catch (e) {
      printError();
    }
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    try {
      if (!p) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('no Permission')),
        );
      }
    } catch (e) {
      printError();
    }
  }

  bool isTabBarOutBox = false;
}
