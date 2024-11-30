import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart'; 
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Exams/View/widgets/time_formater.dart';

class TimerWidget extends StatefulWidget {
  final num seconds;

  const TimerWidget({
    required this.seconds,
    super.key,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late num currentTime;
  @override
  void initState() {
    currentTime = widget.seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (currentTime == 0) {
        _timer.cancel();
      } else {
        currentTime = currentTime - 1;
        if (mounted) setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      width: 100.w,
      alignment: Alignment.center,
      color: currentTime != 0 ? Colors.green[400] : Colors.pink[100],
      child: Text(
        currentTime != 0
            ? formatTime(currentTime)
            : "سيتم تقديم الاختبار مع تخطي المدة المحددة",
        style: AppTextStyles.meduimTitle.copyWith(fontSize: 12.sp,
          color: currentTime != 0 ? Colors.white : Colors.red,
        ),
      ),
    );
  }
}
