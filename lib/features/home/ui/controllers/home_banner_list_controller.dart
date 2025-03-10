import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/home/data/model/banner_list_model.dart';
import 'package:ecommerce/features/home/data/model/banner_list_response_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class HomeBannerListController extends GetxController {
  bool _inProgress = false;

  bool get isInProgress => _inProgress;

  BannerListResponseModel? _bannerListResponseModel;

  List<BannerListModel> get bannerList =>
      _bannerListResponseModel?.bannerListDataModel?.bannerListData ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getHomeBannerList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(Urls.getHomeBannerListUrl);

    if (response.isSuccess) {
      _bannerListResponseModel =
          BannerListResponseModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
