class DriverReportData {
  DriverReportData({
    this.totalTasks,
    this.doneTasks,
    this.inProgressTasks,
    this.toDo,
    this.averageForDriver,
    this.averageForOther,
  });

  dynamic totalTasks;
  dynamic doneTasks;
  dynamic inProgressTasks;
  dynamic toDo;
  dynamic averageForDriver;
  dynamic averageForOther;

  factory DriverReportData.fromJson(Map<String, dynamic> json) => DriverReportData(
    totalTasks: json["total_tasks"] == null ? 0 : json["total_tasks"],
    doneTasks: json["done_tasks"] == null ? 0 : json["done_tasks"],
    inProgressTasks: json["in_progress_tasks"] == null ? 0 : json["in_progress_tasks"],
    toDo: json["to_do"] == null ? 0 : json["to_do"],
    averageForDriver: json["average_for_driver"] == null ? null : json["average_for_driver"].toDouble(),
    averageForOther: json["average_for_other"] == null ? null : json["average_for_other"],
  );

  Map<String, dynamic> toJson() => {
    "total_tasks": totalTasks == null ? null : totalTasks,
    "done_tasks": doneTasks == null ? null : doneTasks,
    "in_progress_tasks": inProgressTasks == null ? 0 : inProgressTasks,
    "to_do": toDo == null ? null : toDo,
    "average_for_driver": averageForDriver == null ? null : averageForDriver,
    "average_for_other": averageForOther == null ? null : averageForOther,
  };
}
