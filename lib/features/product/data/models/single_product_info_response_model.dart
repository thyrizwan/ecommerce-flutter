import 'package:ecommerce/features/common/data/model/product_list_model.dart';

class SingleProductInfoResponseModel {
  final int code;
  final String status;
  final String msg;
  final ProductListModel currentProductInfo;

  SingleProductInfoResponseModel({
    required this.code,
    required this.status,
    required this.msg,
    required this.currentProductInfo,
  });

  factory SingleProductInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return SingleProductInfoResponseModel(
      code: json['code'] as int,
      status: json['status'] as String,
      msg: json['msg'] as String,
      currentProductInfo: ProductListModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
