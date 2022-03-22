// ignore_for_file: prefer_if_null_operators

class OrderItem {
  OrderItem({
    this.itemParent,
    this.needAdviser,
    this.options,
    this.price,
    this.quantity,
    this.totalPrice,
    this.groupId,
    this.isParent,
    this.beneficiaryNameIn,
    this.itemsList,
    this.itemName,
  });

  String? itemParent;
  int? needAdviser;
  List<dynamic>? options;
  num? price;
  num? quantity;
  num? totalPrice;
  String? groupId;
  String? isParent;
  dynamic beneficiaryNameIn;
  List<OrderItem>? itemsList;
  dynamic itemName;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        needAdviser: json["need_Adviser"],
        options: List<dynamic>.from(json["options"].map((x) => x)),
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        groupId: json["group_id"],
        isParent: json["is_parent"] == null ? null : json["is_parent"],
        beneficiaryNameIn: json["beneficiary_name_in"],
        itemsList: json["items_list"] == null
            ? null
            : List<OrderItem>.from(
                json["items_list"].map((x) => OrderItem.fromJson(x))),
        itemName: json["item_name"],
      );

  Map<String, dynamic> toJson() => {
        "need_Adviser": needAdviser,
        "options": List<dynamic>.from(options!.map((x) => x)),
        "price": price,
        "quantity": quantity,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "group_id": groupId,
        "is_parent": isParent == null ? null : isParent,
        "beneficiary_name_in": beneficiaryNameIn,
        "items_list": itemsList == null
            ? null
            : List<dynamic>.from(itemsList!.map((x) => x.toJson())),
        "item_name": itemName,
      };
}
