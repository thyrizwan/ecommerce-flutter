import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(
          fontSize: 14,
          color: AppColors.babyColor,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.babyColor,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.snowyColor,
      ),
    );
  }
}
