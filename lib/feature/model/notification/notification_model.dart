class NotificationModel {
  NotificationModel({
    this.date,
    this.title,
    this.message,
    this.receiveStatus,
  });

  DateTime? date;
  String? title;
  String? message;
  String? receiveStatus;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        date: DateTime.parse(json["date"]),
        title: json["title"],
        message: json["message"],
        receiveStatus: json["receive_status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "title": title,
        "message": message,
        "receive_status": receiveStatus,
      };
}
