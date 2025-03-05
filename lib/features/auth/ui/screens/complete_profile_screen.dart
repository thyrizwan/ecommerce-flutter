import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  static const String name = '/complete-profile';

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();

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
              ElevatedButton(
                onPressed: _onOtpButtonPressed,
                child: const Text('Complete Profile'),
              ),
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
          TextFormField(
            maxLines: 4,
            controller: _shippingAddressTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Shipping Address is required';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              hintText: 'Shipping Address',
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  _onOtpButtonPressed() {
    if (_formKey.currentState!.validate()) {
      // TODO: need to implement
      // print('First Name: ${_firstNameTEController.text}');
      // print('Last Name: ${_lastNameTEController.text}');
      // print('Phone No.: ${_phoneNumberTEController.text}');
      // print('City: ${_cityTEController.text}');
      // print('Shipping Address: ${_shippingAddressTEController.text}');
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _cityTEController.dispose();
    _phoneNumberTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }
}
