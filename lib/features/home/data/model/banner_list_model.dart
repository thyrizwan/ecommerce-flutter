import 'package:ecommerce/features/home/data/model/banner_model.dart';

class BannerListModel {
  int? code;
  String? status;
  String? msg;
  Data? data;

  BannerListModel({this.code, this.status, this.msg, this.data});

  BannerListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  List<BannerModel>? bannerModelResults;
  int? total;
  Null firstPage;
  Null previous;
  int? next;
  int? lastPage;

  Data(
      {this.bannerModelResults,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      bannerModelResults = <BannerModel>[];
      json['results'].forEach((v) {
        bannerModelResults!.add(BannerModel.fromJson(v));
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
    if (bannerModelResults != null) {
      data['results'] = bannerModelResults!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['first_page'] = firstPage;
    data['previous'] = previous;
    data['next'] = next;
    data['last_page'] = lastPage;
    return data;
  }
}
