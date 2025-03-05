import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/item_card.dart';
import 'package:ecommerce/features/wishlist/ui/controllers/wish_list_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const String name = '/wish-list';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<WishListProductController>().getWishListProductList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wish List',
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GetBuilder<WishListProductController>(
            builder: (controller) {
              if(controller.isInProgress){
                return Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.98, crossAxisSpacing: 1),
                itemCount: controller.mappedProductList.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(productListModel: controller.mappedProductList[index]);
                },
              );
            }
          ),
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavBarController>().backToHome();
  }
}
