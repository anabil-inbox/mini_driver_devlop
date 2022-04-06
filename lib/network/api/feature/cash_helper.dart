import 'package:inbox_driver/feature/model/profile/cash_closer_data.dart';
import 'package:inbox_driver/network/api/model/app_response.dart';
import 'package:inbox_driver/network/api/model/cach_model.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class CashCloserFeature {
  CashCloserFeature._();

  static final CashCloserFeature getInstance = CashCloserFeature._();
  var log = Logger();

  //todo get Feature From Api
  Future<List<CashCloserData>> getCashCloser() async {
    try {
      var response = await CashModel.getInstance.getCashCloser(
        url: ConstanceNetwork.getCashRequestApi,
        header:
            ConstanceNetwork.header(4), /* queryParameters: queryParameters */
      );
      if (response.status?.success == true) {
        List data = response.data;
        return data.map((e) => CashCloserData.fromJson(e)).toSet().toList();
      } else {
        return [];
      }
    } catch (e) {
      log.d(e.toString());
      return [];
    }
  }

  Future<AppResponse> applyCashCloser(var body) async {
    try {
      var response = await CashModel.getInstance.applyCashCloser(
        body:body,
        url: ConstanceNetwork.getCashRequestApi,
        header: ConstanceNetwork.header(4), /* queryParameters: queryParameters */
      );
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
