class TaskResponse {
  TaskResponse({
    this.isNew,
    this.customerId,
    this.total,
    this.totalPaid,
    this.totalDue,
  });

  bool? isNew;
  String? customerId;
  num? total;
  num? totalPaid;
  num? totalDue;

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
        isNew: json["is_new"],
        customerId: json["customer_id"],
        total: json["total"],
        totalPaid: json["total_paid"],
        totalDue: json["total_due"],
      );

  Map<String, dynamic> toJson() => {
        "is_new": isNew,
        "customer_id": customerId,
        "total": total,
        "total_paid": totalPaid,
        "total_due": totalDue,
      };
}
