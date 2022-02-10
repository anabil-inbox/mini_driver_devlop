class TaskResponse {
  TaskResponse({
    this.isNew,
    this.customerId,
    this.total,
    this.totalPaid,
    this.totalDue,
    this.paymentMethod
  });

  bool? isNew;
  String? customerId;
  num? total;
  num? totalPaid;
  num? totalDue;
  String? paymentMethod;

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
        isNew: json["is_new"],
        customerId: json["customer_id"],
        total: json["total"],
        paymentMethod: json["payment_method"],
        totalPaid: json["total_paid"],
        totalDue: json["total_due"],
      );

  Map<String, dynamic> toJson() => {
        "is_new": isNew,
        "customer_id": customerId,
        "total": total,
        "payment_method" : paymentMethod,
        "total_paid": totalPaid,
        "total_due": totalDue,
      };
}
