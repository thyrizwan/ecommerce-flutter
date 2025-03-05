import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/home/data/model/banner_list_model.dart';
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
    required this.bannerList,
  });

  final List<BannerListModel> bannerList;

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayCurve: Curves.fastOutSlowIn,
              height: 150.0,
              viewportFraction: 0.95,
              onPageChanged: (currentIndex, reason) {
                _selectedIndex.value = currentIndex;
              }),
          items: widget.bannerList.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: AppColors.snowyColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print("Image clicked!");
                        print(banner.sId);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                banner.photoUrl ?? '',
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/images/img.png');
                                },
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.bannerList.length; i++)
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      color: value == i
                          ? AppColors.babyColor
                          : AppColors.snowyColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
              ],
            );
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
