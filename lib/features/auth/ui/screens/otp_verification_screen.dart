import 'dart:async';

import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
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
  int _secondsRemaining = 60;
  bool _enableResend = false;
  Timer? _timer;

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
                Text(
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
                  animationDuration: Duration(milliseconds: 300),
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
                ElevatedButton(
                  onPressed: _onOtpButtonPressed,
                  child: const Text('Next'),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    !_enableResend
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ), // Clock icon
                              const SizedBox(width: 8),
                              RichText(
                                text: TextSpan(
                                  text: 'Resend? Wait: ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '$_secondsRemaining seconds',
                                      style: TextStyle(
                                        color: AppColors.darkColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : TextButton.icon(
                            onPressed: _resendCode,
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.blue,
                            ), // Refresh icon
                            label: Text(
                              'Resend Code',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onOtpButtonPressed() {
    if (_formKey.currentState!.validate()) {
      print('OTP: ${_otpController.text}');
    }
  }

  void _resendCode() {
    setState(() {
      _secondsRemaining = 60;
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
