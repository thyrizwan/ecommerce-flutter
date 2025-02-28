import 'package:ecommerce/features/common/ui/widgets/item_card.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {

  static const String name = '/product/product-list-by-category';

  const ProductListScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
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
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.98,
            crossAxisSpacing: 1
          ),
          itemCount: 30,
          itemBuilder: (context, index) {
            return ProductItemWidget();
          },
        ),
      ),
    );
  }
}
