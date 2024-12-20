import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData get lightThemeData {
    return ThemeData(
      colorSchemeSeed: AppColors.primaryColor,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.softColor),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
        colorSchemeSeed: AppColors.primaryColor,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: AppColors.lightColor),
        // scaffoldBackgroundColor: Colors.grey.shade900,
        brightness: Brightness.dark);
  }
}
