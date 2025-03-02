import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:flutter/material.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 3,
      color: AppColors.snowyColor,
      child: Row(
        children: [
          Image.asset(
            AssetsPath.itemImagePath,
            width: 90,
            height: 90,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'PRODUCT name Will be print here, you can write',
                            maxLines: 1,
                            style: textTheme.titleMedium?.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text('Color: Red'),
                              const SizedBox(width: 8),
                              Text('Size: S'),
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹100',
                        style: TextStyle(
                            color: AppColors.softColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      ProductQuantityIncDecButton(onChange: (int noOfItem) {})
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}