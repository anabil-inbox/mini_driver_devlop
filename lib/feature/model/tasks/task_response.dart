class TaskResponse {
  TaskResponse(
      {this.isNew,
      this.customerId,
      this.total,
      this.totalPaid,
      this.totalDue,
      this.paymentMethod,
      this.salesOrder,
      this.proccessType});

  bool? isNew;
  String? customerId;
  num? total;
  num? totalPaid;
  num? totalDue;
  String? paymentMethod;
  String? proccessType;
  String? salesOrder;
  

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
        isNew: json["is_new"],
        customerId: json["customer_id"],
        total: json["total"],
        salesOrder: json["sales_order"],
        proccessType: json["process_type"],
        paymentMethod: json["payment_method"],
        totalPaid: json["total_paid"],
        totalDue: json["total_due"],
      );

  Map<String, dynamic> toJson() => {
        "is_new": isNew,
        "customer_id": customerId,
        "process_type": proccessType,
        "total": total,
        "sales_order": salesOrder,
        "payment_method": paymentMethod,
        "total_paid": totalPaid,
        "total_due": totalDue,
      };
}
