import 'package:ecommerce/app/app_theme_data.dart';
import 'package:ecommerce/app/controller_binder.dart';
import 'package:ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:ecommerce/features/category/ui/screens/category_list_screen.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_navigation_bar_screen.dart';
import 'package:ecommerce/features/home/ui/screens/home_screen.dart';
import 'package:ecommerce/features/product/ui/screens/product_details_screen.dart';
import 'package:ecommerce/features/product/ui/screens/product_list_screen.dart';
import 'package:ecommerce/features/review/ui/screens/create_review_screen.dart';
import 'package:ecommerce/features/review/ui/screens/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TruShop extends StatelessWidget {
  const TruShop({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      // themeMode: ThemeMode.dark,
      initialBinding: ControllerBinder(),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        // Widget widget = _myRouteMap(settings);
        late Widget widget;
        switch (settings.name) {
          case SplashScreen.name:
            widget = const SplashScreen();
          case SignInScreen.name:
            widget = const SignInScreen();
          case EmailVerificationScreen.name:
            widget = const EmailVerificationScreen();
          case OtpVerificationScreen.name:
            widget = const OtpVerificationScreen();
          case CompleteProfileScreen.name:
            widget = const CompleteProfileScreen();
          case HomeScreen.name:
            widget = const HomeScreen();
          case MainBottomNavigationBarScreen.name:
            widget = const MainBottomNavigationBarScreen();
          case CategoryListScreen.name:
            widget = const CategoryListScreen();
          case ProductListScreen.name:
            String name = settings.arguments as String;
            widget = ProductListScreen(
              categoryName: name,
            );
          case ReviewScreen.name:
            widget = const ReviewScreen();
          case CreateReviewScreen.name:
            widget = const CreateReviewScreen();
          case ProductDetailsScreen.name:
            int productId = settings.arguments as int;
            widget = ProductDetailsScreen(productId: productId);
          default:
            widget = const HomeScreen();
        }
        return MaterialPageRoute(builder: (ctx) {
          return widget;
        });
      },
    );
  }

  Widget _myRouteMap(settings) {
    switch (settings.name) {
      case SignInScreen.name:
        return const SignInScreen();
      case EmailVerificationScreen.name:
        return const EmailVerificationScreen();
      case OtpVerificationScreen.name:
        return const OtpVerificationScreen();
      case CompleteProfileScreen.name:
        return const CompleteProfileScreen();
      case HomeScreen.name:
        return const HomeScreen();
      case MainBottomNavigationBarScreen.name:
        return const MainBottomNavigationBarScreen();
      case CategoryListScreen.name:
        return const CategoryListScreen();
      case ProductListScreen.name:
        String name = settings.arguments as String;
        return ProductListScreen(
          categoryName: name,
        );
      default:
        return const HomeScreen();
    }
  }
}
