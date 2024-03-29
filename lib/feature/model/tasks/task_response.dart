// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import 'package:inbox_driver/feature/model/tasks/box_model.dart';

// TaskResponse taskResponseFromJson(String str) =>
//     TaskResponse.fromJson(json.decode(str));
//
// String taskResponseToJson(TaskResponse data) => json.encode(data.toJson());

// class TaskResponse {
//   TaskResponse(
//       {this.salesOrder,
//       this.isNew,
//       this.customerId,
//       this.childOrder,
//       this.total,
//       this.totalPaid,
//       this.totalDue,
//       this.paymentMethod,
//       this.boxes,
//       this.scannedBoxes,
//       this.customerScanned,
//       this.driverDelivered,
//       this.customerDelivered,
//       this.signatureType,
//       this.signatureFile,
//       this.processType,
//       this.driverToken,
//       this.taskStatus,
//         this.waitingTime = 0.0,
//         this.lateFees,
//       this.notificationId});
//
//   String? salesOrder;
//   bool? isNew;
//   String? customerId;
//   ChildOrder? childOrder;
//   num? total;
//   num? totalPaid;
//   num? totalDue;
//   String? paymentMethod;
//   List<BoxModel>? boxes;
//   List<BoxModel>? scannedBoxes;
//   List<BoxModel>? customerScanned;
//   List<BoxModel>? driverDelivered;
//   List<BoxModel>? customerDelivered;
//   String? signatureType;
//   dynamic signatureFile;
//   String? processType;
//   String? driverToken;
//   String? taskStatus;
//   String? notificationId;
//   num? waitingTime;
//   List<LateFees>? lateFees;
//
//   factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
//         salesOrder: json["sales_order"],
//         isNew: json["is_new"],
//         customerId: json["customer_id"],
//         childOrder: json["child_order"] == null ? null:ChildOrder.fromJson(json["child_order"]),
//         total: json["total"],
//         totalPaid: json["total_paid"],
//         totalDue: json["total_due"],
//         paymentMethod: json["payment_method"],
//         notificationId: json["id"],
//         boxes:json["boxes"] == null ? []: List<BoxModel>.from(json["boxes"].map((x) => BoxModel.fromJson(x))),
//         lateFees:json["late_fees"] == null ? [] : List<LateFees>.from(json["late_fees"].map((x) => LateFees.fromJson(x))),
//         scannedBoxes:json["scanned_boxes"] == null ? [] : List<BoxModel>.from(
//             json["scanned_boxes"].map((x) => BoxModel.fromJson(x))),
//         customerScanned:json["customer_scanned"] == null ? [] : List<BoxModel>.from(
//             json["customer_scanned"].map((x) => BoxModel.fromJson(x))),
//         driverDelivered:json["driver_delivered"] == null ? [] :  List<BoxModel>.from(
//             json["driver_delivered"].map((x) => BoxModel.fromJson(x))),
//         customerDelivered:json["customer_delivered"] == null ? [] :  List<BoxModel>.from(
//             json["customer_delivered"].map((x) => BoxModel.fromJson(x))),
//         signatureType: json["signature_type"],
//         signatureFile: json["signature_file"],
//         processType: json["process_type"],
//         driverToken: json["driver_token"],
//         taskStatus: json["task_status"],
//         waitingTime: json["waiting_time"]??0.0,
//       );
//
//   Map<String, dynamic> toJson() => {
//         "sales_order": salesOrder,
//         "is_new": isNew,
//         "customer_id": customerId,
//         "waiting_time": waitingTime ??0.0,
//         "child_order": childOrder,
//         "total": total,
//         "total_paid": totalPaid,
//         "total_due": totalDue,
//         "payment_method": paymentMethod,
//         "id": notificationId,
//         "boxes": boxes == null
//             ? []
//             : List<dynamic>.from(boxes!.map((x) => x.toJson())),
//         "scanned_boxes": scannedBoxes == null
//             ? []
//             : List<dynamic>.from(scannedBoxes!.map((x) => x.toJson())),
//         "customer_scanned": customerScanned == null
//             ? []
//             : List<dynamic>.from(customerScanned!.map((x) => x)),
//         "driver_delivered": driverDelivered == null
//             ? []
//             : List<dynamic>.from(driverDelivered!.map((x) => x)),
//         "customer_delivered": customerDelivered == null
//             ? []
//             : List<dynamic>.from(customerDelivered!.map((x) => x)),
//         "late_fees" : lateFees == null ? []:List<dynamic>.from(lateFees!.map((x) => x)),
//         "signature_type": signatureType,
//         "signature_file": signatureFile,
//         "process_type": processType,
//         "driver_token": driverToken,
//         "task_status": taskStatus,
//       };
// }
class TaskResponse {
  TaskResponse(
      {this.salesOrder,
      this.isNew = false,
      this.customerId,
      this.childOrder,
      this.total,
      this.totalPaid,
      this.totalDue,
      this.paymentMethod,
      this.boxes,
      this.scannedBoxes,
      this.customerScanned,
      this.driverDelivered,
      this.customerDelivered,
      this.signatureType,
      this.signatureFile,
      this.processType,
      this.driverToken,
      this.taskStatus,
      this.waitingTime = 0.0,
      this.lateFees,
      this.items,
      this.cancellationFees,
      this.hasDeliveredScan,
      this.taskId,
      this.hasTimeRequest,
      this.timer,
        this.verificationId,
      this.notificationId});

