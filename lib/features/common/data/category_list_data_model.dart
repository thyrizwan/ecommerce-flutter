import 'package:ecommerce/features/common/data/category_list_model.dart';

class CategoryListDataModel {
  List<CategoryListModel>? categoryList;
  int? total;
  Null firstPage;
  Null previous;
  int? next;
  int? lastPage;

  CategoryListDataModel(
      {this.categoryList,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  CategoryListDataModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      categoryList = <CategoryListModel>[];
      json['results'].forEach((v) {
        categoryList!.add(CategoryListModel.fromJson(v));
      });
    }
    total = json['total'];
    firstPage = json['first_page'];
    previous = json['previous'];
    next = json['next'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryList != null) {
      data['results'] = categoryList!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['first_page'] = firstPage;
    data['previous'] = previous;
    data['next'] = next;
    data['last_page'] = lastPage;
    return data;
  }
}
