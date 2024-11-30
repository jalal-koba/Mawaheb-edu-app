import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';

class OrderState extends StatelessWidget {
  OrderState({
    super.key,
    required this.state,
  });
  final String state;
  final Map<String, Color> colors = {
    "rejected": const Color.fromARGB(122, 244, 67, 54),
    "accepted": const Color.fromARGB(129, 76, 175, 79),
    "pending": const Color.fromARGB(130, 255, 235, 59)
  };

  final Map<String, String> stateText = {
    "rejected": "ملغى",
    "accepted": "موافق عليه",
    "pending": "قيد الانتظار"
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: colors[state]),
      child: Text(
        stateText[state]!,
        style: AppTextStyles.secondTitle,
      ),
    );
  }
}
