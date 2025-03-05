// CartItem Model
class CartItem {
  final String id;
  final Product product;
  final String user;
  int quantity;
  final String? color;
  final String? size;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartItem({
    required this.id,
    required this.product,
    required this.user,
    required this.quantity,
    this.color,
    this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      product: Product.fromJson(json['product']),
      user: json['user'],
      quantity: json['quantity'],
      color: json['color'],
      size: json['size'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// Product Model
class Product {
  final String id;
  final String title;
  final String brand;
  final List<String> categories;
  final String slug;
  final String? metaDescription;
  final String description;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final List<String> tags;
  final int? regularPrice;
  final int currentPrice;
  int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      brand: json['brand'],
      categories: List<String>.from(json['categories']),
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// Cart List Response Model
class CartListResponse {
  final int code;
  final String status;
  final String msg;
  final List<CartItem> results;
  final int total;

  CartListResponse({
    required this.code,
    required this.status,
    required this.msg,
    required this.results,
    required this.total,
  });

  factory CartListResponse.fromJson(Map<String, dynamic> json) {
    return CartListResponse(
      code: json['code'],
      status: json['status'],
      msg: json['msg'],
      results: (json['data']['results'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      total: json['data']['total'],
    );
  }
}
