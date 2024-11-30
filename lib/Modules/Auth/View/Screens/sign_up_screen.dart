import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Auth/View/Screens/otp_code_screen.dart';
import 'package:talents/Modules/Auth/View/Widgets/auth_scaffold.dart';
import 'package:talents/Modules/Courses/Util/app_functions.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';
import 'package:talents/Modules/Home/View/Screens/main_page.dart';

import '../../../Widgets/app_loading.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, this.fromHome = false});
  final bool fromHome;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        body: BlocProvider(
            create: (context) => AuthCubit(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) async {
                final signUp = AuthCubit.get(context);

                if (state is SiginUpErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message!);
                } else if (state is SiginUpSuccessState) {
                  context.read<ProfileCubit>().isEdit = false;

                  Network.init();
                  pushAndRemoveUntiTo(
                      context: context, toPage: const MainPage());
                } else if (state is GetCodeSuccessState) {
                  Map? params = await pushTo(
                      context: context,
                      toPage: OtpCodeScreen(
                        email: signUp.emailCont.text,
                        param: "type=register",
                      ));

                  signUp.verifyEmail(params);
                } else if (state is GetCodeErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message);
                }
              }, builder: (context, state) {
                final signUp = AuthCubit.get(context);

                return Form(
                  key: signUp.formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "أهلاً بك في تطبيق مواهب",
                        style: AppTextStyles.meduimTitle,
                      ),
                      Hero(
                        tag: "tosiginup",
                        child: Text(
                          "إنشاء حساب",
                          style: AppTextStyles.meduimTitle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: signUp.fullNameFocusNode,
                          focusNode: signUp.userNamseContFocusNode,
                          validatorMessage: "يرجى إدخال اسم المستحدم",
                          label: "اسم المستخدم",
                          controller: signUp.userNamseCont,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.name),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: signUp.residencePlaceFocusNode,
                          focusNode: signUp.fullNameFocusNode,
                          validatorMessage: "يرجى إدخال الاسم الثلاثي",
                          label: "الاسم الثلاثي",
                          controller: signUp.fullName,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.name),
                      SizedBox(height: 1.h),
                      Text(
                        "يرجى إدخال الاسم الثلاثي كما تريد أن يكتب بالشهادة",
                        style: AppTextStyles.secondTitle,
                      ),
                      SizedBox(height: 2.5.h),
                      CustomTextField(
                        validat: (text) {
                          if (text!.isEmpty) {
                            return "يرجى اختيار تاريخ الميلاد ";
                          }
                          if (!AppFunctions.isValidDate(text)) {
                            return "يرجى إضافة تاريخ يشبه الشكل 2004-08-22";
                          }
                          return null;
                        },
                        label: "تاريخ الميلاد",
                        ontap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime(2004, 8, 22),
                            firstDate: DateTime(1947),
                            lastDate: DateTime.now(),
                            initialDatePickerMode: DatePickerMode.year,
                          ).then((value) => {
                                if (value != null)
                                  {
                                    signUp.birthdayDate.text =
                                        DateFormat("yyyy-MM-dd").format(value)
                                  }
                                else
                                  <String>{signUp.birthdayDate.text = ""}
                              });
                        },
                        keyboardtype: TextInputType.datetime,
                        controller: signUp.birthdayDate,
                        prefixIcon: const Icon(
                          Icons.date_range_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: signUp.emailContFocusNode,
                          focusNode: signUp.residencePlaceFocusNode,
                          validatorMessage: "يرجى إدخال مكان الإقامة",
                          label: "مكان الإقامة",
                          controller: signUp.residencePlace,
                          prefixIcon: const Icon(
                            Icons.home,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.name),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: signUp.emailFormKey,
                              child: CustomTextField(
                                  enabled: !signUp.isVerified,
                                  readonly: state is GetCodeLoadingState,
                                  nextFocusNode: signUp.phoneNumberFocusNode,
                                  focusNode: signUp.emailContFocusNode,
                                  validat: (value) {
                                    if (signUp.emailCont.text.trim().isEmpty) {
                                      return "يرجى إدخال بريد إلكتروني ";
                                    }
                                    if (!AppFunctions.isValidEmail(value!)) {
                                      return "يرجى إدخال بريد صالح";
                                    }
                                    return null;
                                  },
                                  label: "البريد الإلكتروني (اختياري)",
                                  controller: signUp.emailCont,
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: AppColors.primary,
                                  ),
                                  keyboardtype: TextInputType.emailAddress),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          state is! GetCodeLoadingState
                              ? MaterialButton(
                                  padding: EdgeInsets.all(1.w),
                                  height: 6.5.h,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () {
                                    if (!signUp.isVerified) {
                                      if (signUp.emailFormKey.currentState!
                                          .validate()) {
                                        signUp.getVerificationCode(
                                            email: signUp.emailCont.text,
                                            param: "type=register");
                                      }
                                    } else {
                                      signUp.changeVerifiedEmail();
                                    }
                                  },
                                  color: AppColors.primary,
                                  child: Text(
                                      (!signUp.isVerified) ? 'تحقق' : "تغيير",
                                      style: AppTextStyles.meduimTitle
                                          .copyWith(color: Colors.white)),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: const AppLoading(),
                                )
                        ],
                      ),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: signUp.passwordContFocusNode,
                          focusNode: signUp.phoneNumberFocusNode,
                          validatorMessage: "يرجى إدخال رقم هاتف",
                          isPhoneNum: true,
                          label: "رقم الهاتف",
                          controller: signUp.phoneNumberCont,
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.phone),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: signUp.confirmPasswordFocusNode,
                          focusNode: signUp.passwordContFocusNode,
                          isPassword: true,
                          validatorMessage: "يرجى إدخال كلمة مرور",
                          label: "كلمة المرور",
                          controller: signUp.passwordCont,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.visiblePassword),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: null,
                          focusNode: signUp.confirmPasswordFocusNode,
                          isPassword: true,
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "يرجى تأكيد كلمة المرور";
                            }
                            if (signUp.passwordCont.text !=
                                signUp.confirmPasswordCont.text) {
                              return "كلمات المرور غير متطابقة";
                            }
                            return null;
                          },
                          label: "تأكيد كلمة المرور",
                          controller: signUp.confirmPasswordCont,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.visiblePassword),
                      SizedBox(height: 6.h),
                      (state is! SiginUpLoadingState)
                          ? CustomButton(
                              titlebutton: "إنشاء حساب",
                              onPressed: () {
                                signUp.createAccount();
                              })
                          : const AppLoading(),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'هل لديك حساب؟ ',
                            style: AppTextStyles.secondTitle,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (fromHome) {
                                pushAndRemoveUntiTo(
                                    context: context,
                                    toPage: const LoginScreen());
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Hero(
                              tag: "tologinword",
                              child: Text('تسجيل الدخول',
                                  style: AppTextStyles.secondTitle.copyWith(
                                      color: AppColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primary)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                );
              }),
            )));
  }
}
