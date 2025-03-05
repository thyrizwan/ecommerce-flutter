import 'package:ecommerce/features/common/data/model/product_brand_model.dart';
import 'package:ecommerce/features/common/data/model/product_category_model.dart';

class ProductListModel {
  final String id;
  final String title;
  final ProductBrandModel brand;
  final List<ProductCategoryModel> categories;
  final String slug;
  final String? metaDescription;
  final String description;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final List<String> tags;
  final int? regularPrice;
  final int currentPrice;
  final int quantity;
  final String createdAt;
  final String updatedAt;

  ProductListModel({
    required this.id,
    required this.title,
    required this.brand,
    required this.categories,
    required this.slug,
    this.metaDescription,
    required this.description,
    required this.photos,
    required this.colors,
    required this.sizes,
    required this.tags,
    this.regularPrice,
    required this.currentPrice,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['_id'],
      title: json['title'],
      brand: ProductBrandModel.fromJson(json['brand']),
      categories: (json['categories'] as List)
          .map((item) => ProductCategoryModel.fromJson(item))
          .toList(),
      slug: json['slug'],
      metaDescription: json['meta_description'],
      description: json['description'],
      photos: List<String>.from(json['photos']),
      colors: List<String>.from(json['colors']),
      sizes: List<String>.from(json['sizes']),
      tags: List<String>.from(json['tags']),
      regularPrice: json['regular_price'],
      currentPrice: json['current_price'],
      quantity: json['quantity'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
