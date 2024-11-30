import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_state.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';

class DeleteUserImageDialog extends StatelessWidget {
  const DeleteUserImageDialog({
    super.key,
    required this.profileCubit,
  });

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return FlipInY(
      duration: const Duration(milliseconds: 300),
      child: Dialog(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'هل تريد حذف صورة الملف الشخصي؟',
                style: AppTextStyles.meduimTitle,
              ),
              SizedBox(height: 1.h),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileErrorState) {
                    customSnackBar(
                        context: context, success: 0, message: state.message);
                    Navigator.pop(context);
                  }
                  if (state is ProfileEditingSuccessState) {
                    customSnackBar(
                        context: context,
                        success: 1,
                        message: "تم حذف الصورة بنجاح");
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return state is! ProfileEditingLoadingState
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  profileCubit.removeImage = true;
                                  profileCubit.updateProfile();
                                },
                                child: Text(
                                  'نعم',
                                  style: AppTextStyles.meduimTitle
                                      .copyWith(color: AppColors.primary),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'لا',
                                  style: AppTextStyles.meduimTitle
                                      .copyWith(color: AppColors.primary),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const AppLoading();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
