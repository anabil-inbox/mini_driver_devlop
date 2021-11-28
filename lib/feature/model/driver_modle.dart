class Driver {
  Driver(
      {this.id,
      this.driverName,
      this.mobileNumber,
      this.countryCode,
      this.image,
      this.udId,
      this.deviceType,
      this.fcm,
      this.contactNumber,
      this.email});

  String? id;
  String? driverName;
  String? mobileNumber;
  String? countryCode;
  String? udId;
  String? deviceType;
  String? fcm;
  dynamic image;
  List<Map<String, dynamic>>? contactNumber;
  String? email;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        driverName: json["driver_name"],
        mobileNumber: json["mobile_number"],
        countryCode: json["country_code"] ?? "",
        image: json["image"] ?? "",
        udId: json["udid"] ?? "",
        deviceType: json["device_type"] ?? "",
        email: json["email"] ?? "",
        fcm: json["fcm"],
        contactNumber: json["contact_number"] == null
            ? null
            : List<Map<String, dynamic>>.from(
                json["contact_number"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver_name": driverName,
        "mobile_number": mobileNumber,
        "country_code": countryCode,
        "image": image,
        "udid": udId,
        "fcm": fcm,
        "email": email,
        "contact_number": contactNumber == null
            ? null
            : List<Map<String, dynamic>>.from(contactNumber!.map((x) => x)),
      };
}
