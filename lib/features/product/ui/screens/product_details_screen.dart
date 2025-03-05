import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/product/ui/controllers/single_product_info_controller.dart';
import 'package:ecommerce/features/product/ui/widgets/color_picker_widget.dart';
import 'package:ecommerce/features/product/ui/widgets/product_image_carousel_slider.dart';
import 'package:ecommerce/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:ecommerce/features/product/ui/widgets/size_picker_widget.dart';
import 'package:ecommerce/features/review/ui/screens/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  static const String name = 'product/product_details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
          print(widget.productId);
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: GetBuilder<SingleProductInfoController>(
                    builder: (controller) {
                  return Column(
                    children: [
                      ProductImageCarouselSlider(),
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
                                    children: [
                                      Text(
                                        'Product Name: Along Name can be fitted here as well as short name, you can check it here ${widget.productId}',
                                        style: textTheme.titleMedium,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 18,
                                              ),
                                              Text(
                                                '4.8',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
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
                                                  context, ReviewScreen.name);
                                            },
                                            child: Text(
                                              'Reviews',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4.0),
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
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ProductQuantityIncDecButton(
                                    onChange: (int value) {})
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Unit Price', style: textTheme.titleMedium),
                            Text(
                              '₹100',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 16),
                            Text('Color', style: textTheme.titleMedium),
                            ColorPickerWidget(
                              colors: [
                                'Red',
                                'Green',
                                'Yellow',
                                'Pink',
                                'Blue'
                              ],
                              onColorSelected: (String selectedColor) {},
                            ),
                            const SizedBox(height: 16),
                            Text('Size', style: textTheme.titleMedium),
                            SizePickerWidget(
                              sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
                              onSizeSelected: (String selectedSize) {},
                            ),
                            const SizedBox(height: 20),
                            Text('Description', style: textTheme.titleMedium),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet velit vel nisi pretium interdum. Sed bibendum, ipsum non consectetur ultricies, velit justo volutpat velit, vel tempor velit velit at urna. Sed euismod neque vel velit ullamcorper, non consectetur ipsum tristique. Sed sed enim ac diam posuere luctus. Integer sed purus ac neque tincidunt ornare. Donec vel ipsum non nisi tempor convallis. Sed',
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
            _buildPriceAndAddToCartSection(textTheme),
          ],
        ),
      ),
    );
  }

  Container _buildPriceAndAddToCartSection(TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.snowyColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Price',
                style: textTheme.titleSmall,
              ),
              Text(
                '₹100',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.softColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
