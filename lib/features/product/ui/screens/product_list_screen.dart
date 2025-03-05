import 'package:ecommerce/features/common/ui/controllers/product_list_by_category_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {

  static const String name = '/product/product-list-by-category';

  const ProductListScreen({super.key, required this.categoryName, required this.categoryId});

  final String categoryName;
  final String categoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>().getProductByCategoryList(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GetBuilder<ProductListByCategoryController>(
          builder: (controller) {
            if (controller.isInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.98,
                crossAxisSpacing: 1
              ),
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                return ProductItemWidget(productListModel: controller.productList[index]);
              },
            );
          }
        ),
      ),
    );
  }
}
