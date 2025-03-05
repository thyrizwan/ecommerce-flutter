import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:ecommerce/features/common/data/model/product_list_model.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:ecommerce/features/product/ui/controllers/single_product_info_controller.dart';
import 'package:ecommerce/features/product/ui/widgets/color_picker_widget.dart';
import 'package:ecommerce/features/product/ui/widgets/product_image_carousel_slider.dart';
import 'package:ecommerce/features/product/ui/widgets/size_picker_widget.dart';
import 'package:ecommerce/features/review/ui/screens/review_screen.dart';
import 'package:ecommerce/features/wishlist/ui/controllers/add_to_wish_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  static const String name = 'product/product_details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    Get.find<SingleProductInfoController>().fetchProductInfo(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<SingleProductInfoController>()
              .fetchProductInfo(widget.productId);
        },
        child: GetBuilder<SingleProductInfoController>(builder: (controller) {
          if (controller.isInProgress) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerBox(double.infinity, 200),
                  const SizedBox(height: 10),
                  _buildShimmerBox(double.infinity, 30),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildShimmerBox(200, 30),
                      const SizedBox(width: 10),
                      _buildShimmerBox(100, 30),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildShimmerBox(200, 50),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildShimmerBox(200, 30),
                      const SizedBox(width: 10),
                      _buildShimmerBox(100, 30),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildShimmerBox(200, 30),
                      const SizedBox(width: 10),
                      _buildShimmerBox(100, 30),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildShimmerBox(double.infinity, 30),
                  const SizedBox(height: 10),
                  _buildShimmerBox(double.infinity, 100),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }

          ProductListModel productInfo = controller.productInfo;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: GetBuilder<SingleProductInfoController>(
                      builder: (controller) {
                    return Column(
                      children: [
                        ProductImageCarouselSlider(
                            imageUrls: productInfo.photos ?? []),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productInfo.title,
                                          style: textTheme.titleMedium,
                                        ),
                                        Row(
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 18,
                                                ),
                                                Text(
                                                  '0.0',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  ReviewScreen.name,
                                                  arguments: {
                                                    'productId': productInfo.id
                                                        .toString()
                                                  },
                                                );
                                              },
                                              child: const Text(
                                                'Reviews',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _onAddToWishListBtnPressed(
                                                    productInfo.id);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ProductQuantityIncDecButton(
                                      onChange: (int value) {
                                    setState(() {
                                      _selectedQuantity = value;
                                    });
                                  })
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text('Unit Price', style: textTheme.titleMedium),
                              Text(
                                '₹${productInfo.currentPrice}',
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 16),
                              Text('Color', style: textTheme.titleMedium),
                              ColorPickerWidget(
                                colors: productInfo.colors ?? ['Not Available'],
                                onColorSelected: (String selectedColor) {},
                              ),
                              const SizedBox(height: 16),
                              Text('Size', style: textTheme.titleMedium),
                              SizePickerWidget(
                                sizes: productInfo.sizes ?? ['Not Available'],
                                onSizeSelected: (String selectedSize) {},
                              ),
                              const SizedBox(height: 20),
                              Text('Description', style: textTheme.titleMedium),
                              Text(
                                productInfo.description ?? '',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              _buildPriceAndAddToCartSection(
                  textTheme, productInfo, _selectedQuantity),
            ],
          );
        }),
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

  Container _buildPriceAndAddToCartSection(
      TextTheme textTheme, ProductListModel productInfo, int quantity) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.snowyColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: textTheme.titleSmall,
              ),
              Text(
                '₹${productInfo.currentPrice * quantity}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.softColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {
                _onAddToCartBtnPressed(productInfo.id);
              },
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }

  _onAddToCartBtnPressed(String productId) async {
    AddToCartController addToCartController = Get.find<AddToCartController>();
    Map<String, dynamic> body = {
      "product": productId,
      "quantity": _selectedQuantity,
    };

    final sharedPrefs = SharedPreferenceHelper();
    if (await sharedPrefs.isLoggedIn()) {
      bool isSuccess = await addToCartController.addToMyCart(body);

      if (isSuccess) {
        MySnackBar.show(
          title: "Product in Cart",
          message: 'Product successfully added to cart',
          type: SnackBarType.success,
        );
      } else {
        MySnackBar.show(
          title: "Error adding",
          message: addToCartController.errorMessage,
          type: SnackBarType.error,
        );
      }
    } else {
      MySnackBar.show(
        title: "Login Needed",
        message: 'You need to login to perform this action',
        type: SnackBarType.error,
      );
      if (mounted) {
        Navigator.pushNamed(context, SignInScreen.name);
      }
    }
  }

  _onAddToWishListBtnPressed(String productId) async {
    AddToWishListController addToWishListController =
        Get.find<AddToWishListController>();
    Map<String, dynamic> body = {
      "product": productId,
    };

    final sharedPrefs = SharedPreferenceHelper();
    if (await sharedPrefs.isLoggedIn()) {
      bool isSuccess = await addToWishListController.addToMyWishList(body);

      if (isSuccess) {
        MySnackBar.show(
          title: "Product as Favourite",
          message: 'Product added to wish list',
          type: SnackBarType.success,
        );
      } else {
        MySnackBar.show(
          title: "Error adding",
          message: addToWishListController.errorMessage,
          type: SnackBarType.error,
        );
      }
    } else {
      MySnackBar.show(
        title: "Login Needed",
        message: 'You need to login to perform this action',
        type: SnackBarType.error,
      );
      if (mounted) {
        Navigator.pushNamed(context, SignInScreen.name);
      }
    }
  }
}
