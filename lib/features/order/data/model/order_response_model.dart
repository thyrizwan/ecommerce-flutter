import 'package:ecommerce/features/order/data/model/order_item_model.dart';
import 'package:ecommerce/features/order/data/model/shipping_address_model.dart';

class OrderResponseModel {
  String? status;
  String? message;
  int? totalPrice;
  String? paymentMethod;
  ShippingAddressModel? shippingAddress;
  List<OrderItemModel>? items;

  OrderResponseModel({
    this.status,
    this.message,
    this.totalPrice,
    this.paymentMethod,
    this.shippingAddress,
    this.items,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return OrderResponseModel();
    return OrderResponseModel(
      status: json["status"],
      message: json["msg"],
      totalPrice: json["data"]?["total_price"],
      paymentMethod: json["data"]?["payment_method"],
      shippingAddress:
          ShippingAddressModel.fromJson(json["data"]?["shipping_address"]),
      items: (json["data"]?["items"] as List?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}
