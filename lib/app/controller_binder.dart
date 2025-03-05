import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/controllers/auth_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/home_screen_product_list_by_category_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/product_list_by_category_controller.dart';
import 'package:ecommerce/features/home/ui/controllers/home_banner_list_controller.dart';
import 'package:ecommerce/features/product/ui/controllers/single_product_info_controller.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavBarController());
    Get.put(NetworkCaller());
    Get.put(AuthController());
    Get.put(SharedPreferenceHelper());
    Get.put(HomeBannerListController());
    Get.put(CategoryListController());
    Get.put(HomeScreenProductListByCategoryController());
    Get.put(ProductListByCategoryController());
    Get.put(SingleProductInfoController());
  }
}
