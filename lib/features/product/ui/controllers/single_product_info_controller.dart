import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/common/data/model/product_list_model.dart';
import 'package:ecommerce/features/product/data/models/single_product_info_response_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class SingleProductInfoController extends GetxController {
  bool _inProgress = false;

  bool get isInProgress => _inProgress;

  SingleProductInfoResponseModel? _productInfo;

  ProductListModel get productInfo => _productInfo!.currentProductInfo;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> fetchProductInfo(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getSingleProductInfoUrl(productId));

    if (response.isSuccess) {
      print(response.responseData);
      _productInfo =
          SingleProductInfoResponseModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
