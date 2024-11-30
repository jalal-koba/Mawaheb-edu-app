import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Info/Cubit/Cubit/info_cubit.dart';
import 'package:talents/Modules/Info/Cubit/states/contact_us_state.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

import '../../../Widgets/app_scaffold.dart';

class ContactWithUs extends StatelessWidget {
  ContactWithUs({super.key});
  final InfoCubit contactUsCubit = InfoCubit()..getInfo();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "تواصل معنا",
      body: BlocProvider(
        create: (context) => contactUsCubit,
        child: BlocConsumer<InfoCubit, InfoState>(listener: (context, state) {
          if (state is SendMessageSuccessState) {
            customSnackBar(
                context: context, success: 1, message: "تم إرسال رسالتك بنجاح");
            Navigator.pop(context);
          } else if (state is SendMessageErrorState) {
            customSnackBar(
                context: context, success: 0, message: state.message);
          }
        }, builder: (context, state) {
          final InfoCubit contactUsCubit = InfoCubit.get(context);
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Form(
                key: contactUsCubit.formState,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 2.h),
                    CustomTextField(
                        focusNode: contactUsCubit.userNamefocusNode,
                        nextFocusNode: contactUsCubit.emailfocusNode,
                        label: "اسم المستخدم",
                        controller: contactUsCubit.userName,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ),
                        keyboardtype: TextInputType.name),
                    SizedBox(height: 3.h),
                    CustomTextField(
                        focusNode: contactUsCubit.emailfocusNode,
                        nextFocusNode: contactUsCubit.phoneNumberfocusNode,
                        validat: (value) {
                          return null;
                        },
                        label: "البريد الإلكتروني (اختياري)",
                        controller: contactUsCubit.email,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: AppColors.primary,
                        ),
                        keyboardtype: TextInputType.emailAddress),
                    SizedBox(height: 3.h),
                    CustomTextField(
                        nextFocusNode: contactUsCubit.messagefocusNode,
                        focusNode: contactUsCubit.phoneNumberfocusNode,
                        validatorMessage: "يرجى إدخال رقم هاتف",
                        isPhoneNum: true,
                        label: "رقم الهاتف",
                        controller: contactUsCubit.phoneNumber,
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: AppColors.primary,
                        ),
                        keyboardtype: TextInputType.phone),
                    SizedBox(height: 5.h),
                    MessageField(
                      contactUsCubit: contactUsCubit,
                      validat: (vale) {
                        if (vale!.isEmpty) {
                          return "يرجى إدخال الرسالة";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3.h),
                    Builder(
                      builder: (context) {
                        if (state is SendMessageLoadingState) {
                          return const AppLoading();
                        }
                        return CustomButton(
                            fontSize: 13,
                            height: 6,
                            titlebutton: "إرسال",
                            onPressed: () {
                              contactUsCubit.sendMessage();
                            });
                      },
                    ),
                    SizedBox(height: 5.h),
                    Builder(
                      builder: (context) {
                        if (state is InfoErrorState) {
                          return TryAgain(
                              small: true,
                              onTap: () {
                                contactUsCubit.getInfo();
                              },
                              message: state.message);
                        }

                        if (context.watch<InfoCubit>().loadingScial) {
                          return const AppLoading();
                        }
                        return Column(
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () async => await EasyLauncher.call(
                                  number: contactUsCubit.contact.phone),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text(
                                        contactUsCubit.contact.phone,
                                        style: AppTextStyles.meduimTitle
                                            .copyWith(fontSize: 12.sp),
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
                            SizedBox(height: 2.h),
                            InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () async => await EasyLauncher.email(
                                  email: contactUsCubit.contact.email),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text(
                                        contactUsCubit.contact.email,
                                        style: AppTextStyles.meduimTitle
                                            .copyWith(fontSize: 12.sp),
                                      )),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SvgPicture.asset(
                                    Images.email,
                                    width: 30.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3.h),
                            SizedBox(
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      await EasyLauncher.url(
                                          url: contactUsCubit.contact.whatsapp);
                                    },
                                    child: SvgPicture.asset(
                                      width: 40.sp,
                                      Images.whatsApp,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await EasyLauncher.url(
                                            url: contactUsCubit
                                                .contact.facebook);
                                      },
                                      child: SvgPicture.asset(
                                          width: 40.sp, Images.facebook)),
                                  InkWell(
                                    onTap: () async {
                                      await EasyLauncher.url(
                                          url: contactUsCubit.contact.telegram);
                                    },
                                    child: SvgPicture.asset(
                                        width: 40.sp, Images.telegram),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await EasyLauncher.url(
                                          url: contactUsCubit.contact.youtube);
                                    },
                                    child: SvgPicture.asset(
                                        width: 40.sp, Images.youtube),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await EasyLauncher.url(
                                          url:
                                              contactUsCubit.contact.instagram);
                                    },
                                    child: SvgPicture.asset(
                                        width: 40.sp, Images.insta),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 4.h)
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class MessageField extends StatelessWidget {
  const MessageField({
    super.key,
    required this.contactUsCubit,
    required this.validat,
  });

  final InfoCubit contactUsCubit;
  final String? Function(String?)? validat;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: contactUsCubit.messagefocusNode,
      validator: validat,
      controller: contactUsCubit.message,
      maxLines: 300,
      minLines: 6,
      cursorColor: AppColors.primary,
      cursorHeight: 20,
      keyboardType: TextInputType.name,
      style: AppTextStyles.meduimTitle.copyWith(color: AppColors.primary),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: "الرسالة",
        floatingLabelStyle: AppTextStyles.secondTitle
            .copyWith(color: AppColors.primary, fontSize: 12.sp),
        labelStyle: AppTextStyles.secondTitle.copyWith(fontSize: 9.sp),
        enabled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        hintStyle: TextStyle(fontSize: 11.sp),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
