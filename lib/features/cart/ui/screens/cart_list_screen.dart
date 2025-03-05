import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/cart/ui/controllers/get_carted_product_controller.dart';
import 'package:ecommerce/features/cart/ui/widgets/cart_product_item_widget.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  static const String name = '/cart-list';

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<GetCartedProductController>().getMyCartItem();
    double totalPrice =
        Get.find<GetCartedProductController>().getTotalCartPrice();
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
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: GetBuilder<GetCartedProductController>(
                      builder: (controller) {
                        if (controller.isInProgress) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (controller.cartItems.isEmpty) {
                          return Center(child: Text("No items in cart"));
                        }
                        return ListView.builder(
                          itemCount: controller.cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = controller.cartItems[index];
                            return CartProductItem(
                              cartMasterItem: controller.cartMasterItems[index],
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
              onPressed: () {},
              child: Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavBarController>().backToHome();
  }
}
