import 'package:inbox_driver/feature/model/home/emergencey/emergency_case.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/model/profile/log_model.dart';
import 'package:inbox_driver/network/api/model/app_response.dart';
import 'package:inbox_driver/network/api/model/home_api.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

import '../../../feature/model/notification/notification_model.dart';

class HomeHelper {
  HomeHelper._();
  static final HomeHelper getInstance = HomeHelper._();
  var log = Logger();

  //todo get Home Tasks For Driver From Api
  Future<List<TaskModel>> getHomeTasks(
      {required Map<String, dynamic> taskType}) async {
    try {
      var response = await HomeApi.getInstance.getHomeTasks(
          body: taskType,
          url: ConstanceNetwork.homeTasksEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        List data = response.data;
        return data.map((e) => TaskModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }

  //todo get Home Tasks For Driver From Api
  Future<List<TaskModel>> getLateTasksApi(
      {required Map<String, dynamic> taskDatae}) async {
    try {
      var response = await HomeApi.getInstance.getHomeTasks(
          body: taskDatae,
          url: ConstanceNetwork.getLateTasksApi,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        List data = response.data;
        return data.map((e) => TaskModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }

  Future<SalesData> getSpecificTask(
      {required Map<String, dynamic> taskId}) async {
    try {
      var response = await HomeApi.getInstance.getSpecificTask(
          body: taskId,
          url: ConstanceNetwork.getSpecificTask,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return SalesData.fromJson(response.data);
      } else {
        return SalesData.fromJson(response.data);
      }
    } catch (e) {
      log.d(e.toString());
      return SalesData.fromJson({});
    }
  }

  Future<AppResponse> scanBox({required var body}) async {
    try {
      var response = await HomeApi.getInstance.scanBox(
          body: body,
          url: ConstanceNetwork.scanBoxEndPoint,
          header: ConstanceNetwork.header(4));
      Logger().i(response.toJson());
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<List<EmergencyCase>> getEmergencyCasses() async {
    try {
      var response = await HomeApi.getInstance.getEmergencyCasses(
          url: ConstanceNetwork.getEmergencyCassesEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        List data = response.data;
        return data.map((e) => EmergencyCase.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }

  Future<AppResponse> createEmergencyReports({required var body}) async {
    try {
      var response = await HomeApi.getInstance.createEmergencyReports(
          body: body,
          url: ConstanceNetwork.sendEmergencyReportEndPoint,
          header: ConstanceNetwork.header(4));
      Logger().i(response.toJson());
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> reciveBoxess({required var body}) async {
    try {
      var response = await HomeApi.getInstance.reciveBoxess(
          body: body,
          url: ConstanceNetwork.reciveBoxessEndPoint,
          header: ConstanceNetwork.header(4));
      Logger().i(response.toJson());
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> updateTaskStatus({required var body}) async {
    try {
      var response = await HomeApi.getInstance.updateTaskStatus(
          body: body,
          url: ConstanceNetwork.updateBoxTaskEndpoint,
          header: ConstanceNetwork.header(4));
      Logger().i(response.toJson());
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<SalesData> search({required var body}) async {
    try {
      var response = await HomeApi.getInstance.search(
          body: body,
          url: ConstanceNetwork.searchEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return SalesData.fromJson(response.data);
      } else {
        return SalesData.fromJson(response.data);
      }
    } catch (e) {
      log.d(e.toString());
      return SalesData.fromJson({});
    }
  }

  Future<AppResponse> uploadCustomerId({required var body}) async {
    try {
      var response = await HomeApi.getInstance.uploadCustomerId(
          body: body,
          url: ConstanceNetwork.uploadCustomerId,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> scanSalesBox({required var body}) async {
    try {
      var response = await HomeApi.getInstance.scanSalesBox(
          body: body,
          url: ConstanceNetwork.scanSalesBoxEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> scanProduct({required var body}) async {
    try {
      var response = await HomeApi.getInstance.scanProduct(
          body: body,
          url: ConstanceNetwork.productScanEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> deleteProduct({required var body}) async {
    try {
      var response = await HomeApi.getInstance.deleteProduct(
          body: body,
          url: ConstanceNetwork.deleteProductEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> paymentRequest({required var body}) async {
    try {
      var response = await HomeApi.getInstance.paymentRequest(
          body: body,
          url: ConstanceNetwork.paymentRequestEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> checkTaskStatus({required var body}) async {
    try {
      var response = await HomeApi.getInstance.checkTaskStatus(
          body: body,
          url: ConstanceNetwork.checkTaskStatusEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> uploadCustomerSignature({required var body}) async {
    try {
      var response = await HomeApi.getInstance.uploadCustomerSignature(
          body: body,
          url: ConstanceNetwork.uploadCustomerSignatureEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> notifyForSign({required var body}) async {
    try {
      var response = await HomeApi.getInstance.uploadCustomerSignature(
          body: body,
          url: ConstanceNetwork.notifyForSignEndpoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> createNewSeal({required var body}) async {
    try {
      var response = await HomeApi.getInstance.createNewSeal(
          body: body,
          url: ConstanceNetwork.createNewSealEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> terminateBox({var body}) async {
    try {
      var response = await HomeApi.getInstance.terminateBox(
          body: body,
          url: ConstanceNetwork.terminateEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> scheduleBox({var body}) async {
    try {
      var response = await HomeApi.getInstance.scheduleBox(
          body: body,
          url: ConstanceNetwork.scheduleEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> createWaitingRequest({var body}) async {
    try {
      var response = await HomeApi.getInstance.createWaitingRequest(
          body: body,
          url: ConstanceNetwork.createWaitingRequestEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<List<NotificationModel>> getNotification() async {
    try {
      var response = await HomeApi.getInstance.getNotification(
          url: ConstanceNetwork.getNotificationsEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        List data = response.data;
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }

    Future<List<Log>> getLog() async {
    try {
      var response = await HomeApi.getInstance.getLog(
          url: ConstanceNetwork.getLogEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        List data = response.data;
        return data.map((e) => Log.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }

  Future<AppResponse> confirmTrasfare({var body}) async {
    try {
      var response = await HomeApi.getInstance.confirmTransfare(
          body: body,
          url: ConstanceNetwork.confirmTransactionEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

  Future<AppResponse> sendSmsMessageApi({var body}) async {
    try {
      var response = await HomeApi.getInstance.sendSmsMessageApi(
          body: body,
          url: ConstanceNetwork.sendSmsMessageApi,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }

}
