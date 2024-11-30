import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Auth/View/Widgets/auth_scaffold.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword(
      {super.key, required this.verificationCode, required this.email});
  final String verificationCode;
  final String email;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is RestPasswordErrorState) {
                customSnackBar(
                    context: context, success: 0, message: state.message!);
              } else if (state is ResetPasswordSuccessState) {
                pushAndRemoveUntiTo(context: context, toPage: const LoginScreen());
              }
            },
            builder: (context, state) {
              final forgetPassword = AuthCubit.get(context);

              return Form(
                key: forgetPassword.formStateRestPass,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اعادة تعيين كلمة المرور",
                      style: AppTextStyles.meduimTitle
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 1.h),
                    Hero(
                      tag: "respass",
                      child: Text(
                        "قم بادخال كلمة المرور الجديدة",
                        style:
                            AppTextStyles.secondTitle.copyWith(fontSize: 11.sp),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    CustomTextField(
                        isPassword: true,
                        validatorMessage: "يرحى إدخال كلمة مرور",
                        label: "كلمة المرور",
                        controller: forgetPassword.newPassword,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.primary,
                        ),
                        keyboardtype: TextInputType.visiblePassword),
                    SizedBox(height: 3.h),
                    CustomTextField(
                        validat: (value) {
                          if (forgetPassword.newPassword.text !=
                              forgetPassword.confirmNewPassword.text) {
                            return "كلمات المرور غير متطابقة";
                          }
                          return null;
                        },
                        isPassword: true,
                        validatorMessage: "يرحى تأكيد كلمة المرور",
                        label: "تأكيد كلمة المرور",
                        controller: forgetPassword.confirmNewPassword,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.primary,
                        ),
                        keyboardtype: TextInputType.visiblePassword),
                    SizedBox(height: 30.h),
                    state is! ResetPasswordLoadingState
                        ? CustomButton(
                            titlebutton: "حفظ",
                            onPressed: () {
                              print(email);
                              print(verificationCode);
                              forgetPassword.restPassword(
                                  email: email,
                                  verificationCode: verificationCode);
                            })
                        : const AppLoading(),
                    SizedBox(height: 4.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
