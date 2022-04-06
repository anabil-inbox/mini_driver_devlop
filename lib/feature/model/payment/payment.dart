// ignore_for_file: prefer_if_null_operators

class Payment {
    Payment({
        this.paymentMethod,
    });

    List<PaymentMethod>? paymentMethod;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentMethod: List<PaymentMethod>.from(json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "payment_method": List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
    };
}

class PaymentMethod {
    PaymentMethod({
        this.id,
        this.name,
        this.target,
        this.type,
        this.image,
    });

    String? id;
    String? name;
    String? target;
    String? type;
    String? image;

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id:json["id"] == null ? null: json["id"],
        name:json["name"] == null ? null: json["name"],
        target:json["target"] == null ? null: json["target"],
        type: json["type"] == null ? null: json["type"],
        image:json["image"] == null ? null: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id":id == null ? null: id,
        "name":name == null ? null: name,
        "target":target == null ? null: target,
        "type":type == null ? null: type,
        "image": image == null ? null:image,
    };
}
