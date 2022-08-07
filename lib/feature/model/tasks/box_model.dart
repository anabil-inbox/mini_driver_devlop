class BoxModel {
  BoxModel(
      {this.boxId,
      this.boxName,
      this.boxOperations,
      this.serial,
      this.newSeal,
      this.selectedBoxOperations});

  String? boxId;
  String? boxName;
  List<BoxOperation>? boxOperations;
  String? serial;
  BoxOperation? selectedBoxOperations;
  String? newSeal;

  factory BoxModel.fromJson(Map<String, dynamic> json) => BoxModel(
        boxId: json["serial"],
        serial: json["serial"],
        boxName: json["box_name"],
        selectedBoxOperations: json["active_operations"] == null
            ? null
            : List<BoxOperation>.from(json["active_operations"]
                    .map((x) => BoxOperation.fromJson(x)))
                .firstWhere((element) => element.isDefault == 1,
                    orElse: () => BoxOperation()),
        boxOperations: json["active_operations"] == null
            ? []
            : List<BoxOperation>.from(
                json["active_operations"].map((x) => BoxOperation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "box_id": boxId,
        "box_name": boxName,
        "serial": serial,
        "newBoxOperation": selectedBoxOperations,
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
  BoxOperation({this.operation, this.enabled, this.isDefault});

  String? operation;
  int? enabled;
  int? isDefault;

  factory BoxOperation.fromJson(Map<String, dynamic> json) => BoxOperation(
      operation: json["operation"],
      enabled: json["enabled"],
      isDefault: json["default"]);

  Map<String, dynamic> toJson() => {
        "operation": operation,
        "enabled": enabled,
        "default": isDefault,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoxOperation &&
          runtimeType == other.runtimeType &&
          operation == other.operation;

  @override
  int get hashCode => operation.hashCode;
}
