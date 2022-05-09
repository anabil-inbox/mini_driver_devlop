// ignore_for_file: prefer_if_null_operators

import 'package:get/utils.dart';
import 'package:logger/logger.dart';

class AppResponse {
  Status? status;
  dynamic data;

  AppResponse({this.status, this.data});

  factory AppResponse.fromJson(var map) {
    try {
      if (map["exception"] != null) {
        return AppResponse(
          data: "",
          status: Status(code: 401, message: "Error accoured", success: false),
        );
      } else if (GetUtils.isNull(map["data"])) {
        return AppResponse(
          status: Status.fromJson(map["status"]),
        );
      } else {
        return AppResponse(
          status: Status.fromJson(map["status"]),
          data: map["data"] == null ? null : map["data"],
        );
      }
    } catch (e) {
      return AppResponse(
          status: Status(
        message: "$e",
        code: 403,
        success: false,
      ));
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {"status": status?.toJson(), "data": data};
    } catch (e) {
      Logger().e(e);
      return {"": ""};
    }
  }
}

class Status {
  Status({
    this.message,
    this.code,
    this.success,
  });

  dynamic message;
  int? code;
  bool? success;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        message: json["message"].toString(),
        code: json["code"] ?? 0,
        success: json["success"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "message": message ?? "",
        "code": code ?? 0,
        "success": success ?? false,
      };
}
