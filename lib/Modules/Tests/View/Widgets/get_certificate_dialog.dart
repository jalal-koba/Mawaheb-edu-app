import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Certificate/Cubit/cubit/certificate_cubit.dart';
import 'package:talents/Modules/Exams/models/result.dart';
import 'package:talents/Modules/Tests/View/Widgets/sucsess_get_certificate_dialog.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';

class GetCertificateDialog extends StatelessWidget {
  const GetCertificateDialog({
    super.key,
    required this.result,
    required this.courseId,
  });
  final Result result;
  final int courseId;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                textAlign: TextAlign.center,
                "تهانينا ! لقد نجحت",
                style: AppTextStyles.largeTitle,
              ),
              SizedBox(height: 3.h),
              Text(
                  'لقد حققت   ${result.studentPercentage?.toStringAsFixed(0)} / 100',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.meduimTitle.copyWith(
                      color: Colors.green, fontWeight: FontWeight.w500)),
              SizedBox(height: 2.h),
              BlocProvider(
                create: (context) => CertificateCubit(),
                child: BlocConsumer<CertificateCubit, CertificateState>(
                  listener: (context, state) {
                    if (state is PostCertificateSuccessState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ZoomIn(
                          child: const SuccessGetCertificateDialog(),
                        ),
                      );
                    } else if (state is PostCertificateErrorState) {
                      Navigator.pop(context);
                      customSnackBar(
                          context: context, success: 0, message: state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is PostCertificateLoadingState) {
                      return const AppLoading();
                    }
                    return CustomButton(
                        height: 6,
                        fontSize: 12,
                        titlebutton: "الحصول على الشهادة",
                        onPressed: () {
                          context
                              .read<CertificateCubit>()
                              .postCertificateRequest(courseId: courseId);
                        });
                  },
                ),
              ),
              SizedBox(height: 2.h),
              CustomButton(
                  background: AppColors.secondary,
                  height: 6,
                  fontSize: 12,
                  titlebutton: "رجوع",
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
