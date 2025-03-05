import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/common/data/model/category_list_model.dart';
import 'package:ecommerce/features/common/data/model/category_list_response_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;
  bool get isInProgress => _inProgress;

  CategoryListResponseModel? _categoryListResponseModel;

  List<CategoryListModel> get categoryList =>
      _categoryListResponseModel?.categoryListDataModel?.categoryList ?? [];

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(Urls.getCategoryListUrl);

    if (response.isSuccess) {
      _categoryListResponseModel = CategoryListResponseModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
