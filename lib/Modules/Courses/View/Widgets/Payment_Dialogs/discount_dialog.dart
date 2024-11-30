import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Courses/Cubit/Cubit/course_cubit.dart';
import 'package:talents/Modules/Courses/Cubit/States/course_state.dart'; 
import 'package:talents/Modules/Courses/View/Widgets/Payment_Dialogs/after_discount_dialog.dart';
import 'package:talents/Modules/Courses/View/Widgets/Payment_Dialogs/transaction_image_dialog.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';

class DiscountDialog extends StatelessWidget {
  final CourseCubit oneCourseCubit; 

  const DiscountDialog({
    super.key,
    required this.oneCourseCubit, 
  });
  @override
  Widget build(BuildContext context) {
    oneCourseCubit.discountCont.clear();
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 1)),
      child: BlocProvider.value(
        value: oneCourseCubit,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
          child: SingleChildScrollView(
            child: BlocConsumer<CourseCubit, CourseState>(
              listener: (context, state) {
                if (state is CheckCuponErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message);
                } else if (state is CheckCuponSuccessState) {
                  if (state.discountSuccess) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => ZoomIn(
                          animate: true,
                          child: AfterDiscountDialog(
                            oneCourseCubit: oneCourseCubit,
                          )),
                    );
                  }
                }
              },
              builder: (context, state) {
                final CourseCubit oneCourseCubit = CourseCubit.get(context);

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        oneCourseCubit.parentSection.name,
                        style: AppTextStyles.largeTitle
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${oneCourseCubit.parentSection.price} ل.س',
                        style: AppTextStyles.meduimTitle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'هل لديك كود حسم ؟',
                        style: AppTextStyles.secondTitle,
                      ),
                      SizedBox(height: 2.h),
                      Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            'أدخل كود الحسم ( اختياري )',  
                            style: AppTextStyles.secondTitle
                                .copyWith(fontWeight: FontWeight.w600),
                          )),
                      SizedBox(height: 1.5.h),
                      CustomTextField(
                          prefixIcon: const Icon(
                            Icons.abc_outlined,
                            color: AppColors.primary,
                          ),
                          enabled: state is! CheckCuponLoadingState,
                          controller: context.read<CourseCubit>().discountCont,
                          keyboardtype: TextInputType.visiblePassword,
                          label: "كود الحسم"),
                      SizedBox(height: 2.h),
                      BlocBuilder<CourseCubit, CourseState>(
                        builder: (context, state) {
                          final CourseCubit courseCubit =
                              CourseCubit.get(context);

                          if (state is CheckCuponLoadingState) {
                            return const AppLoading();
                          }
                          return Column(
                            children: [
                              CustomButton(
                                  height: 6,
                                  fontSize: 12,
                                  titlebutton: "التالي",
                                  onPressed: () {
                                    if (oneCourseCubit
                                        .discountCont.text.isEmpty) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => ZoomIn(
                                          animate: true,
                                          child: TransactionImageDialog(
                                             oneCourseCubit: oneCourseCubit,
                                          ),
                                        ),
                                      );
                                    } else {
                                      courseCubit.checkCupon();
                                    }
                                  }),
                              SizedBox(height: 1.h),
                              Builder(builder: (context) {
                                if (state is CheckCuponSuccessState) {
                                  if (!state.discountSuccess) {
                                    return Text(
                                      state.errorMessage!,
                                      style: AppTextStyles.meduimTitle
                                          .copyWith(
                                              color: Colors.red[500],
                                              fontSize: 12.sp),
                                    );
                                  }
                                }
                                return const SizedBox();
                              })
                            ],
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
