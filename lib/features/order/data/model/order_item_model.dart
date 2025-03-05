class OrderItemModel {
  String? productId;
  int? quantity;
  int? price;

  OrderItemModel({
    this.productId,
    this.quantity,
    this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return OrderItemModel();
    return OrderItemModel(
      productId: json["product"],
      quantity: json["quantity"],
      price: json["price"],
    );
  }
}
