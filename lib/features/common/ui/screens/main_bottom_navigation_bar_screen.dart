import 'package:ecommerce/features/cart/ui/screens/cart_list_screen.dart';
import 'package:ecommerce/features/category/ui/screens/category_list_screen.dart';
import 'package:ecommerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/home_screen_product_list_by_category_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/home/ui/controllers/home_banner_list_controller.dart';
import 'package:ecommerce/features/home/ui/screens/home_screen.dart';
import 'package:ecommerce/features/order/ui/controllers/get_order_controller.dart';
import 'package:ecommerce/features/order/ui/screens/order_list_screen.dart';
import 'package:ecommerce/features/wishlist/ui/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavigationBarScreen extends StatefulWidget {
  const MainBottomNavigationBarScreen({super.key});

  static const String name = '/main-bottom-navigation-bar';

  @override
  State<MainBottomNavigationBarScreen> createState() =>
      _MainBottomNavigationBarScreenState();
}

class _MainBottomNavigationBarScreenState
    extends State<MainBottomNavigationBarScreen> {
  final HomeBannerListController _homeBannerListController =
      Get.find<HomeBannerListController>();

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryListScreen(),
    CartListScreen(),
    WishListScreen(),
    OrderListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _homeBannerListController.getHomeBannerList();
    Get.find<CategoryListController>().getCategoryList();
    Get.find<HomeScreenProductListByCategoryController>()
        .getProductByCategoryList();
    Get.find<GetOrderController>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavBarController>(
        builder: (bottomNavBarController) {
      return Scaffold(
        body: _screens[bottomNavBarController.selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: bottomNavBarController.selectedIndex,
          onDestinationSelected: bottomNavBarController.changeIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.category), label: 'Categories'),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            NavigationDestination(
                icon: Icon(Icons.favorite_border), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Icons.checklist), label: 'Orders'),
          ],
        ),
      );
    });
  }
}
