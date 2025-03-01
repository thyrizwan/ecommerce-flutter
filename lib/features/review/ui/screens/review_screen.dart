import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/review/ui/screens/create_review_screen.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  static const String name = "/review-screen";

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
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
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 4,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => _buildReviewItem(),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateReviewScreen.name);
        },
        backgroundColor: AppColors.lightColor,
        child: const Icon(Icons.add, color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildReviewItem() {
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
              const Text(
                'Rizwan Ansari',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
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
            '(1000)',
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
