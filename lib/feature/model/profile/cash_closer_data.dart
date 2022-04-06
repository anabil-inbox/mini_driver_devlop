class CashCloserData {
    CashCloserData({
        this.id,
        this.amount,
        this.salesOrder,
        this.status,
    });

    String? id;
    num? amount;
    String? salesOrder;
    int? status;

    factory CashCloserData.fromJson(Map<String, dynamic> json) => CashCloserData(
        id:json["id"] == null ? null: json["id"],
        amount:json["amount"] == null ? null: json["amount"],
        salesOrder:json["sales_order"] == null ? null: json["sales_order"],
        status:json["status"] == null ? null: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id":id == null ? null: id,
        "amount":amount == null ? null: amount,
        "sales_order":salesOrder == null ? null: salesOrder,
        "status":status == null ? null: status,
    };
}
