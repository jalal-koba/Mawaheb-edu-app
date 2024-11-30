import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardtype;
  final bool isvisible;
  final bool readonly;
  final double radius;
  final void Function()? functionsuffix;
  final Widget? iconsuffix;
  final Widget prefixIcon;
  final int maxlines;
   
  final bool isPhoneNum;
  final bool isPassword;
  final String? validatorMessage;
  final TextInputAction? textInputAction;
  final bool edit;
  final void Function(String)? onChanged;
  final String? Function(String?)? validat;
  final void Function()? ontap;
  final void Function()? onEditingComplete;
  final String? hinttext;
  final String label;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool enabled;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboardtype,
    this.textInputAction = TextInputAction.done,
    this.isvisible = false,
    this.readonly = false,
    this.enabled = true,
    this.radius = 0.0,
    this.functionsuffix,
    this.iconsuffix,
    required this.prefixIcon,
    this.maxlines = 1,
     this.isPhoneNum = false,
    this.isPassword = false,
    this.validatorMessage,
    this.edit = false,
    this.validat,
    this.ontap,
    this.hinttext,
    required this.label,
    this.focusNode,
    this.nextFocusNode,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: AppColors.blueMaterialColor)),
      child: TextFormField(
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: (value) {
            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            } else {
              widget.focusNode?.unfocus();
            }
          },
          focusNode: widget.focusNode,
          textInputAction: widget.nextFocusNode != null
              ? TextInputAction.next
              : widget.textInputAction,
          controller: widget.controller,
          cursorColor: AppColors.primary,
          cursorHeight: 20,
          keyboardType: widget.keyboardtype,
          obscureText: widget.isPassword ? showPassword : false,
          maxLines: widget.maxlines,
          onTap: widget.ontap,
          style: AppTextStyles.meduimTitle.copyWith(color: AppColors.primary),
          readOnly: widget.readonly,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: widget.label,
            floatingLabelStyle: AppTextStyles.secondTitle
                .copyWith(color: AppColors.primary, fontSize: 12.sp),
            labelStyle: AppTextStyles.secondTitle.copyWith(fontSize: 9.sp),
            prefixIcon: ElasticIn(child: widget.prefixIcon),
            enabled: true,
            hintText: widget.hinttext,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            suffixIcon: widget.edit
                ? ElasticIn(
                    child: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.primary,
                    ),
                  )
                : widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          showPassword = !showPassword;
                          setState(() {});
                        },
                        icon: showPassword
                            ? const Icon(
                                Icons.remove_red_eye_rounded,
                                color: AppColors.primary,
                              )
                            : const Icon(
                                Icons.visibility_off_sharp,
                                color: AppColors.primary,
                              ),
                      )
                    : widget.iconsuffix,
            hintStyle: TextStyle(fontSize: 11.sp),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(30),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          validator: widget.validat ??
              (value) {
                if (value!.isEmpty) {
                  return widget.validatorMessage ??
                      "يرجى إدخال البيانات المطلوبة";
                } else {
                  if (widget.validat != null) {
                    return widget.validat!(value);
                  } else {
                    return null;
                  }
                }

                // if (value!.isEmpty) {
                //   return widget.validatorMessage ??
                //       "يرجى إدخال البيانات المطلوبة";
                // }

                // if (widget.isEmail) {
                //   if (!isValidEmail(value)) {
                //     return "يرجى إدخال بريد إلكتروني صالح";
                //   }
                // } else if (widget.isPhoneNum) {
                //   if (!isValidPhoneNumber(value)) {
                //     return "يرجى إدخال رقم هاتف صالح";
                //   }
                // } else if (widget.isPassword) {
                //   if (value.length < 8) {
                //     return "يجب أن تكون كلمة المرور أكثر من 7 محارف";
                //   }
                // }
              }),
    );
  }
}
