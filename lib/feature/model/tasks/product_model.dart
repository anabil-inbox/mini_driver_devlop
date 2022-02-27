class ProductModel {
    ProductModel({
        this.parentSalesOrder,
        this.childOrderId,
        this.productCode,
        this.productPrice,
        this.productImage,
    });

    String? parentSalesOrder;
    String? childOrderId;
    String? productCode;
    num? productPrice;
    dynamic productImage;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        parentSalesOrder: json["parent_sales_order"],
        childOrderId: json["child_order_id"],
        productCode: json["product_code"],
        productPrice: json["product_price"],
        productImage: json["product_image"],
    );

    Map<String, dynamic> toJson() => {
        "parent_sales_order": parentSalesOrder,
        "child_order_id": childOrderId,
        "product_code": productCode,
        "product_price": productPrice,
        "product_image": productImage,
    };
}