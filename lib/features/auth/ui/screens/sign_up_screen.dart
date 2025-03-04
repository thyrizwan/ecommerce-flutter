import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/controllers/auth_controller.dart';
import 'package:ecommerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:ecommerce/features/common/ui/widgets/my_loading_indicator.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/home/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              const AppLogoWidget(
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 22),
              Text(
                'Complete Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Get started with us along with your new profile',
                style: TextStyle(
                  color: AppColors.darkColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              _buildForm(),
              const SizedBox(height: 16),
              GetBuilder<AuthController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(
                    child: const MyLoadingIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: _onOtpButtonPressed,
                  child: const Text('Register Now'),
                );
              }),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _firstNameTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'First Name is required';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              hintText: 'First Name',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Last Name is required';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              hintText: 'Last Name',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _phoneNumberTEController,
            keyboardType: TextInputType.phone,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Phone No. is required';
              }
              if (value?.length != 10) {
                return 'Minimum 10 digits';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              hintText: 'Mobile No.',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return 'Please enter a valid email';
                }
                return null;
              }),
          const SizedBox(height: 8),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passwordTEController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
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
          const SizedBox(height: 8),
          TextFormField(
            controller: _cityTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'City is required';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              hintText: 'City',
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Future<void> _onOtpButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      var userData = {
        "first_name": _firstNameTEController.text.trim(),
        "last_name": _lastNameTEController.text.trim(),
        "email": _emailTEController.text.trim(),
        "phone": _phoneNumberTEController.text,
        "city": _cityTEController.text.trim(),
        "password": _passwordTEController.text,
      };
      bool isSuccess = await _authController.signUp(userData);
      if (isSuccess) {

        MySnackBar.show(
          title: "OTP Send",
          message: _authController.tempData['msg'],
          type: SnackBarType.success,
        );
        if (mounted) {
          Navigator.pushNamed(
            context,
            OtpVerificationScreen.name,
          );
        }
      } else {
        MySnackBar.show(
          title: "Signup Failed",
          message: _authController.errorMessage,
          type: SnackBarType.error,
        );
      }
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _cityTEController.dispose();
    _phoneNumberTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
