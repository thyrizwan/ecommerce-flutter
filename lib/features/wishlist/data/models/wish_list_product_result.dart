import 'package:ecommerce/features/wishlist/data/models/wish_list_product_final_list.dart';

class WishListProductResult {
  final String id;
  final WishListProductFinalList wishListProductFinalList;
  final String user;
  final String createdAt;
  final String updatedAt;

  WishListProductResult({
    required this.id,
    required this.wishListProductFinalList,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishListProductResult.fromJson(Map<String, dynamic> json) {
    return WishListProductResult(
      id: json['_id'] ?? '',
      wishListProductFinalList: WishListProductFinalList.fromJson(json['product'] ?? {}),
      user: json['user'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}