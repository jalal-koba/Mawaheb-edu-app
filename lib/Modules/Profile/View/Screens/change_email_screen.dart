import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_state.dart';
import 'package:talents/Modules/Auth/View/Screens/otp_code_screen.dart';
import 'package:talents/Modules/Courses/Util/app_functions.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';

import '../../../Widgets/app_scaffold.dart'; // to doo test screen

class ChangeEmaliScreen extends StatelessWidget {
  const ChangeEmaliScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "تغيير البريد الإلكتروني",
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          final ProfileCubit profileCubit = ProfileCubit.get(context);

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    "تغير البريد الإلكتروني",
                    style: AppTextStyles.meduimTitle,
                  ),
                  SizedBox(height: 1.h),
                  BlocProvider(
                    create: (context) => AuthCubit(),
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) async {
                        final AuthCubit authCubit = AuthCubit.get(context);
                        if (state is ChangeEmailErrorState) {
                          customSnackBar(
                              context: context,
                              success: -1,
                              message: state.message);
                        }
                        if (state is ChangeEmailSuccessState) {
                          context.read<ProfileCubit>().emailCont.text =
                              authCubit.emailCont.text;
                          Navigator.of(context).pop();
                        } else if (state is GetCodeSuccessState) {
                          authCubit.showOtpField = true;
                        } else if (state is GetCodeErrorState) {
                          customSnackBar(
                              context: context,
                              success: 0,
                              message: state.message);
                        } else if (state is CheckCodeErrorState) {
                          customSnackBar(
                              context: context,
                              success: 0,
                              message: state.message);
                        } else if (state is GetCodeSuccessState) {
                          customSnackBar(
                              context: context,
                              success: 1,
                              message: "Code sent successfully");
                        }
                      },
                      builder: (context, state) {
                        final AuthCubit authCubit = AuthCubit.get(context);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Column(
                              children: [
                                Form(
                                  key: authCubit.emailFormKey,
                                  child: CustomTextField(
                                      readonly: authCubit.showOtpField ||
                                          state is GetCodeLoadingState,
                                      enabled: !authCubit.isVerified,
                                      focusNode: authCubit.emailContFocusNode,
                                      validat: (email) {
                                        if (!AppFunctions.isValidEmail(
                                            email!)) {
                                          return "بريدك الإلكتروني غير صالح";
                                        }
                                        return null;
                                      },
                                      label: "البريد الإلكتروني",
                                      controller: authCubit.emailCont,
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: AppColors.primary,
                                      ),
                                      keyboardtype: TextInputType.emailAddress),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Builder(
                                  builder: (context) {
                                    if (authCubit.showOtpField) {
                                      return const SizedBox();
                                    }

                                    if (state is GetCodeLoadingState) {
                                      return Padding(
                                        padding: EdgeInsets.all(4.w),
                                        child: const AppLoading(),
                                      );
                                    }

                                    return Padding(
                                      padding: EdgeInsets.only(top: 25.h),
                                      child: MaterialButton(
                                        padding: EdgeInsets.all(1.w),
                                        height: 6.5.h,
                                        minWidth: 70.w,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        onPressed: () {
                                          if (!authCubit.isVerified) {
                                            if (authCubit
                                                .emailFormKey.currentState!
                                                .validate()) {
                                              authCubit.getVerificationCode(
                                                  email:
                                                      authCubit.emailCont.text,
                                                  param: "type=update_email");
                                            }
                                          } else {
                                            authCubit.changeEmail(
                                                profileCubit: profileCubit);
                                          }
                                        },
                                        color: AppColors.primary,
                                        child: Text(
                                          "تحقق",
                                          style: AppTextStyles.meduimTitle
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Visibility(
                              visible: authCubit.showOtpField,
                              child: FadeInUp(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 2.h),
                                    Text(
                                        "لقد قمنا بإرسال رمز التحقق إلى البريد الإلكتروني : ",
                                        style: AppTextStyles.secondTitle),
                                    SizedBox(height: 2.h),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: OTPField(
                                            onCompleted: (text) {
                                              authCubit.changeEmail(
                                                  profileCubit: profileCubit);
                                            },
                                            authCubit: authCubit),
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("لم أتلق الرمز  ",
                                            style: AppTextStyles.secondTitle),
                                        Wait(
                                          onTap: () {
                                            context
                                                .read<AuthCubit>()
                                                .getVerificationCode(
                                                    email: authCubit
                                                        .emailCont.text,
                                                    param: "type=update_email");
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Builder(
                              builder: (context) {
                                if (state is ChangeEmailLoadingState) {
                                  return const AppLoading();
                                }
                                if (authCubit.showOtpField) {
                                  return CustomButton(
                                    titlebutton: "حفظ",
                                    onPressed: () {
                                      if (authCubit.otpCode.text.length < 4) {
                                        customSnackBar(
                                            context: context,
                                            success: 2,
                                            message: "يرجى إدخال الرمز");
                                      } else {
                                        authCubit.changeEmail(
                                            profileCubit: profileCubit);
                                      }
                                    },
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
