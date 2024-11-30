import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Exams/models/result.dart';

class SuccessExamDialog extends StatelessWidget {
  const SuccessExamDialog({super.key, required this.result});
  final Result result;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'تهانينا لقد نجحت',
        textAlign: TextAlign.center,
        style: AppTextStyles.largeTitle,
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: Text('لقد حققت   ${result.studentPercentage?.toStringAsFixed(0)} / 100',
          textAlign: TextAlign.center,
          style: AppTextStyles.meduimTitle
              .copyWith(color: Colors.green, fontWeight: FontWeight.w500)),
      actions: [
        TextButton(
          style: TextButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: () => Navigator.pop(context),
          child: Text(
            'رؤية نتيجة الاختبار',
            style: AppTextStyles.meduimTitle.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
