import 'package:ecommerce/features/order/data/model/shipping_address_model.dart';
import 'package:ecommerce/features/order/data/model/user_model.dart';

class OrderModel {
  String? id;
  UserModel? user;
  ShippingAddressModel? shippingAddress;
  int? totalPrice;
  String? status;
  String? paymentMethod;
  DateTime? createdAt;
  int? totalItems;

  OrderModel({
    this.id,
    this.user,
    this.shippingAddress,
    this.totalPrice,
    this.status,
    this.paymentMethod,
    this.createdAt,
    this.totalItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      shippingAddress: json['shipping_address'] != null
          ? ShippingAddressModel.fromJson(json['shipping_address'])
          : null,
      totalPrice: json['total_price'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      totalItems: json['total_items'],
    );
  }
}
