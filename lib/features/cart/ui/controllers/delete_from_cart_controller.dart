import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/review/data/models/view_review_response_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class DeleteFromCartController extends GetxController {
  bool _inProgress = false;
  bool get isInProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteFromCart(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
    await Get.find<NetworkCaller>().deleteRequest(Urls.deleteFromCartUrl(productId));

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}