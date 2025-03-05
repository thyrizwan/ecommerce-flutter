import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/common/data/model/product_list_api_response_model.dart';
import 'package:ecommerce/features/common/data/model/product_list_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class HomeScreenProductListByCategoryController extends GetxController {
  bool _inProgress = false;
  bool get isInProgress => _inProgress;

  ProductListApiResponseModel? _productListApiResponseModel;
  List<ProductListModel> _allProducts = [];

  List<ProductListModel> popularProducts = [];
  List<ProductListModel> specialProducts = [];
  List<ProductListModel> newArrivalProducts = [];

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getProductByCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(Urls.getProductListUrl);

    if (response.isSuccess) {
      _productListApiResponseModel =
          ProductListApiResponseModel.fromJson(response.responseData);
      _allProducts =
          _productListApiResponseModel?.productListData.productListData ?? [];

      popularProducts = _allProducts
          .where((product) =>
              product.categories.any((cat) => cat.slug == "popular") ?? false)
          .toList();

      specialProducts = _allProducts
          .where((product) =>
              product.categories.any((cat) => cat.slug == "special") ?? false)
          .toList();

      newArrivalProducts = _allProducts
          .where((product) =>
              product.categories.any((cat) => cat.slug == "new-arr") ?? false)
          .toList();

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
