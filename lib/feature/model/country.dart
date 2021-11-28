import 'package:logger/logger.dart';

class Country {
  Country({
    this.name,
    this.flag,
    this.prefix,
    this.code,
  });

  String? name;
  String? flag;
  String? prefix;
  String? code;

  factory Country.fromJson(Map<String, dynamic> json) {
    try {
      return Country(
        name: json["name"] ?? "",
        flag: json["flag"] ?? "",
        prefix: json["prefix"] ?? "",
        code: json["code"] ?? "",
      );
    } catch (e) {
      Logger().d(e);
      return Country.fromJson({});
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name ?? "",
        "flag": flag ?? "",
        "prefix": prefix ?? "",
        "code" : code ?? ""
      };
}
