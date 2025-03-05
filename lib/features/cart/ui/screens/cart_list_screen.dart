import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/cart/ui/controllers/get_carted_product_controller.dart';
import 'package:ecommerce/features/cart/ui/widgets/cart_product_item_widget.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/order/ui/screens/order_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  static const String name = '/cart-list';

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    var sharedPref = SharedPreferenceHelper();
    _isLoggedIn = await sharedPref.isLoggedIn();
    if (_isLoggedIn) {
      Get.find<GetCartedProductController>().getMyCartItem();
      double totalPrice =
          Get.find<GetCartedProductController>().getTotalCartPrice();
    } else {
      MySnackBar.show(
          title: 'Please Logged In',
          type: SnackBarType.error,
          message: 'You are not logged in.');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cart List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            onPressed: _onPop,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Get.find<GetCartedProductController>().getMyCartItem();
            setState(() {});
          },
          child: _isLoggedIn
              ? Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          child: GetBuilder<GetCartedProductController>(
                            builder: (controller) {
                              if (controller.isInProgress) {
                                return Column(
                                  children: [
                                    _buildShimmerBox(double.infinity, 130),
                                    const SizedBox(height: 10),
                                    _buildShimmerBox(double.infinity, 130),
                                    const SizedBox(height: 10),
                                    _buildShimmerBox(double.infinity, 130),
                                  ],
                                );
                              }
                              if (controller.cartItems.isEmpty) {
                                return Center(child: Text("No items in cart"));
                              }
                              return ListView.builder(
                                itemCount: controller.cartItems.length,
                                itemBuilder: (context, index) {
                                  final cartItem = controller.cartItems[index];
                                  return CartProductItem(
                                    cartMasterItem:
                                        controller.cartMasterItems[index],
                                    cartItem: cartItem,
                                    onItemRemoved: () {
                                      setState(() {});
                                    },
                                    onQuantityChange: (int noOfItem) {
                                      Get.find<GetCartedProductController>()
                                          .updateCartItemQuantity(
                                              cartItem.id, noOfItem);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    _buildPriceAndAddToCartSection(textTheme),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You are not logged in!",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignInScreen.name);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Login Now"),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Container _buildPriceAndAddToCartSection(TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.snowyColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<GetCartedProductController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: textTheme.titleSmall,
                ),
                Text(
                  '₹${controller.getTotalCartPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.softColor,
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OrderPlaceScreen.name);
              },
              child: Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavBarController>().backToHome();
  }
}
