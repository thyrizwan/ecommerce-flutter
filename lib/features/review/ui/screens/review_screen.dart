import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/review/data/models/view_review_response_model.dart';
import 'package:ecommerce/features/review/ui/controllers/view_review_controller.dart';
import 'package:ecommerce/features/review/ui/screens/create_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  final String productId;
  const ReviewScreen({super.key, required this.productId});
  static const String name = "/review-screen";

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    _initializeReviewScreen();
  }

  Future<void> _initializeReviewScreen() async {
    final sharedPrefs = SharedPreferenceHelper();
    if (await sharedPrefs.isLoggedIn()) {
      Get.find<ViewReviewController>().getReviewList(widget.productId);
    } else {
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
          'Reviews',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<ViewReviewController>().getReviewList(widget.productId);
        },
        child: GetBuilder<ViewReviewController>(
          builder: (controller) {
            if (controller.isInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.reviewList.isEmpty) {
              return const Center(child: Text('No reviews available.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.reviewList.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) =>
                        _buildReviewItem(controller.reviewList[index]),
                  ),
                ),
                _buildBottomSection(controller.reviewList.length),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            CreateReviewScreen.name,
            arguments: {
              'productId': widget.productId,
            },
          );
        },
        backgroundColor: AppColors.lightColor,
        child: const Icon(Icons.add, color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildReviewItem(ReviewModel model) {
    final user = model.user;
    final fullName = '${user?.firstName ?? 'Unknown'} ${user?.lastName ?? ''}'
        .trim(); // Handle null values

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFEEEEEE),
                radius: 20,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    model.comment ?? 'No comment',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildBottomSection(int reviewCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.snowyColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Reviews',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '($reviewCount)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
