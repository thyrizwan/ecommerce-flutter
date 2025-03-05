class ProductBrandModel {
  final String id;
  final String title;
  final String slug;
  final String icon;

  ProductBrandModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.icon,
  });

  factory ProductBrandModel.fromJson(Map<String, dynamic> json) {
    return ProductBrandModel(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      icon: json['icon'],
    );
  }
}
