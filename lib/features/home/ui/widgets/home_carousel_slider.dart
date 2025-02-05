import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
  });

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  late List<int> _myList = [];

  @override
  void initState() {
    super.initState();
    _myList = [1, 2, 3];
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
          items: _myList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: AppColors.snowyColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Carousel $i',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
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
                for (int i = 0; i < _myList.length; i++)
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
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
    _myList;
    super.dispose();
  }
}