  String? salesOrder;
  String? verificationId;
  bool? isNew;
  String? taskId;
  String? customerId;
  ChildOrder? childOrder;
  num? total;
  num? totalPaid;
  num? totalDue;
  String? paymentMethod;
  List<BoxModel>? boxes;
  List<BoxModel>? scannedBoxes;
  List<BoxModel>? customerScanned;
  List<BoxModel>? driverDelivered;
  List<BoxModel>? customerDelivered;
  String? signatureType;
  dynamic signatureFile;
  String? processType;

  String? driverToken;
  String? taskStatus;
  String? notificationId;
  num? waitingTime;
  List<LateFees>? lateFees;
  List<FetchedItem>? items;
  num? cancellationFees;
  bool? hasTimeRequest;
  num? timer;
  bool? hasDeliveredScan;

  factory TaskResponse.fromJson(Map<String, dynamic> json,
      {required bool isFromNotification}) {
    if (isFromNotification) {
      return TaskResponse(
        salesOrder: json["sales_order"],
        isNew: json["is_new"] == "false" ? false : json["is_new"] == "true" ? true :false,
        hasDeliveredScan: json["has_delivered_scan"] == "false"
            ? false
            : json["has_delivered_scan"] == "true",
        hasTimeRequest: json["has_time_request"] == "false"
            ? false
            : json["has_time_request"] == "true"
                ? true
                : false,
        customerId: json["customer_id"],
        items: json["items"] == null || json["items"].isEmpty
            ? []
            : List<FetchedItem>.from(
                jsonDecode(json["items"]).map((x) => FetchedItem.fromJson(x))),
        childOrder: json["child_order"] == null
            ? null
            : ChildOrder.fromJson(jsonDecode(json["child_order"])),
        total: num.tryParse(json["total"].toString()),
        totalPaid: num.tryParse(json["total_paid"].toString()),
        totalDue: num.tryParse(json["total_due"].toString()),
        timer: num.tryParse(json["timer"].toString()),
        taskId: json["task_id"],
        paymentMethod: json["payment_method"],
        notificationId: json["id"],
        boxes: json["boxes"] == null || json["boxes"].isEmpty
            ? []
            : List<BoxModel>.from(
                    jsonDecode(json["boxes"]).map((x) => BoxModel.fromJson(x)))
                .toSet()
                .toList(),
        lateFees: json["late_fees"] == null || json["late_fees"].isEmpty
            ? []
            : List<LateFees>.from(jsonDecode(json["late_fees"])
                .map((x) => LateFees.fromJson(x))).toSet().toList(),
        scannedBoxes:
            json["scanned_boxes"] == null || json["scanned_boxes"].isEmpty
                ? []
                : List<BoxModel>.from(jsonDecode(json["scanned_boxes"])
                    .map((x) => BoxModel.fromJson(x))).toSet().toList(),
        customerScanned:
            json["customer_scanned"] == null || json["customer_scanned"].isEmpty
                ? []
                : List<BoxModel>.from(jsonDecode(json["customer_scanned"])
                    .map((x) => BoxModel.fromJson(x))).toSet().toList(),
        driverDelivered:
            json["driver_delivered"] == null || json["driver_delivered"].isEmpty
                ? []
                : List<BoxModel>.from(jsonDecode(json["driver_delivered"])
                    .map((x) => BoxModel.fromJson(x))).toSet().toList(),
        customerDelivered: json["customer_delivered"] == null ||
                json["customer_delivered"].isEmpty
            ? []
            : List<BoxModel>.from(jsonDecode(json["customer_delivered"])
                .map((x) => BoxModel.fromJson(x))).toSet().toList(),
        signatureType: json["signature_type"],
        verificationId: json["verification_id"]  == null   ? null:json["verification_id"],
        signatureFile: json["signature_file"],
        processType: json["process_type"],
        driverToken: json["driver_token"],
        taskStatus: json["task_status"],
        waitingTime: num.tryParse(json["waiting_time"].toString()) ?? 0.0,
        cancellationFees:
            num.tryParse(json["cancellation_fees"].toString()) ?? 0.0,
      );
    } else {
      return TaskResponse(
        salesOrder: json["sales_order"],
        isNew: json["is_new"] == null ? false : json["is_new"],
        hasDeliveredScan: json["has_delivered_scan"] == null
            ? null
            : json["has_delivered_scan"],
        hasTimeRequest:
            json["has_time_request"] == null ? null : json["has_time_request"],
        customerId: json["customer_id"],
        taskId: json["task_id"],
        verificationId: json["verification_id"]  == null   ? null:json["verification_id"],
        childOrder: json["child_order"] == null
            ? null
            : ChildOrder.fromJson(json["child_order"]),
        total: num.tryParse(json["total"].toString()),
        timer: num.tryParse(json["timer"].toString()),
        totalPaid: num.tryParse(json["total_paid"].toString()),
        totalDue: num.tryParse(json["total_due"].toString()),
        paymentMethod: json["payment_method"],
        items: json["items"] == null
            ? null
            : List<FetchedItem>.from(
                json["items"].map((x) => FetchedItem.fromJson(x))),
        notificationId: json["id"],
        boxes: json["boxes"] == null
            ? []
            : List<BoxModel>.from(
                json["boxes"].map((x) => BoxModel.fromJson(x))),
        lateFees: json["late_fees"] == null
            ? []
            : List<LateFees>.from(
                json["late_fees"].map((x) => LateFees.fromJson(x))),
        scannedBoxes: json["scanned_boxes"] == null
            ? []
            : List<BoxModel>.from(
                json["scanned_boxes"].map((x) => BoxModel.fromJson(x))),
        customerScanned: json["customer_scanned"] == null
            ? []
            : List<BoxModel>.from(
                json["customer_scanned"].map((x) => BoxModel.fromJson(x))),
        driverDelivered: json["driver_delivered"] == null
            ? []
            : List<BoxModel>.from(
                json["driver_delivered"].map((x) => BoxModel.fromJson(x))),
        customerDelivered: json["customer_delivered"] == null
            ? []
            : List<BoxModel>.from(
                json["customer_delivered"].map((x) => BoxModel.fromJson(x))),
        signatureType: json["signature_type"],
        signatureFile: json["signature_file"],
        processType: json["process_type"],
        driverToken: json["driver_token"],
        taskStatus: json["task_status"],
        waitingTime: num.tryParse(json["waiting_time"].toString()) ?? 0.0,
        cancellationFees:
            num.tryParse(json["cancellation_fees"].toString()) ?? 0.0,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "sales_order": salesOrder,
        "is_new": isNew,
        "customer_id": customerId,
        "verification_id":  verificationId,
        "waiting_time": waitingTime ?? 0.0,
        "child_order": childOrder,
        "total": total,
        "timer": timer,
        "total_paid": totalPaid,
        "total_due": totalDue,
        "payment_method": paymentMethod,
        "id": notificationId,
        "boxes": boxes == null
            ? []
            : List<dynamic>.from(boxes!.map((x) => x.toJson())),
        "scanned_boxes": scannedBoxes == null
            ? []
            : List<dynamic>.from(scannedBoxes!.map((x) => x.toJson())),
        "customer_scanned": customerScanned == null
            ? []
            : List<dynamic>.from(customerScanned!.map((x) => x)),
        "driver_delivered": driverDelivered == null
            ? []
            : List<dynamic>.from(driverDelivered!.map((x) => x)),
        "customer_delivered": customerDelivered == null
            ? []
            : List<dynamic>.from(customerDelivered!.map((x) => x)),
        "late_fees":
            lateFees == null ? [] : List<dynamic>.from(lateFees!.map((x) => x)),
        "signature_type": signatureType,
        "signature_file": signatureFile,
        "process_type": processType,
        "driver_token": driverToken,
        "task_status": taskStatus,
      };
}

class ChildOrder {
  ChildOrder({
    this.id,
    this.paymentMethod,
    this.items,
  });

  String? id;
  String? paymentMethod;
  List<Item>? items;

  factory ChildOrder.fromJson(Map<String, dynamic> json) => ChildOrder(
        id: json["id"],
        paymentMethod: json["payment_method"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_method": paymentMethod,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.product,
    this.name,
    this.price,
    this.qty,
    this.image,
  });

  String? product;
  String? name;
  num? price;
  num? qty;
  dynamic image;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: json["product"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "name": name,
        "price": price,
        "qty": qty,
        "image": image,
      };
}

class LateFees {
  LateFees({
    this.mFrom,
    this.mTo,
    this.fees,
  });

  int? mFrom;
  int? mTo;
  num? fees;

  factory LateFees.fromJson(Map<String, dynamic> json) => LateFees(
        mFrom: json["m_from"] == null ? null : json["m_from"],
        mTo: json["m_to"] == null ? null : json["m_to"],
        fees: json["fees"] == null ? null : json["fees"],
      );

  Map<String, dynamic> toJson() => {
        "m_from": mFrom == null ? null : mFrom,
        "m_to": mTo == null ? null : mTo,
        "fees": fees == null ? null : fees,
      };
}

class FetchedItem {
  FetchedItem({
    this.id,
    this.itemName,
    this.itemGallery,
  });

  String? id;
  String? itemName;
  List<dynamic>? itemGallery;

  factory FetchedItem.fromJson(Map<String, dynamic> json) => FetchedItem(
        id: json["id"],
        itemName: json["item_name"],
        itemGallery: json["item_gallery"] == null
            ? []
            : List<dynamic>.from(json["item_gallery"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "item_gallery": itemGallery == null
            ? []
            : List<dynamic>.from(itemGallery!.map((x) => x)),
      };
}
