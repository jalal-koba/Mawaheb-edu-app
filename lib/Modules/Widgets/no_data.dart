import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';

class Nodata extends StatefulWidget {
  const Nodata({
    super.key,
  });

  @override
  State<Nodata> createState() => _NodataState();
}

class _NodataState extends State<Nodata> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1,),) ;
    _animation = Tween<double>(begin: 0.1, end: 1).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Image.asset(Images.noData,
                    height: 33.h + (2.h * _animation.value));
              }),
          const SizedBox(
            width: double.infinity,
          ),
          Text(
            'لا يوجد بيانات !',
            style: AppTextStyles.meduimTitle
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
