import 'package:inbox_driver/feature/model/home/sales_order.dart';

class SalesData {
  SalesData({this.taskName,
      this.totalBoxes,
      this.totalReceived,
      this.lastUpdate,
      this.salesOrders,
      this.longtuide,
      this.latituide});

  String? taskName;
  num? totalBoxes;
  num? totalReceived;
  DateTime? lastUpdate;
  List<SalesOrder>? salesOrders;
  double? longtuide;
  double? latituide;

  factory SalesData.fromJson(Map<String, dynamic> json) => SalesData(
      taskName: json["task_name"],
      totalBoxes: json["total_boxes"] ?? 0,
      totalReceived: json["total_received"] ?? 0,
      lastUpdate: DateTime.parse(json["last_update"]),
      longtuide: json["longitude"],
      latituide: json["latitude"],
      salesOrders: json["Sales Orders"] == null
          ? []
          : List<SalesOrder>.from(
              json["Sales Orders"].map((x) => SalesOrder.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "task_name": taskName,
        "total_boxes": totalBoxes,
        "total_received": totalReceived,
        "longtuide": longtuide,
        "latituide": latituide,
        "Sales Orders":
            List<SalesOrder>.from(salesOrders!.map((x) => x.toJson())),
        "last_update":
            "${lastUpdate?.year.toString().padLeft(4, '0')}-${lastUpdate?.month.toString().padLeft(2, '0')}-${lastUpdate?.day.toString().padLeft(2, '0')}",
      };
}
