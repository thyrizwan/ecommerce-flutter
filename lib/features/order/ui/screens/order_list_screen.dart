import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/order/ui/controllers/get_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  static const String name = '/order-list';

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    var sharedPref = SharedPreferenceHelper();
    _isLoggedIn = await sharedPref.isLoggedIn();
    if (_isLoggedIn) {
      await Get.find<GetOrderController>().fetchOrders();
    } else {
      MySnackBar.show(
          title: 'Please Logged In',
          type: SnackBarType.error,
          message: 'You are not logged in.');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: RefreshIndicator(onRefresh: () async {
        await Get.find<GetOrderController>().fetchOrders();
      }, child: GetBuilder<GetOrderController>(
        builder: (controller) {
          if (controller.isInProgress) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildShimmerBox(double.infinity, 150),
                  const SizedBox(height: 10),
                  _buildShimmerBox(double.infinity, 150),
                ],
              ),
            );
          }
          if (controller.orders.isEmpty && _isLoggedIn) {
            return const Center(child: Text('No Orders Found'));
          }
          return _isLoggedIn
              ? ListView.builder(
                  itemCount: controller.orders.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: AppColors.snowyColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '# ${order.id}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: order.status == 'pending'
                                        ? Colors.green.shade200
                                        : Colors.green.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    order.status == 'pending'
                                        ? 'Order Placed'
                                        : 'Delivered',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: order.status == 'pending'
                                          ? Colors.green.shade900
                                          : Colors.green.shade900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.monetization_on,
                                        color: Colors.green, size: 20),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Total: ₹${order.totalPrice}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.payment,
                                        color: Colors.blue, size: 20),
                                    const SizedBox(width: 6),
                                    Text(
                                        'Payment: ${order.paymentMethod?.toUpperCase()}'),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.shopping_cart,
                                    color: Colors.purple, size: 20),
                                const SizedBox(width: 6),
                                Text('Items: ${order.totalItems}'),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.local_shipping,
                                    color: Colors.redAccent, size: 20),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Shipping: ${order.shippingAddress?.fullName}, ${order.shippingAddress?.address}, ${order.shippingAddress?.city} - ${order.shippingAddress?.postalCode}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: Colors.teal, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                    'Ordered On: ${order.createdAt?.year}-${order.createdAt?.month}-${order.createdAt?.day} '
                                    '${order.createdAt?.hour}:${order.createdAt?.minute}',
                                    style: const TextStyle(color: Colors.blueGrey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You are not logged in!",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignInScreen.name);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Login Now"),
                        ),
                      ],
                    ),
                  ),
                );
        },
      )),
    );
  }

  Widget _buildShimmerBox(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
