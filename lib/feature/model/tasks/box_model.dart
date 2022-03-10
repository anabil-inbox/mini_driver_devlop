class BoxModel {
  BoxModel(
      {this.boxId,
      this.boxName,
      this.boxOperations,
      this.serial,
      this.newBoxOperation});

  String? boxId;
  String? boxName;
  List<BoxOperation>? boxOperations;
  String? serial;
  String? newBoxOperation;
  factory BoxModel.fromJson(Map<String, dynamic> json) => BoxModel(
        boxId: json["box_id"],
        serial: json["serial"],
        boxName: json["box_name"],
        newBoxOperation: json["newBoxOperation"],
        boxOperations: json["active_operations"] == null
            ? []
            : List<BoxOperation>.from(
                json["active_operations"].map((x) => BoxOperation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "box_id": boxId,
        "box_name": boxName,
        "serial": serial,
        "newBoxOperation": newBoxOperation,
        "active_operations":
            List<dynamic>.from(boxOperations!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoxModel &&
          runtimeType == other.runtimeType &&
          boxId == other.boxId;

  @override
  int get hashCode => boxId.hashCode;
}

class BoxOperation {
  BoxOperation({
    this.operation,
    this.enabled,
  });

  String? operation;
  int? enabled;

  factory BoxOperation.fromJson(Map<String, dynamic> json) => BoxOperation(
        operation: json["operation"],
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "operation": operation,
        "enabled": enabled,
      };
}
