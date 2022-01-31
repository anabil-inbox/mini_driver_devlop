
class EmergencyCase {
    EmergencyCase({
        this.name,
    });

    String? name;

    factory EmergencyCase.fromJson(Map<String, dynamic> json) => EmergencyCase(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}