 import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart'; 

class SwappingPoint extends StatelessWidget {
  const SwappingPoint({
    super.key,
    required this.length,
    required this.pageController,
    required this.currentIndex,
  });

  final pageController;
  final int currentIndex;
  final int length;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            padding: const EdgeInsets.all(2),
            width: index == currentIndex ? 20 : 9,
            height: 9,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                color: index == currentIndex
                    ? AppColors.primary
                    : AppColors.superLightBlue,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white70,
                    offset:   Offset(0, 0.5),
                    blurRadius: 1.5,
                    spreadRadius: 1,
                  )
                ],
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ),
    );
  }
}
