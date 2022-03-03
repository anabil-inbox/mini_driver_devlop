// class TaskResponse {
//   TaskResponse(
//       {this.isNew,
//       this.customerId,
//       this.total,
//       this.totalPaid,
//       this.totalDue,
//       this.paymentMethod,
//       this.salesOrder,
//       this.proccessType});

//   bool? isNew;
//   String? customerId;
//   num? total;
//   num? totalPaid;
//   num? totalDue;
//   String? paymentMethod;
//   String? proccessType;
//   String? salesOrder;

//   factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
//         isNew: json["is_new"],
//         customerId: json["customer_id"],
//         total: json["total"],
//         salesOrder: json["sales_order"],
//         proccessType: json["process_type"],
//         paymentMethod: json["payment_method"],
//         totalPaid: json["total_paid"],
//         totalDue: json["total_due"],
//       );

//   Map<String, dynamic> toJson() => {
//         "is_new": isNew,
//         "customer_id": customerId,
//         "process_type": proccessType,
//         "total": total,
//         "sales_order": salesOrder,
//         "payment_method": paymentMethod,
//         "total_paid": totalPaid,
//         "total_due": totalDue,
//       };
// }

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

class TaskResponse {
  TaskResponse({
    this.childOrderId,
    this.productCode,
    this.qty,
    this.productPrice,
    this.productImage,
    this.salesOrder,
    this.isNew,
    this.customerId,
    this.processType,
    this.paymentMethod,
    this.childOrder,
    this.total,
    this.totalPaid,
    this.totalDue,
  });

  String? childOrderId;
  String? productCode;
  num? qty;
  num? productPrice;
  dynamic productImage;
  String? salesOrder;
  bool? isNew;
  String? customerId;
  String? processType;
  String? paymentMethod;
  ChildOrder? childOrder;
  num? total;
  num? totalPaid;
  num? totalDue;

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
        childOrderId: json["child_order_id"],
        productCode: json["product_code"],
        qty: json["qty"],
        productPrice: json["product_price"],
        productImage: json["product_image"],
        salesOrder: json["sales_order"],
        isNew: json["is_new"],
        customerId: json["customer_id"],
        processType: json["process_type"],
        paymentMethod: json["payment_method"],
        childOrder: json["child_order"] == null
            ? ChildOrder(items: [])
            : ChildOrder.fromJson(json["child_order"]),
        total: json["total"],
        totalPaid: json["total_paid"],
        totalDue: json["total_due"],
      );

  Map<String, dynamic> toJson() => {
        "child_order_id": childOrderId == null ? null: childOrderId,
        "product_code": productCode == null ? null: productCode,
        "qty": qty == null ? null: qty,
        "product_price": productPrice == null ? null: productPrice,
        "product_image": productImage == null ? null: productImage,
        "sales_order": salesOrder == null ? null: salesOrder,
        "is_new": isNew == null ? null: isNew,
        "customer_id": customerId == null ? null: customerId,
        "process_type": processType == null ? null: processType,
        "payment_method": paymentMethod == null ? null: paymentMethod,
        "child_order":  childOrder == null ? null:childOrder?.toJson(),
        "total": total == null ? null: total,
        "total_paid": totalPaid == null ? null: totalPaid,
        "total_due": totalDue == null ? null: totalDue,
      };
}

class ChildOrder {
  ChildOrder({
    this.id,
    this.items,
  });

  String? id;
  List<Item>? items;

  factory ChildOrder.fromJson(Map<String, dynamic> json) => ChildOrder(
        id: json["id"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id":id == null ? null:  id,
        "items":items == null ? null:  List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.product,
    this.name,
    this.price,
    this.qty,
  });

  String? product;
  String? name;
  num? price;
  num? qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: json["product"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "name": name,
        "price": price,
        "qty": qty,
      };
}
