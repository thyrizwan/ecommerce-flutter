import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/controllers/auth_controller.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_up_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_navigation_bar_screen.dart';
import 'package:ecommerce/features/common/ui/widgets/my_loading_indicator.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/home/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                const AppLogoWidget(),
                const SizedBox(height: 32),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    }),
                const SizedBox(height: 16),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.key),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Please enter your password';
                      }
                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      if (value.length > 40) {
                        return 'Password must be within 40 characters';
                      }
                      return null;
                    }),
                const SizedBox(height: 16),
                GetBuilder<AuthController>(builder: (controller) {
                  if (controller.inProgress) {
                    return const Center(
                      child: const MyLoadingIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: _onNextButtonPressed,
                        child: const Text('Log In'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (mounted) {
                            Navigator.pushNamed(
                              context,
                              SignUpScreen.name,
                            );
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              MainBottomNavigationBarScreen.name,
                              (_) => false,
                            );
                          }
                        },
                        child: const Text('Skip to Next'),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onNextButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      var currentData = {
        'email': _emailTEController.text,
        'password': _passwordTEController.text,
      };
      bool isSuccess = await _authController.login(currentData);
      if (isSuccess) {
        var userInfo = await SharedPreferenceHelper.getUserData();
        MySnackBar.show(
          title: "Login Successful",
          message: 'Welcome back! ${userInfo?.firstName} ${userInfo?.lastName}',
          type: SnackBarType.success,
        );
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainBottomNavigationBarScreen.name,
            (_) => false,
          );
        }
      } else {
        MySnackBar.show(
          title: "Login Failed",
          message: _authController.errorMessage,
          type: SnackBarType.error,
        );
      }
    }
  }
}
