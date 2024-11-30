import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Offers/View/offers_screen.dart';
import 'package:talents/Modules/Widgets/swaping_point.dart';

import 'offer_card.dart';

class OffersCarousal extends StatefulWidget {
  const OffersCarousal({
    super.key,
    required this.offersList,
  });

  final List offersList;

  @override
  State<OffersCarousal> createState() => _OffersCarousalState();
}

class _OffersCarousalState extends State<OffersCarousal> {
  int _currentindex = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.offersList.length > 1 ? 0 : 2.w),
      child: Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentindex = index;
                });
              },
              height: 22.h,
              enlargeCenterPage: true,
              autoPlay: widget.offersList.length > 1,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: widget.offersList.length > 1,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: widget.offersList.length < 2 ? 1 : 0.8,
            ),
            items: widget.offersList.map((offer) {
              return InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    pushTo(context: context, toPage: const OffersScreen());
                  },
                  child: OfferCard(
                    isHome: true,
                    offer: offer,
                  ));
            }).toList(),
          ),
          SizedBox(height: 1.5.h),
          SwappingPoint(
              length: widget.offersList.length,
              pageController: carouselController,
              currentIndex: _currentindex),
        ],
      ),
    );
  }
}
