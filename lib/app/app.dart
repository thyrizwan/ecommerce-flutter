import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_theme_data.dart';
import 'package:ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class TruShop extends StatelessWidget {
  const TruShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      // themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const SplashScreen(),
      },
    );
  }
}
