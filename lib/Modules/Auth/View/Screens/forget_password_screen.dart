import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/View/Screens/otp_code_screen.dart';
import 'package:talents/Modules/Auth/View/Widgets/auth_scaffold.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        body: BlocProvider(
            create: (context) => AuthCubit(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is GetCodeErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message);
                } else if (state is GetCodeSuccessState) {
                  pushTo(
                      context: context,
                      toPage: OtpCodeScreen(
                        param: "type=forget_password",
                        email: context.read<AuthCubit>().emailCont.text,
                      ));
                }
              }, builder: (context, state) {
                final forgetPassword = AuthCubit.get(context);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "forgetpass",
                      child: Text(
                        "نسيت كلمة المرور",
                        style: AppTextStyles.meduimTitle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "أدخل البريد الالكتروني لكي يتم إرسال رمز إليه .",
                      style:
                          AppTextStyles.secondTitle.copyWith(fontSize: 11.sp),
                    ),
                    SizedBox(height: 5.h),
                    Form(
                      key: forgetPassword.emailFieldValidate,
                      child: CustomTextField(
                          validatorMessage: "يرحى إدخال البريد الإلكتروني",
                          label: "البريد الالكتروني",
                          controller: forgetPassword.emailCont,
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.emailAddress),
                    ),
                    SizedBox(height: 38.h),
                    (state is! GetCodeLoadingState)
                        ? Hero(
                            tag: "otp",
                            child: Material(
                              child: CustomButton(
                                  titlebutton: "تأكيد",
                                  onPressed: () {
                                    //           pushTo(
                                    // context: context,
                                    // toPage: OtpCode(
                                    //   email:
                                    //       context.read<ForgetPasswordCubit>().emailCont.text,
                                    // ));

                                    if (forgetPassword
                                        .emailFieldValidate.currentState!
                                        .validate()) {
                                      forgetPassword.getVerificationCode(
                                          param: "type=forget_password");
                                    }
                                  }),
                            ),
                          )
                        : const AppLoading(),
                    SizedBox(height: 4.h),
                  ],
                );
              }),
            )));
  }
}
