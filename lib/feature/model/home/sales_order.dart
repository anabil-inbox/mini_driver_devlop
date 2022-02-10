// ignore_for_file: prefer_if_null_operators

class SalesOrder {
  SalesOrder(
      {this.orderId,
      this.taskId,
      this.contentStatus,
      this.customerId,
      this.customerMobile,
      this.orderType,
      this.totalPrice,
      this.orderShippingAddress,
      this.orderWarehouseAddress,
      this.deliveryDate,
      this.status,
      this.totalBoxes,
      this.totalReceived,
      this.orderDoc,
      this.orderItems,
      this.taskStatus,
      this.latituide,
      this.longitude});

  String? orderId;
  String? taskId;
  String? contentStatus;
  String? customerId;
  dynamic customerMobile;
  String? taskStatus;
  String? orderType;
  num? totalPrice;
  String? orderShippingAddress;
  dynamic orderWarehouseAddress;
  DateTime? deliveryDate;
  String? status;
  num? totalBoxes;
  num? totalReceived;
  String? orderDoc;
  List<OrderItem>? orderItems;
  double? latituide;
  double? longitude;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        orderId: json["order_id"],
        taskId: json["task_id"],
        contentStatus: json["content_status"],
        customerId: json["customer_id"],
        customerMobile: json["customer_mobile"],
        longitude: json["longitude"],
        latituide: json["latitude"],
        orderType: json["order_type"],
        totalPrice: json["total_price"],
        taskStatus: json["task_status"].toString().toLowerCase(),
        orderShippingAddress: json["order_shipping_address"],
        orderWarehouseAddress: json["order_warehouse_address"],
        deliveryDate: DateTime.parse(json["delivery_date"]),
        status: json["status"],
        totalBoxes: json["total_boxes"],
        totalReceived: json["total_received"],
        orderDoc: json["order_doc"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "task_id": taskId,
        "content_status": contentStatus,
        "customer_id": customerId,
        "customer_mobile": customerMobile,
        "order_type": orderType,
        "total_price": totalPrice,
        "task_status": taskStatus,
        "order_shipping_address": orderShippingAddress,
        "order_warehouse_address": orderWarehouseAddress,
        "delivery_date":
            "${deliveryDate?.year.toString().padLeft(4, '0')}-${deliveryDate?.month.toString().padLeft(2, '0')}-${deliveryDate?.day.toString().padLeft(2, '0')}",
        "status": status,
        "total_boxes": totalBoxes,
        "total_received": totalReceived,
        "order_doc": orderDoc,
        "order_items": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem(
      {this.itemParent,
      this.item,
      this.needAdviser,
      this.price,
      this.quantity,
      this.totalPrice,
      this.groupId,
      this.isParent,
      this.itemsList,
      this.itemStatus,
      this.boxes,
      this.options});

  String? itemParent;
  String? item;
  num? needAdviser;
  num? price;
  num? quantity;
  num? totalPrice;
  String? groupId;
  String? isParent;
  List<String>? options;
  List<String>? boxes;

  List<ItemsList>? itemsList;
  String? itemStatus;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        itemParent: json["item_parent"],
        item: json["item"],
        needAdviser: json["need_Adviser"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
        groupId: json["group_id"],
        boxes: json["boxes"] == null
            ? []
            : List<String>.from(json["boxes"].map((x) => x)),
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"].map((x) => x)),
        isParent: json["is_parent"] == null ? null : json["is_parent"],
        itemsList: json["items_list"] == null
            ? null
            : List<ItemsList>.from(
                json["items_list"].map((x) => ItemsList.fromJson(x))),
        itemStatus: json["item_status"] == null ? null : json["item_status"],
      );

  Map<String, dynamic> toJson() => {
        "item_parent": itemParent,
        "item": item,
        "need_Adviser": needAdviser,
        "price": price,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "group_id": groupId,
        "is_parent": isParent == null ? null : isParent,
        "items_list": itemsList == null
            ? null
            : List<dynamic>.from(itemsList!.map((x) => x.toJson())),
        "item_status": itemStatus == null ? null : itemStatus,
      };
}

class ItemsList {
  ItemsList({
    this.itemParent,
    this.item,
    this.needAdviser,
    this.price,
    this.quantity,
    this.totalPrice,
    this.groupId,
  });

  String? itemParent;
  String? item;
  num? needAdviser;
  num? price;
  num? quantity;
  num? totalPrice;
  String? groupId;

  factory ItemsList.fromJson(Map<String, dynamic> json) => ItemsList(
        itemParent: json["item_parent"],
        item: json["item"],
        needAdviser: json["need_Adviser"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        groupId: json["group_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_parent": itemParent,
        "item": item,
        "need_Adviser": needAdviser,
        "price": price,
        "quantity": quantity,
        "total_price": totalPrice,
        "group_id": groupId,
      };
}
