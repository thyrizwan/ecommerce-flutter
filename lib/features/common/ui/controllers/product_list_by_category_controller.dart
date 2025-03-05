import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/common/data/model/product_list_api_response_model.dart';
import 'package:ecommerce/features/common/data/model/product_list_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class ProductListByCategoryController extends GetxController {
  bool _inProgress = false;

  bool get isInProgress => _inProgress;

  ProductListApiResponseModel? _productListApiResponseModel;

  List<ProductListModel> get productList =>
      _productListApiResponseModel?.productListData?.productListData ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductByCategoryList(String categoryId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getProductListByCategoryUrl(categoryId));

    if (response.isSuccess) {
      _productListApiResponseModel =
          ProductListApiResponseModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
