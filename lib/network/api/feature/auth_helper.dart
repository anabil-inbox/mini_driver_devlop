
import 'package:inbox_driver/network/api/model/app_response.dart';
import 'package:inbox_driver/network/api/model/auth.dart';
import 'package:inbox_driver/network/utils/constance_netwoek.dart';
import 'package:logger/logger.dart';

class AuthHelper {

  AuthHelper._();
  static final AuthHelper getInstance = AuthHelper._();
   Logger log = Logger();

  Future<AppResponse> loginUser(var body) async {
    var appResponse = await AuthApi.getInstance.loginRequest(body: body,url: ConstanceNetwork.loginEndPoint ,header: ConstanceNetwork.header(0));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }


  // Future<AppResponse> registerUser(Map<String , dynamic> body) async{ 
  //   var appResponse = await AuthApi.getInstance.signUpRequest(body: body,url: "${ConstanceNetwork.registerUser}" , header: ConstanceNetwork.header(0));
  //   if(appResponse.status?.success == true){
  //       return appResponse;
  //   }else{
  //       return appResponse;
  //   }
  
  // }

  Future<AppResponse> checkVerficationCode(Map<String, dynamic> body) async {
    var appResponse = await AuthApi.getInstance.checkVerficationCodeRequset(body: body, url: ConstanceNetwork.verficationEndPoint,header: ConstanceNetwork.header(0));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }
  

  Future<AppResponse> reSendVerficationCode(Map<String, dynamic> body) async {
    var appResponse = await AuthApi.getInstance.reSendVerficationCodeRequset(body: body, url: ConstanceNetwork.recendVerficationCodeEndPoint,header: ConstanceNetwork.header(0));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }
  
}

