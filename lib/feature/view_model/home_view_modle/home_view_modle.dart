import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as multipart;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_driver/feature/model/home/emergencey/emergency_case.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/home/Widgets/secondery_button.dart';
import 'package:inbox_driver/network/api/feature/home_helper.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeViewModel extends GetxController {
  bool isSelected = true;

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

  List<TaskModel> tasksInProgress = [];
  List<TaskModel> tasksDone = [];

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
              {
                Logger().i(value.toJson()),
                snackError("$txtError", "${value.status!.message}")
              }
          });
    } catch (e) {
      printError();
    }
  }

  EmergencyCase? selectedEmergencyCase;
  List<EmergencyCase> emEmergencyCases = [];
  final TextEditingController tdEmergencyNote = TextEditingController();
  File? img;
  // to do here Get Emergancy::
  Future<void> getEmergancy() async {
    try {
      startLoading();
      await HomeHelper.getInstance
          .getEmergencyCasses()
          .then((value) => {emEmergencyCases = value});
    } catch (e) {
      printError();
    }
    endLoading();
    update();
  }

  Future<void> createEmergancyReport() async {
    try {
      startLoading();
      if (img != null) {
        img = await compressImage(img!);
      }
      await HomeHelper.getInstance.createEmergencyReports(body: {
        "emergency_case": selectedEmergencyCase?.name ?? "",
        "emergency_notes": tdEmergencyNote.text,
        "attatchment":
            img != null ? multipart.MultipartFile.fromFileSync(img!.path) : ""
      }).then((value) => {
            if (value.status!.success!)
              {snackSuccess(txtSuccess!.tr, value.status!.message!), Get.back()}
            else
              {snackError(txtSuccess!.tr, value.status!.message!)}
          });
    } catch (e) {
      printError();
    }

    endLoading();
    cleanEmergancy();
    update();
  }

  void cleanEmergancy() {
    tdEmergencyNote.clear();
    selectedEmergencyCase = null;
    img = null;
  }

  void getImageBottomSheet() {
    Get.bottomSheet(Container(
      height: sizeH240,
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Column(
        children: [
          SizedBox(
            height: sizeH20,
          ),
          Container(
            height: sizeH5,
            width: sizeH50,
            decoration: BoxDecoration(
                color: colorUnSelectedWidget,
                borderRadius: BorderRadius.circular(2.5)),
          ),
          SizedBox(
            height: sizeH20,
          ),
          Text(
            txtSelectImage.tr,
            style: textStyleAppBarTitle(),
          ),
          SizedBox(
            height: sizeH25,
          ),
          SeconderyButtom(
            // buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: txtCamera.tr,
            onClicked: () async {
              await getImage(ImageSource.camera);
              Get.back();
            },
            // isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
          SeconderyButtom(
            //  buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: txtGallery.tr,
            onClicked: () async {
              await getImage(ImageSource.gallery);
              Get.back();
            },
            //  isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    ));
  }

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      img = File(pickedImage.path);
      update();
    }
  }

  bool validationEmergency() {
    if (selectedEmergencyCase == null) {
      snackError(txtError!.tr, txtYouHaveToSelectEmergencyCase.tr);
      return false;
    } else {
      return true;
    }
  }

  Future<void> recivedBoxes(
      {required String serial, required String taskName}) async {
    try {
      startLoading();
      HomeHelper.getInstance.reciveBoxess(body: {
        "id": serial,
        Constance.taskName: taskName
      }).then((value) => {
            if (value.status!.success!)
              {
                operationsSalesData?.totalReceived =
                    (operationsSalesData?.totalReceived ?? 0) +
                        num.parse(value.data["box_received_count"].toString()),
                snackSuccess(txtSuccess!.tr, value.status!.message!),
              }
            else
              {
                Logger().i(value.toJson()),
                snackError("$txtError", "${value.status!.message}")
              }
          });
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> updateTaskStatus(
      {required String newStatus, required String taskId}) async {
    try {
      await HomeHelper.getInstance.updateTaskStatus(body: {
        Constance.taskId: taskId,
        Constance.status: newStatus
      }).then((value) => {
            if (value.status!.success!)
              {
                snackSuccess(txtSuccess!.tr, value.status!.message!), Get.back()
                }
            else
              {
                snackError(txtSuccess!.tr, value.status!.message!)
                }
          });
    } catch (e) {
      printError();
    }
  }

  Future<void> changeBoxStatus() async {
    try {} catch (e) {
      printError();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getHomeTasks(taskType: Constance.inProgress);
    await getHomeTasks(taskType: Constance.done);
    await getEmergancy();
  }
}
