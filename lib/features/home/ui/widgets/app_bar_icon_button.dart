import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: AppColors.lightColor,
        radius: 16,
        child: Icon(icon, size: 18, color: AppColors.babyColor),
      ),
    );
  }
}
