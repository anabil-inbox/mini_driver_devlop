import 'package:inbox_driver/feature/model/home/Task_model.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/network/api/model/app_response.dart';
import 'package:inbox_driver/network/api/model/home_api.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:logger/logger.dart';

class HomeHelper {
  HomeHelper._();
  static final HomeHelper getInstance = HomeHelper._();
  var log = Logger();

  //todo get Home Tasks For Driver From Api
  Future<List<Task>> getHomeTasks(
      {required Map<String, dynamic> taskType}) async {
    try {
      var response = await HomeApi.getInstance.getHomeTasks(
          body: taskType,
          url: ConstanceNetwork.homeTasksEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        List data = response.data;
        return data.map((e) => Task.fromJson(e)).toList();
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

  Future<AppResponse> scanBox({required Map<String, dynamic> body}) async {
    try {
      var response = await HomeApi.getInstance.scanBox(
          body: body,
          url: ConstanceNetwork.scanBoxEndPoint,
          header: ConstanceNetwork.header(4));
      if (response.status?.success == true) {
        return AppResponse.fromJson(response.data);
      } else {
        return AppResponse.fromJson(response.data);
      }
    } catch (e) {
      log.d(e.toString());
      return AppResponse.fromJson({});
    }
  }
}
