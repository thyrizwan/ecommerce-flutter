import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/order/data/model/order_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class GetOrderController extends GetxController {
  bool _inProgress = false;

  bool get isInProgress => _inProgress;

  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> fetchOrders() async {
    _inProgress = true;
    update();

    final response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getOrdersUrl, isAuth: true);

    if (response.isSuccess) {
      List<dynamic> results = response.responseData['data']['results'];
      _orders = results.map((order) => OrderModel.fromJson(order)).toList();
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
  }
}
