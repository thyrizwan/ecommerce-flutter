import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce/features/cart/ui/controllers/delete_from_cart_controller.dart';
import 'package:ecommerce/features/cart/ui/controllers/get_carted_product_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/common/ui/widgets/product_quantity_inc_dec_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({
    super.key,
    required this.cartItem,
    required this.onQuantityChange,
    required this.cartMasterItem,
    required this.onItemRemoved,
  });

  final CartItem cartMasterItem;
  final Product cartItem;
  final Function(int) onQuantityChange;
  final VoidCallback onItemRemoved;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.cartItem.quantity ?? 1;
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      _quantity = newQuantity;
    });
    widget.onQuantityChange(newQuantity);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 3,
      color: AppColors.snowyColor,
      child: Row(
        children: [
          Image.network(
            widget.cartItem.photos.isNotEmpty
                ? widget.cartItem.photos[0]
                : 'https://www.imrizwan.in/images/avatar.jpg',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cartItem.title,
                            maxLines: 1,
                            style: textTheme.titleMedium?.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Row(
                            children: [
                              Text('Color: Red'),
                              SizedBox(width: 8),
                              Text('Size: S'),
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _onCartItemRemoveTrigger(widget.cartMasterItem.id);
                      },
                      icon: const Icon(Icons.delete_outline),
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
                        '₹${(widget.cartItem.currentPrice * _quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: AppColors.softColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      ProductQuantityIncDecButton(
                        onChange: (int noOfItem) {
                          _updateQuantity(noOfItem);
                        },
                      )
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

  _onCartItemRemoveTrigger(String productId) async {
    DeleteFromCartController deleteCartController =
        Get.find<DeleteFromCartController>();
    bool isSuccess = await deleteCartController.deleteFromCart(productId);

    if (isSuccess) {
      widget.onItemRemoved();
      Get.find<GetCartedProductController>().getMyCartItem();
      MySnackBar.show(
        title: "Removed",
        message: 'Review created successfully',
        type: SnackBarType.success,
      );
    } else {
      MySnackBar.show(
        title: "Error Occurred",
        message: deleteCartController.errorMessage,
        type: SnackBarType.error,
      );
    }
  }
}
