
import 'package:ecommerce/features/common/data/model/product_list_model.dart';

class ProductListDataModel {
  final List<ProductListModel> productListData;
  final int total;
  final int? firstPage;
  final int? previous;
  final int? next;
  final int? lastPage;

  ProductListDataModel({
    required this.productListData,
    required this.total,
    this.firstPage,
    this.previous,
    this.next,
    required this.lastPage,
  });

  factory ProductListDataModel.fromJson(Map<String, dynamic> json) {
    return ProductListDataModel(
      productListData: (json['results'] as List)
          .map((item) => ProductListModel.fromJson(item))
          .toList(),
      total: json['total'],
      firstPage: json['first_page'],
      previous: json['previous'],
      next: json['next'],
      lastPage: json['last_page'],
    );
  }
}
