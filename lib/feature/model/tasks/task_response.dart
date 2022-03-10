import 'package:inbox_driver/feature/model/tasks/box_model.dart';

class TaskResponse {
  TaskResponse(
      {this.salesOrder,
      this.isNew,
      this.customerId,
      this.processType,
      this.paymentMethod,
      this.childOrder,
      this.total,
      this.totalPaid,
      this.totalDue,
      this.type,
      this.signatureFile,
      this.signatureType,
      this.boxes,
      this.notificationId});

  String? salesOrder;
  bool? isNew;
  String? customerId;
  String? processType;
  String? paymentMethod;
  ChildOrder? childOrder;
  String? signatureType;
  String? signatureFile;
  num? total;
  dynamic totalPaid;
  List<BoxModel>? boxes;
  num? totalDue;
  String? notificationId;
  String? type;

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
      salesOrder: json["sales_order"],
      isNew: json["is_new"] is String && json["is_new"] == "false"
          ? false
          : json["is_new"] is String && json["is_new"] == "true"
              ? true
              : false,
      type: json["type"],
      customerId: json["customer_id"],
      processType: json["process_type"],
      paymentMethod: json["payment_method"],
      signatureType: json["signature_type"],
      signatureFile: json["signature_file"],
      boxes: [],
      // boxes: json["boxes"] == null
      //     ? []
      //     : List<BoxModel>.from(json["boxes"].map((x) => BoxModel.fromJson(jsonDecode(x)))),
      childOrder: json["child_order"] == null
          ? ChildOrder(items: [])
          : ChildOrder.fromJson(json["child_order"]),
      total: num.tryParse(json["total"].toString()),
      totalPaid: num.tryParse(json["total_paid"].toString()),
      totalDue: num.tryParse(json["total_due"].toString()),
      notificationId: json["id"].toString());

  Map<String, dynamic> toJson() => {
        "sales_order": salesOrder,
        "is_new": isNew,
        "customer_id": customerId,
        "process_type": processType,
        "payment_method": paymentMethod,
        "child_order": childOrder?.toJson(),
        "total": total.toString(),
        "total_paid": totalPaid.toString(),
        "total_due": totalDue.toString(),
        "type": type,
        "boxes" : [],
        "notificationId": notificationId.toString()
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
