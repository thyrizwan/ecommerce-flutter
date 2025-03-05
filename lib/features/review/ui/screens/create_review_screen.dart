import 'dart:math';

import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/review/ui/controllers/create_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  final String productId;

  const CreateReviewScreen({super.key, required this.productId});

  static const String name = "/create-review-screen";

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeReviewScreen();
  }

  Future<void> _initializeReviewScreen() async {
    final sharedPrefs = SharedPreferenceHelper();
    if (!await sharedPrefs.isLoggedIn()) {
      MySnackBar.show(
        title: "Login Needed",
        message: 'You need to login to perform this action',
        type: SnackBarType.error,
      );
      if (mounted) {
        Navigator.pushNamed(context, SignInScreen.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Review',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Review",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4.0),
                        TextFormField(
                          controller: _reviewController,
                          decoration: InputDecoration(
                            hintText: "Write Review",
                          ),
                          maxLines: 7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _onSubmit(widget.productId);
                  },
                  child: Text("Submit Review"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit(String productId) async {
    if (_formKey.currentState!.validate()) {
      var tempData = {
        "product": productId,
        "comment": _reviewController.text.trim(),
        "rating": 1 + Random().nextInt((5 - 1) + 1)
      };
      CreateReviewController createReviewController =
          Get.find<CreateReviewController>();
      bool isSuccess = await createReviewController.createReview(tempData);

      if (isSuccess) {
        MySnackBar.show(
          title: "Review Created",
          message: 'Review created successfully',
          type: SnackBarType.success,
        );
        _reviewController.text = '';
      } else {
        MySnackBar.show(
          title: "Login Failed",
          message: createReviewController.errorMessage,
          type: SnackBarType.error,
        );
      }
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
