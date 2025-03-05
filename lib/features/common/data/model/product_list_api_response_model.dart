import 'dart:convert';

import 'package:ecommerce/features/common/data/model/product_list_data_model.dart';


class ProductListApiResponseModel {
  final int code;
  final String status;
  final String msg;
  final ProductListDataModel productListData;

  ProductListApiResponseModel({
    required this.code,
    required this.status,
    required this.msg,
    required this.productListData,
  });

  factory ProductListApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductListApiResponseModel(
      code: json['code'],
      status: json['status'],
      msg: json['msg'],
      productListData: ProductListDataModel.fromJson(json['data']),
    );
  }
}

// void main() {
//   String jsonString = '...';
//   Map<String, dynamic> jsonMap = jsonDecode(jsonString);
//   ProductListApiResponseModel response = ProductListApiResponseModel.fromJson(jsonMap);
//   print(response.productListData.productListData[0].title);
// }
