import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Auth/View/Screens/forget_password_screen.dart';
import 'package:talents/Modules/Auth/View/Screens/sign_up_screen.dart';
import 'package:talents/Modules/Auth/View/Widgets/auth_scaffold.dart';
import 'package:talents/Modules/Home/Cubit/cubit/main_page_cubit.dart';
import 'package:talents/Modules/Home/View/Screens/main_page.dart';
import 'package:talents/Modules/Info/Cubit/Cubit/info_cubit.dart';
import 'package:talents/Modules/Info/Cubit/states/contact_us_state.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';
import 'package:talents/Modules/Widgets/shimmer_card.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        tag: "tologin",
        body: BlocProvider(
            create: (context) => AuthCubit(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is LoginErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message!);
                } else if (state is LoginSuccessState) {
                  Network.init();
                  context.read<MainPageCubit>().moveTab(0);

                  context.read<ProfileCubit>().isEdit = false;
                  pushAndRemoveUntiTo(
                      context: context, toPage: const MainPage());
                }
              }, builder: (context, state) {
                final login = AuthCubit.get(context);

                return Form(
                  key: login.formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "أهلاً بك في تطبيق مواهب",
                        style: AppTextStyles.meduimTitle,
                      ),
                      Hero(
                        tag: "tologinword",
                        child: Text(
                          "تسجيل دخول",
                          style: AppTextStyles.meduimTitle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextField(
                          validat: (value) {
                            if (login.emailORrhoneOrNameCont.text
                                .trim()
                                .isEmpty) {
                              return "يجب أن يكون أكثر من ثلاثة أحرف";
                            }
                            return null;
                          },
                          focusNode: login.emailORrhoneOrNameFocusNode,
                          nextFocusNode: login.passwordFocusNode,
                          label: "البريد الالكتروني/اسم المستخدم/رقم الموبايل",
                          controller: login.emailORrhoneOrNameCont,
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.emailAddress),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          focusNode: login.passwordFocusNode,
                          validatorMessage: "يرجى إدخال كلمة المرور",
                          isPassword: true,
                          label: "كلمة المرور",
                          controller: login.passwordCont,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.visiblePassword),
                      SizedBox(height: 2.h),
                      BlocProvider(
                        create: (context) => InfoCubit()..getInfo(),
                        child: BlocBuilder<InfoCubit, InfoState>(
                          builder: (context, state) {
                            final InfoCubit infoCubit =
                                context.read<InfoCubit>();
                            if (state is InfoLoadingState) {
                              return ShimmerCard(
                                height: 15,
                                width: 35.w,
                                borderRadius: BorderRadius.circular(5),
                              );
                            }
                            if (state is InfoErrorState) {
                              return TryAgain(
                                  small: true,
                                  withImage: false,
                                  onTap: () {
                                    infoCubit.getInfo();
                                  },
                                  message: state.message);
                            }
                            return InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                // this disabled because email is obtional in registering

                                Navigator.of(context).push(
                                  PageTransition(
                                      child: const ForgetPasswordScreen(),
                                      type: PageTransitionType.rightToLeft,
                                      duration: const Duration(milliseconds: 400)),
                                );

                                // showDialog(
                                //   context: context,
                                //   builder: (context) => _ForgetPasswordDialog(
                                //       infoCubit: infoCubit),
                                // );
                              },
                              child: Hero(
                                tag: "forgetpass",
                                child: Text(
                                  "هل نسيت كلمة المرور؟",
                                  style: AppTextStyles.secondTitle.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontSize: 9.sp),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 4.h),
                      (state is! LoginLoadingState)
                          ? CustomButton(
                              titlebutton: "تسجيل دخول",
                              onPressed: () {
                               
                                login.login();
                              })
                          : const AppLoading(),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'ليس لديك حساب؟ ',
                            style: AppTextStyles.secondTitle,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              pushTo(
                                  context: context,
                                  toPage: const SignUpScreen());
                            },
                            child: Hero(
                              tag: "tosiginup",
                              child: Text('إنشاء حساب',
                                  style: AppTextStyles.secondTitle.copyWith(
                                      color: AppColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primary)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            // AppSharedPreferences.saveIsGuest(true);
                            pushAndRemoveUntiTo(
                                context: context, toPage: const MainPage());
                          },
                          child: Text('الدخول كزائر',
                              style: AppTextStyles.secondTitle.copyWith(
                                  color: AppColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary)),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )));
  }
}

class _ForgetPasswordDialog extends StatelessWidget {
  const _ForgetPasswordDialog({
    required this.infoCubit,
  });

  final InfoCubit infoCubit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear)),
          ),
          Text(
            'يرجى التواصل مع الإدارة',
            style: AppTextStyles.meduimTitle,
          ),
          SizedBox(height: 4.h),
          InkWell(
            highlightColor: Colors.transparent,
            onTap: () async =>
                await EasyLauncher.call(number: infoCubit.contact.phone),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      infoCubit.contact.phone,
                      style: AppTextStyles.meduimTitle.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary),
                    )),
                SizedBox(
                  width: 5.w,
                ),
                SvgPicture.asset(
                  Images.telephone,
                  width: 30.sp,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          )
        ],
      ),
    );
  }
}
