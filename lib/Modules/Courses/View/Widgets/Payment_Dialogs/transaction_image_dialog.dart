import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Courses/Cubit/Cubit/course_cubit.dart';
import 'package:talents/Modules/Courses/Cubit/States/course_state.dart';
import 'package:talents/Modules/Courses/View/Widgets/Payment_Dialogs/sucsess_dialog.dart';
import 'package:talents/Modules/Home/Cubit/cubit/home_cubit.dart';
import 'package:talents/Modules/Home/Cubit/state/home_state.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

class TransactionImageDialog extends StatelessWidget {
  final CourseCubit oneCourseCubit;

  const TransactionImageDialog({
    super.key,
    required this.oneCourseCubit,
  });

  @override
  Widget build(BuildContext context) {
    oneCourseCubit.removeImage();
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.h),
        child: SingleChildScrollView(
          child: BlocProvider.value(
            value: oneCourseCubit,
            child: BlocConsumer<CourseCubit, CourseState>(
              listener: (context, state) {
                if (state is BuyCourseSuccessState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => ZoomIn(
                      child: const SuccessDialog(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final CourseCubit oneCourseCubit = CourseCubit.get(context);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'السعر :',
                          style: AppTextStyles.meduimTitle
                              .copyWith(color: AppColors.primary), // expanded
                        ),
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            "${oneCourseCubit.parentSection.price} ل.س",
                            style: AppTextStyles.meduimTitle.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    BlocProvider(
                      create: (context) {
                        if (HomeCubit.ownerInfo == "") {
                          return HomeCubit()..getHomeInfo();
                        } else {
                          return HomeCubit();
                        }
                      },
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          final HomeCubit homeCubit = HomeCubit.get(context);
                          if (state is HomeLoadingState) {
                            return const AppLoading();
                          }
                          if (state is HomeErrorState) {
                            return TryAgain(
                              message: state.message,
                              onTap: () {
                                homeCubit.getHomeInfo();
                              },
                            );
                          }
                          return HtmlWidget(
                            HomeCubit.ownerInfo,
                            renderMode: RenderMode.column,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "يرجى رفع صورة الوصل :",
                      style: AppTextStyles.secondTitle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 1.5.h),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColors.primary)),
                            child: oneCourseCubit.transactionImage == null
                                ? IconButton(
                                    onPressed: () {
                                      oneCourseCubit.showPicker(context);
                                    },
                                    icon: const Icon(
                                      Icons.download,
                                      color: AppColors.primary,
                                    ))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                        fit: BoxFit.cover,
                                        File(oneCourseCubit
                                            .transactionImage!.path)),
                                  ),
                          ),
                          oneCourseCubit.transactionImage != null
                              ? Positioned(
                                  left: 0,
                                  top: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        if (state is! BuyCourseLoadingState) {
                                          oneCourseCubit.removeImage();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      )),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Builder(
                      builder: (context) {
                        if (state is BuyCourseLoadingState) {
                          return const AppLoading();
                        }
                        return Column(
                          children: [
                            CustomButton(
                                height: 6,
                                fontSize: 12,
                                titlebutton:
                                    oneCourseCubit.isFree ? "تأكيد" : "إرسال",
                                onPressed: () {
                                  if (
                                    oneCourseCubit.isFree ||(oneCourseCubit.parentSection.discount !=null &&oneCourseCubit.parentSection.discount!.toInt() ==100)
                                      
                                      ) {
                                    oneCourseCubit.buyCourse();
                                    return;
                                  }

                                  if (oneCourseCubit.transactionImage == null) {
                                    customSnackBar(
                                        context: context,
                                        success: 0,
                                        message: "الرجاء رفع صورة الوصل");
                                  } else {
                                    oneCourseCubit.buyCourse();
                                  }
                                }),
                            SizedBox(width: 0.0, height: 1.h),
                            Builder(builder: (context) {
                              if (state is BuyCourseErrorState) {
                                return Text(
                                  state.message,
                                  style: AppTextStyles.meduimTitle.copyWith(
                                      color: Colors.red[500], fontSize: 12.sp),
                                );
                              }
                              return const SizedBox();
                            })
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 2.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
