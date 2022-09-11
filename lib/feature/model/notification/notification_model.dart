class NotificationModel {
  NotificationModel({
    this.date,
    this.title,
    this.message,
    this.receiveStatus,
    this.action,
    this.actionId,
  });

  DateTime? date;
  String? title;
  String? message;
  String? receiveStatus;
  String? action;
  String? actionId;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        date: DateTime.parse(json["date"]),
        title: json["title"],
        message: json["message"],
        receiveStatus: json["receive_status"],
        action: json["action"] == null ? null : json["action"],
        actionId: json["action_id"] == null ? null : json["action_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "title": title,
        "message": message,
        "receive_status": receiveStatus,
        "action": action == null ? null : action,
        "action_id": actionId == null ? null : actionId,
      };
}
