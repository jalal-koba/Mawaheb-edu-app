import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Info/Cubit/Cubit/info_cubit.dart';
import 'package:talents/Modules/Info/Cubit/states/contact_us_state.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';
import 'package:talents/Modules/Widgets/company_info.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

import '../../../Widgets/app_scaffold.dart';

class WhoUs extends StatelessWidget {
  const WhoUs({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: "من نحن",
        body: BlocProvider(
          create: (context) => InfoCubit()..getInfo(),
          child: BlocBuilder<InfoCubit, InfoState>(
            builder: (context, state) {
              final InfoCubit infoCubit = InfoCubit.get(context);

              if (state is InfoLoadingState) {
                return const AppLoading();
              }

              if (state is InfoErrorState) {
                return TryAgain(
                    message: state.message,
                    onTap: () {
                      infoCubit.getInfo();
                    });
              }
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                children: <Widget>[
                  SizedBox(height: 2.h),
                  Container(
                      height: 30.h,
                      width: 100.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          boxShadow: boxShadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: CachedImage(
                        imageUrl: infoCubit.whoUsImage,
                      )),
                  SizedBox(height: 3.h),
                  Text(
                    "${infoCubit.whoUsDescription}",
                    style: AppTextStyles.explanatoryText
                        .copyWith(fontSize: 9.5.sp),
                  ),
                  SizedBox(height: 4.h),
                  const CompanyInfo(),
                  SizedBox(height: 1.h),
                ],
              );
            },
          ),
        ));
  }
}
