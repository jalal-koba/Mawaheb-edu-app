import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';
import 'package:talents/Modules/Widgets/swaping_point.dart';

class CarousalOffersShimmer extends StatelessWidget {
  const CarousalOffersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {},
                height: 22.h,
                enlargeCenterPage: true,
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                )
              ]),
          SizedBox(height: 1.5.h),
          SwappingPoint(
              length: 3, pageController: PageController(), currentIndex: 1),
        ],
      ),
    );
  }
}
