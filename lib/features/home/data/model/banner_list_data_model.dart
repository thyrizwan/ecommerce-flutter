import 'package:ecommerce/features/home/data/model/banner_list_model.dart';

class BannerListDataModel {
  List<BannerListModel>? bannerListData;
  int? total;
  Null firstPage;
  Null previous;
  int? next;
  int? lastPage;

  BannerListDataModel(
      {this.bannerListData,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  BannerListDataModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      bannerListData = <BannerListModel>[];
      json['results'].forEach((v) {
        bannerListData!.add(BannerListModel.fromJson(v));
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
    if (bannerListData != null) {
      data['results'] = bannerListData!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['first_page'] = firstPage;
    data['previous'] = previous;
    data['next'] = next;
    data['last_page'] = lastPage;
    return data;
  }
}
