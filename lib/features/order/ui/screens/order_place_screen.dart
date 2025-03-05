import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/order/data/model/shipping_address_model.dart';
import 'package:ecommerce/features/order/ui/controllers/place_order_controller.dart';
import 'package:ecommerce/features/order/ui/screens/order_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPlaceScreen extends StatefulWidget {
  const OrderPlaceScreen({super.key});

  static const String name = '/order-place';

  @override
  _OrderPlaceScreenState createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final PlaceOrderController placeOrderController =
      Get.put(PlaceOrderController());

  String? selectedPaymentMethod;
  final List<String> paymentMethods = ["cod", "upi", "card"];

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Place Order")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedPaymentMethod,
                  decoration:
                      InputDecoration(labelText: "Select Payment Method"),
                  items: paymentMethods.map((String method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Text(method.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a payment method" : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: fullNameController,
                  decoration: InputDecoration(labelText: "Full Name"),
                  validator: (value) =>
                      value!.isEmpty ? "Enter full name" : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: addressController,
                  decoration: InputDecoration(labelText: "Address"),
                  validator: (value) => value!.isEmpty ? "Enter address" : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: cityController,
                  decoration: InputDecoration(labelText: "City"),
                  validator: (value) => value!.isEmpty ? "Enter city" : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                    controller: postalCodeController,
                    decoration: InputDecoration(labelText: "Postal Code"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter postal code";
                      }
                      if (value.length != 6) {
                        return "Postal Code should be 6 digits";
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: phoneController,
                    decoration: InputDecoration(labelText: "Phone Number"),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter phone number";
                      }
                      if (value.length < 10) {
                        return "Phone number should be at least 10 digits long";
                      }
                      return null;
                    }),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onPlaceOrderButtonPressed,
                    child: Text("Place Order"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onPlaceOrderButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      var prefs = SharedPreferenceHelper();
      if (await prefs.isLoggedIn()) {
        Map<String, dynamic> requestBody = {
          "payment_method": "cod",
          "shipping_address": ShippingAddressModel(
            fullName: fullNameController.text.trim(),
            address: addressController.text.trim(),
            city: cityController.text.trim(),
            postalCode: postalCodeController.text,
            phone: phoneController.text,
          ).toJson(),
        };

        bool success = await placeOrderController.placeOrder(requestBody);

        if (success) {
          MySnackBar.show(
            title: "Order Placed",
            message: 'Order Placed Successfully.',
            type: SnackBarType.success,
          );
          if (mounted) {
            Navigator.pushNamed(context, OrderListScreen.name);
          }
        } else {
          MySnackBar.show(
            title: "Error Occured",
            message: 'Error: ${placeOrderController.errorMessage}',
            type: SnackBarType.error,
          );
        }
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
  }
}
