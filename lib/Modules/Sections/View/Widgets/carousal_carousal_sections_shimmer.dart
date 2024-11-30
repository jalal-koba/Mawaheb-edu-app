import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';
import 'package:talents/Modules/Widgets/custom_shimmer_card.dart';
import 'package:talents/Modules/Widgets/swaping_point.dart';

class CarousalCarousalSectionsShimmer extends StatelessWidget {
  const CarousalCarousalSectionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {},
              height: 20.h,
              enlargeCenterPage: true,
              autoPlay: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
            ),
            items: const [
              Row(
                children: <Widget>[
                  Expanded(child: CustomShimmerCard()),
                  Expanded(child: CustomShimmerCard()),
                ],
              )
            ]),
        SizedBox(height: 1.5.h),
        AppShimmer(
          child: SwappingPoint(
              length: 3, pageController: PageController(), currentIndex: 1),
        ),
      ],
    );
  }
}
