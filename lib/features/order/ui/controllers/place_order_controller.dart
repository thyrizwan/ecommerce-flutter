import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/order/data/model/order_response_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class PlaceOrderController extends GetxController {
  bool _inProgress = false;

  bool get isInProgress => _inProgress;

  OrderResponseModel? _orderResponse;

  OrderResponseModel? get orderResponse => _orderResponse;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> placeOrder(Map<String, dynamic> body) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.placeOrderUrl, body);

    if (response.isSuccess) {
      _orderResponse = OrderResponseModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
