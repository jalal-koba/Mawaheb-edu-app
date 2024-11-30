import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Courses/Cubit/Cubit/course_cubit.dart';
import 'package:talents/Modules/Courses/View/Widgets/Payment_Dialogs/transaction_image_dialog.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';

class AfterDiscountDialog extends StatefulWidget {
  final CourseCubit oneCourseCubit;
  const AfterDiscountDialog({
    super.key,
    required this.oneCourseCubit,
  });

  @override
  State<AfterDiscountDialog> createState() => _AfterDiscountDialogState();
}

class _AfterDiscountDialogState extends State<AfterDiscountDialog> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      'كود الحسم : ${widget.oneCourseCubit.discountCont.text}',
                      style: AppTextStyles.secondTitle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold), // expanded
                    ),
                  ),
                  Text(
                    '${widget.oneCourseCubit.discountResponse.couponDiscountPercentage} %',
                    style: AppTextStyles.secondTitle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox()
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                'سعر الكورس بعد الحسم :',
                style: AppTextStyles.secondTitle
                    .copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${widget.oneCourseCubit.discountResponse.beforeDiscount} ل س',
                    style: AppTextStyles.secondTitle.copyWith(
                        color: Colors.red,
                        fontSize: 12.sp,
                        fontFamily: "s",
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red),
                  ),
                  Text(
                    '${widget.oneCourseCubit.discountResponse.afterDiscount} ل س',
                    style: AppTextStyles.secondTitle
                        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold)
                        .copyWith(color: AppColors.primary),
                  ),
                ],
              ),
          
              SizedBox(height: 3.h),
              
              // Align(
              //     alignment: AlignmentDirectional.centerStart,
              //     child: Text(
              //       "يرجى اختيار طريقة الدفع المناسبة لكي تتمكن من شراء الكورس ",
              //       style: AppTextStyles.secondTitle
              //           .copyWith(fontWeight: FontWeight.w600),
              //     )),
              // SizedBox(height: 1.5.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Radio(
              //       activeColor: AppColors.primary,
              //       value: 1,
              //       groupValue: selected,
              //       onChanged: (value) {
              //         selected = value!;
              //         setState(() {});
              //       },
              //     ),
              //     Text(
              //       'كاش',
              //       style: AppTextStyles.secondTitle,
              //     ),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     Radio(
              //       activeColor: AppColors.primary,
              //       value: 2,
              //       groupValue: selected,
              //       onChanged: (value) {
              //         selected = value!;
              //         setState(() {});
              //       },
              //     ),
              //     Text(
              //       'سرياتيل كاش',
              //       style: AppTextStyles.secondTitle,
              //     )
              //   ],
              // ),
          
              SizedBox(height: 2.h),
              CustomButton(
                  height: 6,
                  fontSize: 12,
                  titlebutton: "التالي",
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context, 
                      builder: (context) => ZoomIn(
                        child: TransactionImageDialog(
                            oneCourseCubit: widget.oneCourseCubit),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
