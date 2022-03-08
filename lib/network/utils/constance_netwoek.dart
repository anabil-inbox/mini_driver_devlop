import 'package:get/get.dart';
import 'package:inbox_driver/util/sh_util.dart';

abstract class ConstanceNetwork {
  ///todo here insert base_url
  static String imageUrl = "http://50.17.152.72".trim();

  ///todo here insert key Of Request

  ///todo this for login request user
  static var contryCodeKey = "country_code";
  static var mobileKey = "mobile";
  static var udidKey = "udid";
  static var deviceTypeKey = "device_type";
  static var fcmKey = "fcm";
  static var emailKey = "email";

  //todo user status : 
  static String userEnterd = "enterd";
    static String userLoginedState = "logined";


  ///todo this for add new contact key
  static var mobileNumberKey = "mobile_number";
  static var countryCodeKey = "country_code";



  ///todo here insert end Point

  static String settingeEndPoint = "inbox_app.api.settings.api_settings";

  static String featureEndPoint = "inbox_app.api.settings.features";

  static String countryEndPoint = "inbox_app.api.settings.countries";

  static String loginEndPoint = "inbox_app.driver.auth.login";

  static String verficationEndPoint = "inbox_app.driver.auth.verfiy";

  static String recendVerficationCodeEndPoint = "inbox_app.driver.auth.resend_code";
  
  static String editProfilEndPoint = "inbox_app.driver.auth.edit_profile";

  static String logOutEndPoint = "inbox_app.driver.auth.logout";



  // to add here Home End Points ::
  static String homeTasksEndPoint = "inbox_app.driver.task_management.get_level_one_tasks";
  static String getSpecificTask = "inbox_app.driver.task_management.get_level_one_task";
  static String scanBoxEndPoint = "inbox_app.driver.task_management.scan_box";

  // to add here emergency End Points ::
  static String getEmergencyCassesEndPoint = "inbox_app.driver.emergency_report.get_emergency_cases";
  static String sendEmergencyReportEndPoint = "inbox_app.driver.emergency_report.create_report";
  static String getEmergencyReportsEndPoint = "inbox_app.driver.emergency_report.get_emergency_reports";

  static String reciveBoxessEndPoint = "inbox_app.driver.task_management.receive_all_boxes";
  static String updateBoxTaskEndpoint = "inbox_app.driver.task_management.update_task_status";
  static String searchEndPoint = "inbox_app.driver.task_management.search_tasks";

  // todo Add scan_sales_box ENd points ::

  static String scanSalesBoxEndPoint = "inbox_app.driver.task_management.scan_sales_box";
  static String productScanEndPoint = "inbox_app.driver.task_management.scan_product";
  static String deleteProductEndPoint = "inbox_app.driver.task_management.delete_product";
  static String paymentRequestEndPoint = "inbox_app.driver.task_management.notify_customer_to_pay";
  // todo for task status:: 

  static String checkTaskStatusEndPoint = "inbox_app.driver.task_management.check_task_status";

  // to do here for User Uploads Certificates :
  static String uploadCustomerId = "inbox_app.driver.task_management.attach_id";
  static String uploadCustomerSignatureEndPoint = "inbox_app.driver.task_management.upload_customer_singnature";
  static String notifyForSignEndpoint = "inbox_app.driver.task_management.notify_customer_sign_side"; 
  
  static Map<String, String> header(int typeToken) {
    Map<String, String> headers = {};
    if (typeToken == 0) {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
      };
    } else if (typeToken == 1) {
      headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
    } else if (typeToken == 2) {
      headers = {
        //    'Authorization': '${SharedPref.instance.getToken().toString()}',
      };
    } else if (typeToken == 3) {
      headers = {
        //  'Authorization': '${SharedPref.instance.getToken().toString()}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
    } else if (typeToken == 4) {
      headers = {
        'Authorization': 'Bearer ${SharedPref.instance.getUserToken()}',
        'Content-Type': 'application/json',
        'Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    }

    return headers;
  }
}
