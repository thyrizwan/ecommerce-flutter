class ProductCategoryModel {
  final String id;
  final String title;
  final String slug;
  final String icon;

  ProductCategoryModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.icon,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      icon: json['icon'],
    );
  }
}
