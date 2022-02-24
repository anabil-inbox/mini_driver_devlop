import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key, this.taskModel, required this.isBoxSalesScan})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static GlobalKey<FormState> qrKey = GlobalKey<FormState>();
  final TaskModel? taskModel;
  final bool isBoxSalesScan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: (controller) => homeViewModel.onQRViewCreated(
                controller,
                taskModel: taskModel,
                isFromScanSalesBoxs: isBoxSalesScan),
            overlay: QrScannerOverlayShape(
                borderColor: colorRed,
                borderRadius: padding12!,
                borderLength: padding30!,
                borderWidth: padding12!,
                cutOutSize: homeViewModel.scanArea),
            onPermissionSet: (ctrl, p) =>
                homeViewModel.onPermissionSet(context, ctrl, p),
          ),

          // Positioned(
          //     top: padding40,
          //     right: padding20,
          //     left: padding20,
          //     child: const ChartWidget(
          //       firstGreenValue: 40,
          //       firstRedValue: 60,
          //       firstTitle: "12/15 \nBoxes",
          //       secondGreenValue: 30,
          //       secondRedValue: 100,
          //       secondTitle: "4/5 \nOthers",
          //       mainTitle: "22/6/2021 6:00 PM",
          //     ))
        ],
      ),
    );
  }
}
