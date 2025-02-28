import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/product/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: 'Computer',
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
            child: Icon(
              Icons.computer,
              color: AppColors.secondaryColor.withOpacity(0.75),
              size: 40,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Electronics',
            style: TextStyle(
              fontSize: 14,
              // letterSpacing: 1,
              color: AppColors.secondaryColor.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }
}
