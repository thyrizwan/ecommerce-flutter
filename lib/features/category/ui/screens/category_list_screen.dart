import 'package:ecommerce/features/category/ui/widgets/category_list_screen_shimmer_effects_widgets.dart';
import 'package:ecommerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  static const String name = '/category-screen';

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category List'),
          leading: IconButton(
            onPressed: _onPop,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CategoryListController>().getCategoryList();
          },
          child: GetBuilder<CategoryListController>(builder: (controller) {
            if (controller.isInProgress) {
              return CategoryListScreenShimmerEffectsWidget();
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                  itemCount: controller.categoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryItemWidget(
                        categoryListModel: controller.categoryList[index]);
                  }),
            );
          }),
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainBottomNavBarController>().backToHome();
  }
}
