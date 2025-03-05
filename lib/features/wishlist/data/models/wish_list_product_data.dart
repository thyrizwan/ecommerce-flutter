import 'package:ecommerce/features/wishlist/data/models/wish_list_product_result.dart';

class WishListProductData {
  final List<WishListProductResult> wishListProductResult;
  final int total;
  final String? firstPage;
  final String? previous;
  final String? next;
  final String? lastPage;

  WishListProductData({
    required this.wishListProductResult,
    required this.total,
    this.firstPage,
    this.previous,
    this.next,
    this.lastPage,
  });

  factory WishListProductData.fromJson(Map<String, dynamic> json) {
    return WishListProductData(
      wishListProductResult: (json['results'] as List?)
          ?.map((item) => WishListProductResult.fromJson(item))
          .toList() ??
          [],
      total: json['total'] ?? 0,
      firstPage: json['first_page'],
      previous: json['previous'],
      next: json['next'],
      lastPage: json['last_page'],
    );
  }
}