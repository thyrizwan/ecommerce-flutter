import 'package:ecommerce/app/app_theme_data.dart';
import 'package:ecommerce/app/controller_binder.dart';
import 'package:ecommerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_navigation_bar_screen.dart';
import 'package:ecommerce/features/home/ui/screens/home_screen.dart';
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
      routes: <String, WidgetBuilder>{
        '/': (context) => const SplashScreen(),
        SignInScreen.name: (context) => const SignInScreen(),
        EmailVerificationScreen.name: (context) =>
            const EmailVerificationScreen(),
        OtpVerificationScreen.name: (context) => const OtpVerificationScreen(),
        CompleteProfileScreen.name: (context) => const CompleteProfileScreen(),
        HomeScreen.name: (context) => const HomeScreen(),
        MainBottomNavigationBarScreen.name : (context) => const MainBottomNavigationBarScreen(),
      },
    );
  }
}
