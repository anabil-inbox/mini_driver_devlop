import 'package:inbox_driver/feature/model/payment/payment.dart';

import 'language.dart';

class ApiSettings {
  ApiSettings(
      {this.customerType,
      this.aboutUs,
      this.termOfConditions,
      this.contactInfo,
      this.companySectors,
      this.notAllowed,
      this.languges,
      this.borderFactor,
      this.paymentMethod,
      this.waitingTime,
      this.deliveryFactor});

  String? customerType;
  String? aboutUs;
  String? termOfConditions;
  ContactInfo? contactInfo;
  List<CompanySector>? companySectors;
  List<dynamic>? notAllowed;
  List<Language>? languges;
  num? borderFactor;
  num? deliveryFactor;
  int? waitingTime;
  List<PaymentMethod>? paymentMethod;

  factory ApiSettings.fromJson(Map<String, dynamic> json) => ApiSettings(
        customerType: json["customer_type"],
        aboutUs: json["about_us"] ?? "",
        waitingTime: json["waiting_time"],
        deliveryFactor: json["delivery_factor"] ?? 1,
        borderFactor: json["border_factor"] ?? 1,
        termOfConditions: json["term_of_conditions"],
        paymentMethod: (json["payment_method"] == [] || json["payment_method"] == null)
          ? []
          : List<PaymentMethod>.from(
              json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
        contactInfo: json["contact_info"] == null
            ? null
            : ContactInfo.fromJson(json["contact_info"]),
        companySectors: json["company_sectors"] == null
            ? null
            : List<CompanySector>.from(
                json["company_sectors"].map((x) => CompanySector.fromJson(x))),
        notAllowed: json["not_allowed"] == null
            ? null
            : List<dynamic>.from(json["not_allowed"].map((x) => x)),
        languges: json["languages"] == null
            ? null
            : List<Language>.from(
                json["languages"].map((x) => Language.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_type": customerType,
        "about_us": aboutUs,
        "delivery_factor": deliveryFactor,
        "border_factor": borderFactor,
        "term_of_conditions": termOfConditions,
        "contact_info": contactInfo!.toJson(),
        "company_sectors":
            List<dynamic>.from(companySectors!.map((x) => x.toJson())),
        "not_allowed": List<dynamic>.from(notAllowed!.map((x) => x)),
        "languages": List<dynamic>.from(languges!.map((x) => x.toJson())),
      };
}

class CompanySector {
  CompanySector({
    this.name,
    this.sectorName,
  });

  String? name;
  String? sectorName;

  factory CompanySector.fromJson(Map<String, dynamic> json) => CompanySector(
        name: json["name"],
        sectorName: json["sector_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sector_name": sectorName,
      };
}

class ContactInfo {
  ContactInfo({
    this.email,
    this.mobile,
    this.facbook,
    this.instagram,
  });

  dynamic email;
  dynamic mobile;
  dynamic facbook;
  dynamic instagram;

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        email: json["email"],
        mobile: json["mobile"],
        facbook: json["facbook"],
        instagram: json["instagram"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "mobile": mobile,
        "facbook": facbook,
        "instagram": instagram,
      };
}
