import 'package:ecommerce/features/home/data/model/banner_list_data_model.dart';

class BannerListResponseModel {
  int? code;
  String? status;
  String? msg;
  BannerListDataModel? bannerListDataModel;

  BannerListResponseModel(
      {this.code, this.status, this.msg, this.bannerListDataModel});

  BannerListResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    bannerListDataModel = json['data'] != null
        ? BannerListDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['msg'] = msg;
    if (bannerListDataModel != null) {
      data['data'] = bannerListDataModel!.toJson();
    }
    return data;
  }
}
