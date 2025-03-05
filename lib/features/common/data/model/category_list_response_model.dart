import 'package:ecommerce/features/common/data/model/category_list_data_model.dart';

class CategoryListResponseModel {
  int? code;
  String? status;
  String? msg;
  CategoryListDataModel? categoryListDataModel;

  CategoryListResponseModel(
      {this.code, this.status, this.msg, this.categoryListDataModel});

  CategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    categoryListDataModel = json['data'] != null
        ? CategoryListDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['msg'] = msg;
    if (this.categoryListDataModel != null) {
      data['data'] = this.categoryListDataModel!.toJson();
    }
    return data;
  }
}
