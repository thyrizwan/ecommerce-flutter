import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/common/data/category_list_model.dart';
import 'package:ecommerce/features/common/ui/controllers/category_list_controller.dart';
import 'package:ecommerce/features/common/ui/controllers/main_bottom_nav_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/my_loading_indicator.dart';
import 'package:ecommerce/features/home/ui/controllers/home_banner_list_controller.dart';
import 'package:ecommerce/features/home/ui/widgets/app_bar_icon_button.dart';
import 'package:ecommerce/features/common/ui/widgets/category_item_widget.dart';
import 'package:ecommerce/features/home/ui/widgets/home_carousel_slider.dart';
import 'package:ecommerce/features/home/ui/widgets/home_section_header.dart';
import 'package:ecommerce/features/common/ui/widgets/item_card.dart';
import 'package:ecommerce/features/home/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProductSearchBar(
                controller: _searchBarController,
              ),
              const SizedBox(height: 16),
              GetBuilder<HomeBannerListController>(builder: (controller) {
                if (controller.isInProgress) {
                  return SizedBox(
                    height: 150,
                    child: MyLoadingIndicator(),
                  );
                }
                return HomeCarouselSlider(bannerList: controller.bannerList);
              }),
              const SizedBox(height: 8),
              HomeSectionHeader(
                title: 'Category',
                onTap: () {
                  Get.find<MainBottomNavBarController>().moveToCategory();
                },
              ),
              const SizedBox(height: 8),
              GetBuilder<CategoryListController>(builder: (controller) {
                if (controller.isInProgress) {
                  return SizedBox(
                    height: 80,
                    child: MyLoadingIndicator(),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _getCategoryList(controller.categoryList),
                  ),
                );
              }),
              const SizedBox(height: 16),
              HomeSectionHeader(
                title: 'Popular',
                onTap: () {},
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
              const SizedBox(height: 8),
              HomeSectionHeader(
                title: 'Special',
                onTap: () {},
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
              const SizedBox(height: 8),
              HomeSectionHeader(
                title: 'New Arrival',
                onTap: () {},
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getProductList(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'You reached the end.',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getCategoryList(List<CategoryListModel> categoryModel) {
    List<Widget> categoryList = [];
    for (int i = 0; i < categoryModel.length; i++) {
      categoryList.add(Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: CategoryItemWidget(categoryListModel: categoryModel[i]),
      ));
    }
    return categoryList;
  }

  List<Widget> _getProductList() {
    List<Widget> categoryList = [];
    for (int i = 0; i < 10; i++) {
      categoryList.add(Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: ProductItemWidget(),
      ));
    }
    return categoryList;
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.navbarLogoSvg),
      automaticallyImplyLeading: false,
      actions: [
        AppBarIconButton(
          icon: Icons.person,
          onTap: () {
            // TODO: need to implement
          },
        ),
        const SizedBox(width: 6),
        AppBarIconButton(
          icon: Icons.call_rounded,
          onTap: () {
            // TODO: need to implement
          },
        ),
        const SizedBox(width: 6),
        AppBarIconButton(
          icon: Icons.notifications_active,
          onTap: () {
            // TODO: need to implement
          },
        ),
      ],
    );
  }
}
