class WishListProductFinalList {
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
  final int quantity;
  final String createdAt;
  final String updatedAt;

  WishListProductFinalList({
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

  factory WishListProductFinalList.fromJson(Map<String, dynamic> json) {
    return WishListProductFinalList(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      categories:
      (json['categories'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      slug: json['slug'] ?? '',
      metaDescription: json['meta_description'],
      description: json['description'] ?? '',
      photos:
      (json['photos'] as List?)?.map((e) => e.toString()).toList() ?? [],
      colors:
      (json['colors'] as List?)?.map((e) => e.toString()).toList() ?? [],
      sizes: (json['sizes'] as List?)?.map((e) => e.toString()).toList() ?? [],
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      regularPrice: json['regular_price'] as int?,
      currentPrice: json['current_price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
