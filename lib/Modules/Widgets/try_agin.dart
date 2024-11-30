import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';

class TryAgain extends StatefulWidget {
  const TryAgain({
    super.key,
    required this.onTap,
    this.small = false,
    this.withImage = true,
    required this.message,
  });
  final Function()? onTap;
  final String message;
  final bool small;
  final bool withImage;

  @override
  State<TryAgain> createState() => _TryAgainState();
}

class _TryAgainState extends State<TryAgain>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      upperBound: 0.05,
      lowerBound: -0.05,
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Start repeating the animation (continuous rotation)
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.withImage)
            RotationTransition(
              turns: _controller,
              child: Image.asset(
                Images.error,
                width: widget.small ? 35.w : 60.w,
              ),
            ),
          SizedBox(height: widget.small ? 2.h : 5.h),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: AppTextStyles.meduimTitle.copyWith(
                color: const Color.fromARGB(255, 0, 55, 106),
                fontSize: widget.small ? 11.sp : null),
          ),
          SizedBox(height: widget.small ? 2.h : 5.h),
          CustomButton(
              width: widget.small ? 30 : 40,
              height: widget.small ? 4 : 5,
              fontSize: 11,
              titlebutton: "أعد المحاولة",
              onPressed: widget.onTap)
        ],
      ),
    );
  }
}
