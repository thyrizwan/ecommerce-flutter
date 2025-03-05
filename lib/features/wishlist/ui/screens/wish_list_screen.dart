import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/item_card.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/wishlist/ui/controllers/wish_list_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const String name = '/wish-list';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
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
      Get.find<WishListProductController>().getWishListProductList();
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
          child: RefreshIndicator(
            onRefresh: () async {
              await Get.find<WishListProductController>()
                  .getWishListProductList();
            },
            child: _isLoggedIn
                ? GetBuilder<WishListProductController>(builder: (controller) {
                    if (controller.isInProgress) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    _buildShimmerBox(150, 100),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                  ],
                                ),
                                const SizedBox(width: 6),
                                Column(
                                  children: [
                                    _buildShimmerBox(150, 100),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    _buildShimmerBox(150, 100),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                  ],
                                ),
                                const SizedBox(width: 6),
                                Column(
                                  children: [
                                    _buildShimmerBox(150, 100),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    _buildShimmerBox(150, 100),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                    const SizedBox(height: 4),
                                    _buildShimmerBox(150, 20),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.98,
                          crossAxisSpacing: 1),
                      itemCount: controller.mappedProductList.length,
                      itemBuilder: (context, index) {
                        return ProductItemWidget(
                            productListModel:
                                controller.mappedProductList[index]);
                      },
                    );
                  })
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "You are not logged in!",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignInScreen.name);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text("Login Now"),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
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
