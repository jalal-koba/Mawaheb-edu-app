import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Exams/cubit/exams_cubit.dart';
import 'package:talents/Modules/Exams/cubit/exams_state.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    required this.examsCubit,
    required this.onTryAgain,
    required this.state,
  });

  final ExamsCubit examsCubit;

  final SubmitExamSuccessState state;
  final void Function() onTryAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${state.result}/100",
          style: AppTextStyles.meduimTitle.copyWith(fontSize: 18.sp),
        ),
        Text(
          'لقد فشلت ):',
          style: AppTextStyles.meduimTitle.copyWith(fontSize: 18.sp),
        ),
        SizedBox(height: 3.h),
        CustomButton(
          margin: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          width: 96,
          onPressed: onTryAgain,
          titlebutton: "أعد المحاولة",
        ),
      ],
    );
  }
}
