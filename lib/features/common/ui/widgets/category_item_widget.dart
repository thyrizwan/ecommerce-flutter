import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/common/data/model/category_list_model.dart';
import 'package:ecommerce/features/product/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.categoryListModel,
  });

  final CategoryListModel categoryListModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: {
            'categoryName': categoryListModel.title,
            'categoryId': categoryListModel.sId
          },
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.snowyColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.network(
              categoryListModel.icon ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            categoryListModel.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                // letterSpacing: 1,
                color: AppColors.secondaryColor.withOpacity(0.75),
                overflow: TextOverflow.visible),
          ),
        ],
      ),
    );
  }
}
