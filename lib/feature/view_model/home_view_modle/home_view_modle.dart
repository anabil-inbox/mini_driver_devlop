import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as multipart;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_driver/feature/model/app_setting_modle.dart';
import 'package:inbox_driver/feature/model/home/emergencey/emergency_case.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/model/signature_item_model.dart';
import 'package:inbox_driver/feature/model/tasks/box_model.dart';
import 'package:inbox_driver/feature/model/tasks/task_response.dart';
import 'package:inbox_driver/feature/view/screens/home/Widgets/secondery_button.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/instant_order_screen.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/qty_bottom_sheet.dart';
import 'package:inbox_driver/network/api/feature/home_helper.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeViewModel extends GetxController {
  bool isSelected = true;

  int selectedTab = 0;

  BoxOperation? selectedBoxOperation;

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
      {bool? isFromAtHome,
      int? index,
      TaskModel? taskModel,
      required bool isProductScan,
      required bool isScanDeliverdBoxes,
      required bool isFromScanSalesBoxs}) {
    try {
      int i = 0;
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        result = scanData;
      }).onData((data) async {
        i = i + 1;
        if (i == 1) {
          if (isFromScanSalesBoxs) {
            await scanBoxOrder(
              isFromScanedDeliverd: isScanDeliverdBoxes,
              serial: data.code ?? "",
            );
            Get.back();
          } else if (isProductScan) {
            await scanProudct(productCode: data.code ?? "");
            tdQty.clear();
            Get.close(2);
          } else {
            await scanBox(
              serial: data.code ?? "",
              taskName: operationsSalesData?.taskName ?? "",
            );
            Get.back();
            await getSpecificTask(
                taskId: taskModel?.id ?? "", taskSatus: Constance.inProgress);
            await getSpecificTask(
                taskId: taskModel?.id ?? "", taskSatus: Constance.done);
          }
        }
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
  SalesData? operationsSalesDataCompleted;

  Future<void> getSpecificTask(
      {required String taskId, required String taskSatus}) async {
    if (taskSatus == Constance.inProgress) {
      operationsSalesData = SalesData();
    } else {
      operationsSalesDataCompleted = SalesData();
    }
    try {
      startLoading();
      await HomeHelper.getInstance.getSpecificTask(taskId: {
        Constance.taskId: taskId,
        Constance.status: taskSatus
      }).then((value) => {
            if (taskSatus == Constance.inProgress)
              {
                operationsSalesData = value,
                update(),
              }
            else
              {
                operationsSalesDataCompleted = value,
                update(),
              }
          });
    } catch (e) {
      endLoading();
      printError();
    }
    endLoading();
  }

  SalesData? completedSalesData;

  Future<void> getSpecificCompleted(
      {required String taskId, required String taskSatus}) async {
    completedSalesData = SalesData();
    try {
      startLoading();
      await HomeHelper.getInstance.getSpecificTask(taskId: {
        Constance.taskId: taskId,
        Constance.status: taskSatus
      }).then((value) => {
            completedSalesData = value,
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
      }).then((value) async => {
            if (value.status!.success!)
              {
                operationsSalesData?.totalReceived =
                    (operationsSalesData?.totalReceived ?? 0) + 1,
                await refrshHome(),
                update(),
                snackSuccess("$txtSuccess", "${value.status!.message}")
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

  Future getImage(ImageSource source,
      {String? customerId, String? taskId}) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      img = File(pickedImage.path);
      update();
    }

    if (customerId != null && pickedImage != null) {
      await uploadVerficationId(customerId: customerId, taskId: taskId ?? "");
    }
  }

  Future<void> uploadVerficationId(
      {required String customerId, required String taskId}) async {
    startLoading();
    try {
      if (img != null) {
        img = await compressImage(img!);
      }
      HomeHelper.getInstance.uploadCustomerId(body: {
        "image":
            img != null ? multipart.MultipartFile.fromFileSync(img!.path) : "",
        "customer": customerId,
        "task_id": taskId,
      }).then((value) => {
            if (value.status!.success!)
              {
                operationTask = TaskResponse.fromJson(value.data),
                waiteTimeOperation = Duration(minutes: operationTask.waitingTime?.toInt() ?? 0),
                snackSuccess(txtSuccess!.tr, value.status!.message!)
              }
            else
              {snackError(txtSuccess!.tr, value.status!.message!)}
          });
    } catch (e) {
      printError();
    }
    endLoading();
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
      await HomeHelper.getInstance.reciveBoxess(body: {
        "id": serial,
        Constance.taskName: taskName
      }).then((value) => {
            if (value.status!.success!)
              {
                operationsSalesData?.totalReceived =
                    (operationsSalesData?.totalReceived ?? 0) +
                        num.parse(value.data["box_received_count"].toString()),
                snackSuccess(txtSuccess!.tr, value.status!.message!),
                update()
              }
            else
              {
                Logger().i(value.toJson()),
                snackError("$txtError", "${value.status!.message}"),
                update()
              }
          });
    } catch (e) {
      printError();
    }
    await refrshHome();
    update();
    endLoading();
  }

  // to do for Refrsh Home Task:
  Future<void> refrshHome() async {
    try {
      tasksInProgress.clear();
      tasksDone.clear();
      await getHomeTasks(taskType: Constance.inProgress);
      await getHomeTasks(taskType: Constance.done);
    } catch (e) {
      printError();
    }
  }

  Future<void> updateTaskStatus(
      {required String newStatus,
      required String taskId,
      required String taskStatusId}) async {
    try {
      startLoading();
      await HomeHelper.getInstance.updateTaskStatus(body: {
        Constance.taskId: taskId,
        Constance.status: newStatus
      }).then((value) => {
            if (value.status!.success!)
              {
                snackSuccess(txtSuccess!.tr, value.status!.message!),

                operationsSalesData?.salesOrders?.forEach((element) {
                  if (element.taskId == taskId) {
                    element.taskStatus = newStatus;
                  }
                }),
                if (newStatus == Constance.taskdelivered)
                  {
                    // SharedPref.instance.setCurrentTaskResponse(
                    //     taskResponse: jsonEncode(value.data)),
                    // operationTask =
                    Get.to(() => InstantOrderScreen(
                        taskStatusId: taskStatusId,
                        isNewCustomer: true,
                        taskId: taskId))
                  },
                // else if (newStatus == Constance.taskDone)
                //   {

                //   },

                update(),
                endLoading(),
                if (newStatus == Constance.done)
                  {
                    Get.close(2),
                  },
                // operationsSalesData.
              }
            else
              {snackError(txtSuccess!.tr, value.status!.message!), endLoading()}
          });
    } catch (e) {
      endLoading();
      printError();
    }
  }

  TextEditingController tdSearchWhLoading = TextEditingController();
  TextEditingController tdSearchHome = TextEditingController();

  search({required String searchedText, required String taskId}) async {
    try {
      HomeHelper.getInstance.search(body: {
        "task_id": taskId,
        "search": searchedText,
      }).then((value) => {operationsSalesData = value, update()});
    } catch (e) {
      printError();
    }
  }

  // to check if Task Type if Task Warwhouse Loading Or WareHouse Clouser :
  bool isTaskWarwhouseLoadingOrClousre({required TaskModel task}) {
    if (task.taskName!
            .toLowerCase()
            .contains(Constance.taskWarehouseLoading.toLowerCase()) ||
        task.taskName!
            .toLowerCase()
            .contains(Constance.taskWarehouseClosure.toLowerCase())) {
      return true;
    }
    return false;
  }

  bool isTaskCustomerVist({required TaskModel task}) {
    if (task.taskName!
        .toLowerCase()
        .contains(Constance.taskCustomerVisit.toLowerCase())) {
      return true;
    }
    return false;
  }

  bool isTaskWorahouseClousre({required TaskModel task}) {
    if (task.taskName!
        .toLowerCase()
        .contains(Constance.taskWarehouseClosure.toLowerCase())) {
      return true;
    }
    return false;
  }

  bool isTaskWareHouseLoading({required TaskModel task}) {
    if (task.taskName!
        .toLowerCase()
        .contains(Constance.taskWarehouseLoading.toLowerCase())) {
      return true;
    }
    return false;
  }

  bool isTask({required String orderItem}) {
    if (orderItem == Constance.destroyId ||
        orderItem == Constance.terminateId ||
        orderItem == Constance.pickupId ||
        orderItem == Constance.giveawayId ||
        orderItem == Constance.fetchId) {
      return true;
    }
    return false;
  }

// todo Here for count down timer ;
  ApiSettings settings =
      ApiSettings.fromJson(json.decode(SharedPref.instance.getAppSetting()));

  Timer? _timer;
  int start = 200;

  void startTimer() {
    // if (SharedPref.instance.getIsStartedTimerKey()) {
    //   // to do here change start Value With Saved in Shared Preferace Value
    //   start = SharedPref.instance.getTimerValue();
    // } else {
    //   start = settings.waitingTime ?? 10;
    // }

    if (_timer?.isActive ?? false) {
    } else {
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (start == 0) {
            timer.cancel();
          } else {
            start--;
          }
          SharedPref.instance.setTimeValue(timerNewValue: start * 60);
          update();
        },
      );
    }
  }

  Duration wateTime = const Duration();
  Duration waiteTimeOperation = const Duration();

  @override
  void onInit() async {
    super.onInit();
    await getHomeTasks(taskType: Constance.inProgress);
    await getHomeTasks(taskType: Constance.done);
    await getEmergancy();
    wateTime = Duration(minutes: settings.waitingTime ?? 9);
    //wateTime =
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  TaskResponse operationTask = TaskResponse();

  // Set<BoxModel> scaanedBoxes = SharedPref.instance.getBoxesList().toSet();
  // List<ProductModel> scaanedProducts = [];

  Future<void> scanBoxOrder(
      {required String serial, required bool isFromScanedDeliverd}) async {
    await HomeHelper.getInstance
        .scanSalesBox(body: {
          Constance.serial: serial,
          "sales_order": operationTask.salesOrder ?? ""
        })
        .then((value) async => {
              if (value.status!.success!)
                {
                  if (isFromScanedDeliverd)
                    {
                      operationTask.driverDelivered
                          ?.add(BoxModel.fromJson(value.data))
                    }
                  else
                    {
                      operationTask.scannedBoxes
                          ?.add(BoxModel.fromJson(value.data)),
                    },
                  await refrshHome(),
                  update(),
                  snackSuccess("$txtSuccess", "${value.status!.message}")
                }
              else
                {
                  Logger().i(value.toJson()),
                  snackError("$txtError", "${value.status!.message}"),
                }
            })
        .catchError((e) {
          Logger().i(e);
          snackError("$txtError", "$e");
        });
  }

  final tdQty = TextEditingController();

  Future<void> scanProudct({required String productCode}) async {
    await HomeHelper.getInstance.scanProduct(body: {
      Constance.productCode: productCode,
      Constance.qty: tdQty.text,
      Constance.size: operationTask.childOrder!.items!.isEmpty
          ? 1
          : operationTask.childOrder!.items!.length + 1,
      "sales_order": operationTask.childOrder!.items!.isNotEmpty
          ? operationTask.childOrder!.id
          : operationTask.salesOrder ?? ""
    }).then((value) async => {
          if (value.status!.success!)
            {
              operationTask = TaskResponse.fromJson(value.data),
              waiteTimeOperation = Duration(minutes: operationTask.waitingTime?.toInt() ?? 0),
              Logger().e(value.data),
              await refrshHome(),
              update(),
              snackSuccess("$txtSuccess", "${value.status!.message}")
            }
          else
            {
              Logger().i(value.toJson()),
              snackError("$txtError", "${value.status!.message}")
            }
        });
  }

  Future showQtyBottomSheet() async {
    Get.bottomSheet(QtyBottomSheet(), isScrollControlled: true);
  }

  List<String> deletedElements = [];

  Future<void> deleteProduct(
      {required Item productModel, required int index}) async {
    try {
      await HomeHelper.getInstance.deleteProduct(body: {
        "sales_order": operationTask.childOrder?.id,
        "product_code": productModel.product,
      }).then((value) async {
        if (value.status!.success!) {
          deletedElements.add("${productModel.name}$index");
          Logger().i(value.toJson());
          // TaskResponse taskResponse =
          //     SharedPref.instance.getCurrentTaskResponse() ??
          //         TaskResponse(childOrder: ChildOrder(items: []));
          // taskResponse.childOrder!.items?.remove(productModel);
          operationTask = TaskResponse.fromJson(value.data);
          waiteTimeOperation = Duration(minutes: operationTask.waitingTime?.toInt() ?? 0);
          update();
          snackSuccess("$txtSuccess", "${value.status!.message}");
        } else {
          Logger().i(value.toJson());
          snackError("$txtError", "${value.status!.message}");
        }
      });
    } catch (e) {
      printError();
    }
  }

  Future<void> sendPaymentRequest() async {
    try {
      await HomeHelper.getInstance.paymentRequest(body: {
        Constance.id: operationTask.childOrder?.id
      }).then((value) => {
            if (value.status!.success!)
              {
                snackSuccess("$txtSuccess", "${value.status!.message}"),
              }
            else
              {
                snackError("$txtError", "${value.status!.message}"),
              }
          });
    } catch (e) {
      printError();
    }
  }

  Future<void> checkTaskStatus({required String taskId}) async {
    try {
      startLoading();
      await HomeHelper.getInstance
          .checkTaskStatus(body: {Constance.taskId: taskId}).then((value) => {
                operationTask = TaskResponse.fromJson(value.data),
                waiteTimeOperation = Duration(minutes: operationTask.waitingTime?.toInt() ?? 0),
              });
    } catch (e) {
      endLoading();
      Logger().e(e);
    }
    endLoading();
  }

  // to do here for signature code
  SignatureItemModel selectedSignatureItemModel = SignatureItemModel();
  dynamic signatureOutput;

  Future<void> uploadCustomerSignature() async {
    Uint8List imageInUnit8List = signatureOutput;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);

    try {
      await HomeHelper.getInstance.uploadCustomerSignature(body: {
        Constance.salesOrderUnderScoure: operationTask.salesOrder ?? "",
        Constance.image: multipart.MultipartFile.fromFileSync(file.path)
      }).then((value) => {
            if (value.status!.success!)
              {
                snackSuccess("$txtSuccess", "${value.status!.message}"),
              }
            else
              {
                snackError("$txtError", "${value.status!.message}"),
              }
          });
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> notifyForSign({required String type}) async {
    try {
      await HomeHelper.getInstance.notifyForSign(body: {
        Constance.id: operationTask.salesOrder ?? "",
        Constance.type: type
      }).then((value) => {
            if (value.status!.success!)
              {
                operationTask = TaskResponse.fromJson(value.data),
                waiteTimeOperation = Duration(minutes: operationTask.waitingTime?.toInt() ?? 0),
                snackSuccess("$txtSuccess", "${value.status!.message}"),
              }
            else
              {
                snackError("$txtError", "${value.status!.message}"),
              }
          });
    } catch (e) {
      printError();
    }
  }

  final tdBoxOperaion = TextEditingController();
  final tdNewSeal = TextEditingController();

  Future<void> createNewSeal(
      {required String serial, required String newSeal}) async {
    try {
      await HomeHelper.getInstance.createNewSeal(body: {
        Constance.serial: serial,
        Constance.newSeal: newSeal
      }).then((value) => {
            if (value.status!.success!)
              {
                snackSuccess("$txtSuccess", "${value.status!.message}"),
              }
            else
              {
                snackError("$txtError", "${value.status!.message}"),
              }
          });
    } catch (e) {
      printError();
    }
  }

  @override
  void onClose() {
    super.onClose();
    
  }
}
