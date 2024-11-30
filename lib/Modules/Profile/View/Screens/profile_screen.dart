import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Auth/View/Screens/otp_code_screen.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_state.dart';
import 'package:talents/Modules/Courses/Util/app_functions.dart';
import 'package:talents/Modules/Profile/View/Screens/change_email_screen.dart';
import 'package:talents/Modules/Profile/View/Screens/change_password_screen.dart';
import 'package:talents/Modules/Profile/View/Widgets/edit_image.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';
import 'package:talents/Modules/Widgets/register_firstly.dart';

import '../../../Widgets/try_agin.dart';
import '../Widgets/profile_shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    if (AppSharedPreferences.hasToken &&
        AppSharedPreferences.getToken != null &&
        !context.read<ProfileCubit>().isEdit) {
      context.read<ProfileCubit>().getProfileInfo();
    }
    return SlideInRight(
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UnAuthenticatedState) {
            AppSharedPreferences.removeToken;
            pushAndRemoveUntiTo(context: context, toPage: const LoginScreen());
          }
          if (state is ProfileErrorState) {
            customSnackBar(
                context: context, message: state.message, success: 0);
          }
          if (state is ProfileEditingErrorState) {
            customSnackBar(
                context: context, message: state.message, success: 0);
          }

          if (state is ProfileEditingSuccessState) {
            customSnackBar(
                context: context,
                message: "تم تعديل الملف الشخصي بنجاح",
                success: 1);
          }
        },
        builder: (context, state) {
          final ProfileCubit profileCubit = ProfileCubit.get(context);

          if (!AppSharedPreferences.hasToken) {
            return const RegisterFirstly();
          }

          if (state is ProfileErrorState) {
            return TryAgain(
              message: state.message,
              onTap: () {
                profileCubit.getProfileInfo();
              },
            );
          }

          if (state is ProfileLoadingState) {
            return const ProfileShimmer();
          }

          return Form(
            key: profileCubit.formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              children: [
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.center,
                  child: EditImage(profileCubit: profileCubit),
                ),
                SizedBox(height: 4.h),
                if (!profileCubit.isEdit)
                  SlideInUp(
                    child: CustomButton(
                        fontSize: 12,
                        width: 60,
                        titlebutton: "تعديل الملف الشخصي",
                        onPressed: () {
                          profileCubit.editProfile();
                        }),
                  ),
                if (!profileCubit.isEdit) SizedBox(height: 4.h),
                CustomTextField(
                    validatorMessage: "يرجى إدخال اسم المستحدم",
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    label: "اسم المستخدم",
                    controller: profileCubit.userNamseCont,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.name),
                SizedBox(height: 2.5.h),
                CustomTextField(
                    validat: (value) {
                      if (value!.length < 3) {
                        return "الاسم الثلاثي يجب أن يكون أكثر من 3 أحرف";
                      }
                      return null;
                    },
                    validatorMessage: "يرجى إدخال الاسم الثلاثي",
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    label: "الاسم الثلاثي",
                    controller: profileCubit.fullName,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.name),
                SizedBox(height: 2.5.h),
                CustomTextField(
                  edit: profileCubit.isEdit,
                  readonly: !profileCubit.isEdit,
                  validatorMessage: "يرجى اختيار تاريخ الميلاد ",
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
                    if (profileCubit.isEdit) {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime(2004, 8, 22),
                        firstDate: DateTime(1947),
                        lastDate: DateTime.now(),
                        initialDatePickerMode: DatePickerMode.year,
                      ).then((value) => {
                            if (value != null)
                              {
                                profileCubit.birthdayDate.text =
                                    DateFormat("yyyy-MM-dd").format(value)
                              }
                            else
                              {profileCubit.birthdayDate.text = ""}
                          });
                    }
                  },
                  keyboardtype: TextInputType.datetime,
                  controller: profileCubit.birthdayDate,
                  prefixIcon: const Icon(
                    Icons.date_range_outlined,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 2.5.h),
                CustomTextField(
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    nextFocusNode: profileCubit.emailContFocusNode,
                    focusNode: profileCubit.residencePlaceFocusNode,
                    validatorMessage:
                        "يرجى إدخال مكان الإقامة", // to do check its validate
                    label: "مكان الإقامة",
                    controller: profileCubit.residencePlace,
                    prefixIcon: const Icon(
                      Icons.home,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.name),
                SizedBox(height: 2.5.h),
                CustomTextField(
                    validatorMessage: "يرجى إدخال رقم هاتف",
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    isPhoneNum: true,
                    label: "رقم الهاتف",
                    controller: profileCubit.phoneNumberCont,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.phone),
                SizedBox(height: 2.5.h),
                BlocProvider(
                  create: (context) => AuthCubit(),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      pushTo(
                          context: context,
                          toPage: OtpCodeScreen(
                              param: "type=update_email",
                              email: context.read<AuthCubit>().emailCont.text));
                    },
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                                enabled: false,
                                validatorMessage:
                                    "يرجى إدخال البريد الإلكتروني",
                                readonly: !profileCubit.isEdit,
                                validat: (text) {
                                  return null;
                                },
                                label: "البريد الإلكتروني",
                                controller: profileCubit.emailCont,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: AppColors.primary,
                                ),
                                keyboardtype: TextInputType.emailAddress),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Builder(
                            builder: (context) {
                              if (!profileCubit.isEdit) {
                                return const SizedBox();
                              }

                              return MaterialButton(
                                padding: EdgeInsets.all(1.w),
                                height: 6.5.h,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {
                                  pushTo(
                                      context: context,
                                      toPage: const ChangeEmaliScreen());
                                },
                                color: AppColors.primary,
                                child: Text("تغيير",
                                    style: AppTextStyles.meduimTitle
                                        .copyWith(color: Colors.white)),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 2.5.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          readonly: true,
                          isvisible: true,
                          enabled: false,
                          label: "كلمة المرور",
                          controller: profileCubit.passwordCont,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.visiblePassword),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    if (profileCubit.isEdit)
                      MaterialButton(
                        padding: EdgeInsets.all(1.w),
                        height: 6.5.h,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          pushTo(
                              context: context, toPage: const ChangePassword());
                        },
                        color: AppColors.primary,
                        child: Text("تغيير",
                            style: AppTextStyles.meduimTitle
                                .copyWith(color: Colors.white)),
                      )
                  ],
                ),
                SizedBox(height: 2.5.h),
                Builder(builder: (context) {
                  if (profileCubit.isEdit) {
                    if (state is ProfileEditingLoadingState) {
                      return const AppLoading();
                    } else {
                      return SlideInDown(
                        child: CustomButton(
                            width: 92,
                            fontSize: 12,
                            titlebutton: "حفظ",
                            onPressed: () {
                              if (profileCubit.formKey.currentState!
                                  .validate()) {
                                profileCubit.updateProfile();
                              }
                            }),
                      );
                    }
                  }
                  return const SizedBox();
                }),
                SizedBox(height: 10.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
