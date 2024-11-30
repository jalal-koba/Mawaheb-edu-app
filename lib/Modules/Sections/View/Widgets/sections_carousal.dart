import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Modules/Home/Cubit/cubit/home_cubit.dart';
import 'package:talents/Modules/Widgets/section_card.dart'; 
import 'package:talents/Modules/Widgets/swaping_point.dart';

class SectionsCarousal extends StatefulWidget {
  const SectionsCarousal({
    super.key,
    required this.homeCubit,
  });
  final HomeCubit homeCubit;
  @override
  State<SectionsCarousal> createState() => _SectionsCarousalState();
}

class _SectionsCarousalState extends State<SectionsCarousal> {
  int _currentindex = 0;
  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    int length = widget.homeCubit.sections.length;
    return Column(
      children: [
        CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentindex = index;
                });
              },
              height: 20.h,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
            ),
            items: [
              for (int i = 0; i < length; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: SectionCard(section: widget.homeCubit.sections[i]),
                    ),
                    if (widget.homeCubit.sections.length != 1)
                      Expanded(
                          child: SectionCard(
                        section: i + 1 != widget.homeCubit.sections.length
                            ? context.read<HomeCubit>().sections[i + 1]
                            : widget.homeCubit.sections[0],
                      ))
                  ],
                )
            ]),
        SizedBox(height: 1.5.h),
        SwappingPoint(
            length: (widget.homeCubit.sections.length / 2).ceil(),
            pageController: carouselController,
            currentIndex: _currentindex),
      ],
    );
  }
}
