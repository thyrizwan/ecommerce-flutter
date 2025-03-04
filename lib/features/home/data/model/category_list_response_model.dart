import 'package:ecommerce/features/home/data/model/category_list_data_model.dart';

class CategoryListResponseModel {
  int? code;
  String? status;
  String? msg;
  CategoryListDataModel? data;

  CategoryListResponseModel({this.code, this.status, this.msg, this.data});

  CategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null
        ? CategoryListDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
