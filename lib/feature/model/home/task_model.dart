class TaskModel {
  TaskModel({
    this.id,
    this.taskName,
    this.status,
    this.date,
    this.totalTasks,
    this.totalDone,
  });

  String? id;
  String? taskName;
  String? status;
  DateTime? date;
  int? totalTasks;
  int? totalDone;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        taskName: json["task_name"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        totalTasks: json["total_tasks"],
        totalDone: json["total_done"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_name": taskName,
        "status": status,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "total_tasks": totalTasks,
        "total_done": totalDone,
      };
}
