import 'package:ecommerce/app/app_theme_data.dart';
import 'package:ecommerce/app/controller_binder.dart';
import 'package:ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_up_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:ecommerce/features/category/ui/screens/category_list_screen.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_navigation_bar_screen.dart';
import 'package:ecommerce/features/home/ui/screens/home_screen.dart';
import 'package:ecommerce/features/order/ui/screens/order_list_screen.dart';
import 'package:ecommerce/features/order/ui/screens/order_place_screen.dart';
import 'package:ecommerce/features/product/ui/screens/product_details_screen.dart';
import 'package:ecommerce/features/product/ui/screens/product_list_screen.dart';
import 'package:ecommerce/features/profile/ui/screens/profile_menu_list_screen.dart';
import 'package:ecommerce/features/review/ui/screens/create_review_screen.dart';
import 'package:ecommerce/features/review/ui/screens/review_screen.dart';
import 'package:ecommerce/features/wishlist/ui/screens/wish_list_screen.dart';
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
        late Widget widget;
        switch (settings.name) {
          case SplashScreen.name:
            widget = const SplashScreen();
            break;
          case SignInScreen.name:
            widget = const SignInScreen();
            break;
          case SignUpScreen.name:
            widget = const SignUpScreen();
            break;
          case EmailVerificationScreen.name:
            widget = const EmailVerificationScreen();
            break;
          case OtpVerificationScreen.name:
            widget = const OtpVerificationScreen();
            break;
          case CompleteProfileScreen.name:
            widget = const CompleteProfileScreen();
            break;
          case HomeScreen.name:
            widget = const HomeScreen();
            break;
          case MainBottomNavigationBarScreen.name:
            widget = const MainBottomNavigationBarScreen();
            break;
          case CategoryListScreen.name:
            widget = const CategoryListScreen();
            break;
          case ProductListScreen.name:
            if (settings.arguments is Map<String, dynamic> &&
                (settings.arguments as Map<String, dynamic>)['categoryName'] !=
                    null &&
                (settings.arguments as Map<String, dynamic>)['categoryId'] !=
                    null) {
              final args = settings.arguments as Map<String, dynamic>;

              widget = ProductListScreen(
                categoryName: args['categoryName']!,
                categoryId: args['categoryId']!,
              );
            } else {
              widget = const MainBottomNavigationBarScreen();
            }
            break;
          case ReviewScreen.name:
            if (settings.arguments is Map<String, dynamic>) {
              final args = settings.arguments as Map<String, dynamic>;
              final productId = args['productId'] as String;
              widget = ReviewScreen(productId: productId);
            } else {
              widget = const MainBottomNavigationBarScreen();
            }
            break;
          case CreateReviewScreen.name:
            if (settings.arguments is Map<String, dynamic>) {
              final args = settings.arguments as Map<String, dynamic>;
              final productId = args['productId'] as String;
              widget = CreateReviewScreen(productId: productId);
            } else {
              widget = const MainBottomNavigationBarScreen();
            }
            break;
          case ProductDetailsScreen.name:
            if (settings.arguments is String) {
              widget =
                  ProductDetailsScreen(productId: settings.arguments as String);
            } else {
              widget = const MainBottomNavigationBarScreen();
            }
            break;
          case WishListScreen.name:
            widget = const WishListScreen();
            break;
          case CreateReviewScreen.name:
            if (settings.arguments is String) {
              widget =
                  CreateReviewScreen(productId: settings.arguments as String);
            } else {
              widget = const MainBottomNavigationBarScreen();
            }
            break;
          case ReviewScreen.name:
            if (settings.arguments is String) {
              widget = ReviewScreen(productId: settings.arguments as String);
            } else {
              widget = const MainBottomNavigationBarScreen();
            }
            break;
          case OrderPlaceScreen.name:
            widget = const OrderPlaceScreen();
            break;
          case OrderListScreen.name:
            widget = const OrderListScreen();
            break;
          case ProfileMenuListScreen.name:
            widget = const ProfileMenuListScreen();
            break;
          default:
            widget = const MainBottomNavigationBarScreen();
            break;
        }
        return MaterialPageRoute(builder: (ctx) => widget);
      },
    );
  }
}
