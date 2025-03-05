import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class GetCartedProductController extends GetxController {
  bool _inProgress = false;

  bool get isInProgress => _inProgress;

  List<Product> _cartItems = [];
  List<CartItem> _cartMasterItems = [];

  List<Product> get cartItems => _cartItems;

  List<CartItem> get cartMasterItems => _cartMasterItems;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getMyCartItem() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getCartedProductUrl, isAuth: true);

    if (response.isSuccess) {
      try {
        CartListResponse cartResponse =
            CartListResponse.fromJson(response.responseData);
        _cartItems =
            cartResponse.results.map((cartItem) => cartItem.product).toList();
        _cartMasterItems = cartResponse.results;
        isSuccess = true;
      } catch (e) {
        _errorMessage = "Data parsing error";
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  void updateCartItemQuantity(String productId, int newQuantity) {
    int index = _cartItems.indexWhere((item) => item.id == productId);
    if (index != -1) {
      _cartItems[index].quantity = newQuantity;
      update();
    }
  }

  double getTotalCartPrice() {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.currentPrice * item.quantity));
  }
}
