import 'dart:async';

import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/app_constant.dart';
import 'package:ecommerce/features/auth/ui/controllers/auth_controller.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_navigation_bar_screen.dart';
import 'package:ecommerce/features/common/ui/widgets/my_loading_indicator.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  static const String name = '/otp-verification';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find<AuthController>();
  int _secondsRemaining = AppConstants.resendOtpTimeoutSeconds;
  bool _enableResend = false;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _enableResend = true;
        });
        _timer?.cancel();
      }
    });
  }

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
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text(
                  'We have sent a code to your email',
                  style: TextStyle(
                    color: AppColors.darkColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeColor: AppColors.primaryColor,
                      inactiveColor: AppColors.lightColor),
                  animationDuration: const Duration(milliseconds: 300),
                  // backgroundColor: Colors.blue.shade50,
                  // enableActiveFill: true,
                  // errorAnimationController: errorController,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(height: 16),
                GetBuilder<AuthController>(builder: (controller) {
                  if (controller.inProgress) {
                    return const Center(
                      child: MyLoadingIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: _onOtpButtonPressed,
                    child: const Text('Next'),
                  );
                }),
                const SizedBox(height: 32),
                Column(
                  children: [
                    !_enableResend
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              RichText(
                                text: TextSpan(
                                  text: 'Resend? Wait: ',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '$_secondsRemaining seconds',
                                      style: const TextStyle(
                                        color: AppColors.softColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : TextButton.icon(
                            onPressed: _resendCode,
                            icon: const Icon(
                              Icons.refresh,
                              color: AppColors.softColor,
                            ), // Refresh icon
                            label: const Text(
                              'Resend Code',
                              style: TextStyle(
                                color: AppColors.softColor,
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onOtpButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await _authController.verifyOtp(_otpController.text);
      if (isSuccess) {
        if (_authController.shouldNavigate) {
          MySnackBar.show(
            title: "OTP Verified",
            message: 'You have successfully created a new new account.',
            type: SnackBarType.success,
          );
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainBottomNavigationBarScreen.name,
              (_) => false,
            );
          }
        }
      } else {
        MySnackBar.show(
          title: "Verification Failed",
          message: _authController.errorMessage,
          type: SnackBarType.error,
        );
      }
    }
  }

  void _resendCode() {
    setState(() {
      _secondsRemaining = AppConstants.resendOtpTimeoutSeconds;
      _enableResend = false;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
