import 'package:ecommerce/features/common/ui/controllers/product_list_by_category_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductListScreen extends StatefulWidget {
  static const String name = '/product/product-list-by-category';

  const ProductListScreen(
      {super.key, required this.categoryName, required this.categoryId});

  final String categoryName;
  final String categoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>()
        .getProductByCategoryList(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<ProductListByCategoryController>()
              .getProductByCategoryList(widget.categoryId);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GetBuilder<ProductListByCategoryController>(
              builder: (controller) {
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
            if (controller.productList.isEmpty) {
              return Center(
                  child: Text("No products found for this category."));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.98,
                  crossAxisSpacing: 1),
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                return ProductItemWidget(
                    productListModel: controller.productList[index]);
              },
            );
          }),
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
}
