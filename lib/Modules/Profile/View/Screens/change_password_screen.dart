import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';

import '../../../Widgets/app_scaffold.dart'; // to doo test screen

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "تغيير كلمة المرور",
        body: BlocProvider(
          create: (context) => AuthCubit(),
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccessState) {
                  customSnackBar(
                      context: context,
                      success: 1,
                      message: "تم تغيير كلمة المرور بنجاح");
                  Navigator.pop(context);
                } else if (state is ChangePasswordErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message);
                }
              },
              builder: (context, state) {
                final AuthCubit changePasswordCubit = AuthCubit.get(context);

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Form(
                    key: changePasswordCubit.changeFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5.h),
                        CustomTextField(
                            isPassword: true,
                            validatorMessage: "يرجى إدخال كلمة المرور القديمة",
                            label: "كلمة المرور القديمة",
                            controller: changePasswordCubit.oldPassword,
                            prefixIcon:  const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ), 
                            keyboardtype: TextInputType.visiblePassword),
                        SizedBox(height: 4.h),
                        CustomTextField(
                            isPassword: true,
                            validatorMessage: "يرجى إدخال كلمة المرور الجديدة",
                            label: "كلمة المرور الجديدة",
                            controller: changePasswordCubit.newPassword,
                            prefixIcon:  const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ), 
                            keyboardtype: TextInputType.visiblePassword),
                        SizedBox(height: 4.h),
                        CustomTextField(
                            isPassword: true,
                            validat: (value) {
                              if (value!.isEmpty) {
                                return "يرجى تأكيد كلمة المرور الجديدة";
                              }

                              if (changePasswordCubit.newPassword.text !=
                                  changePasswordCubit.confirmNewPassword.text) {
                                return "كلمات المرور غير متطابقة";
                              }
                              return null;
                            },
                            label: "تأكيد كلمة المرور الجديدة",
                            controller: changePasswordCubit.confirmNewPassword,
                            prefixIcon:  const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ), 
                            keyboardtype: TextInputType.visiblePassword),
                        SizedBox(height: 12.h),

                        Builder(
                          builder: (context) {
                            if (state is ChangePasswordLoadingState) {
                              return const AppLoading();
                            } else {
                              return CustomButton(
                                  titlebutton: "حفظ",
                                  onPressed: () {
                                    changePasswordCubit.changePassword();
                                  });
                            }
                          },
                        )
                     
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
