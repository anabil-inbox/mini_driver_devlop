import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/home/Task_model.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/network/api/feature/home_helper.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';
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
      }).onData((data) async {
        controller.dispose();
        await scanBox(
            serial: data.code ?? "",
            taskName: operationsSalesData?.taskName ?? "");
        Get.back();
      });
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

  // this Fun For Loading And ETC >>
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    update();
  }

  endLoading() {
    isLoading = false;
    update();
  }

  List<Task> tasksInProgress = [];
  List<Task> tasksDone = [];

  // to do here for Getting Driver Tasks :
  Future<void> getHomeTasks({required String taskType}) async {
    try {
      startLoading();
      await HomeHelper.getInstance.getHomeTasks(taskType: {
        Constance.taskStatus: taskType
      }).then((value) => {
            if (taskType == Constance.inProgress)
              {
                tasksInProgress = value,
              }
            else
              {
                tasksDone = value,
              }
          });
    } catch (e) {
      //Fauiler State
      endLoading();
      printError();
    }
    endLoading();
    update();
  }

  // to do here getting Specfice Task With Id :

  SalesData? operationsSalesData;

  Future<void> getSpecificTask({required String taskId}) async {
    try {
      startLoading();
      await HomeHelper.getInstance
          .getSpecificTask(taskId: {Constance.taskId: taskId}).then((value) => {
                operationsSalesData = value,
              });
    } catch (e) {
      endLoading();
      printError();
    }
    endLoading();
  }

  scanBox({required String serial, required String taskName}) async {
    try {
      await HomeHelper.getInstance.scanBox(body: {
        Constance.serial: serial,
        Constance.taskName: taskName
      }).then((value) => {
            if (value.status!.success!)
              {
                operationsSalesData?.totalReceived =
                    (operationsSalesData?.totalReceived ?? 0) + 1,
                    
              }
            else
              {snackError("$txtError", "Box Not Found")}
          });
    } catch (e) {
      printError();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getHomeTasks(taskType: Constance.inProgress);
    await getHomeTasks(taskType: Constance.done);
  }
}
