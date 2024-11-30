import 'package:flutter/material.dart' hide DrawerButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/View/Widgets/logout_dialog.dart';
import 'package:talents/Modules/Courses/View/Screens/subscribed_course_screen.dart';
import 'package:talents/Modules/Info/View/Screens/contact_with_us_screen.dart';
import 'package:talents/Modules/Info/View/Screens/who_us_screen.dart';
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Home/Cubit/cubit/main_page_cubit.dart';
import 'package:talents/Modules/Certificate/View/certificate_orders_screen.dart';
import 'package:talents/Modules/Notifications/View/notification_screen.dart';
import 'package:talents/Modules/Payments_Orders/View/Screens/payment_orders_screen.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Auth/Cubit/profile_state.dart';
import 'package:talents/Modules/Widgets/app_cliper.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/drawer_button.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

Drawer appDrawer(
  BuildContext context,
) {
  Divider divider = Divider(
    color: AppColors.primary.withOpacity(0.5),
    height: 0.5.h,
  );
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppHeader(),
          _UserLayer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                DrawerButton(
                  title: "الإشعارات",
                  onPressed: () async {
                    Navigator.pop(context);
                    await pushTo(
                        context: context, toPage: const NotificationScreen());
                  },
                ),
                divider,
                DrawerButton(
                  title: "الكورسات المشترك بها",
                  onPressed: () {
                    Navigator.pop(context);
                    pushTo(
                        context: context,
                        toPage: const SubscribedCoursesScreen());
                  },
                ),
                divider,
                DrawerButton(
                  title: "مكتبة التطبيق",
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<MainPageCubit>().moveTab(1);
                  },
                ),
                divider,
                DrawerButton(
                  title: "طلبات الشراء",
                  onPressed: () {
                    Navigator.pop(context);
                    pushTo(
                        context: context, toPage: const PaymentOrdersScreen());
                  },
                ),
                divider,
                DrawerButton(
                  title: "الشهادات",
                  onPressed: () {
                    Navigator.pop(context);
                    pushTo(
                        context: context,
                        toPage: const CertificateOrdersScreen());
                  },
                ),
                divider,
                DrawerButton(
                  title: "من نحن",
                  onPressed: () {
                    Navigator.pop(context);
                    pushTo(context: context, toPage: const WhoUs());
                  },
                ),
                divider,
                DrawerButton(
                  title: "تواصل معنا",
                  onPressed: () {
                    Navigator.pop(context);
                    pushTo(context: context, toPage: ContactWithUs());
                  },
                ),
                SizedBox(height: 2.h),
                _Logout(),
                SizedBox(height: 1.5.h),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LogoutSuccessState) {
              pushAndRemoveUntiTo(
                  context: context, toPage: const LoginScreen());
            } else if (state is LogoutErrorState) {
              if (state.code == 401) {
                AppSharedPreferences.removeToken;
                pushAndRemoveUntiTo(
                    context: context, toPage: const LoginScreen());

                context.read<ProfileCubit>().isEdit = false;
              }
              customSnackBar(
                  context: context, success: 0, message: state.message);
            }
          },
          builder: (context, state) {
            final AuthCubit logoutCubit = AuthCubit.get(context);

            if (state is LogoutLoadingState) {
              return const AppLoading();
            }

            return CustomButton(
              height: 6,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => LogoutDialog(authCubit: logoutCubit),
                );
              },
              titlebutton: "تسجيل خروج",
            );
          },
        ));
  }
}

class _UserLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          AppSharedPreferences.removeToken;
          pushAndRemoveUntiTo(context: context, toPage: const LoginScreen());
        }
      },
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const DrawerShimmer();
        }

        if (state is ProfileErrorState) {
          return TryAgain(
              small: true,
              message: state.message,
              onTap: () {
                context.read<ProfileCubit>().getProfileInfo();
              });
        }
        String? image = context.read<ProfileCubit>().userPhotoUrl;
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                context.read<MainPageCubit>().moveTab(2);
              },
              child: Container(
                width: 30.w,
                height: 30.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  boxShadow: blueBoxShadow,
                  shape: BoxShape.circle,
                ),
                child: image != null
                    ? CachedImage(isPerson: true, imageUrl: image)
                    : Icon(
                        Icons.person,
                        color: AppColors.secondary,
                        size: 45.sp,
                      ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              context.read<ProfileCubit>().userNamseCont.text,
              style: AppTextStyles.largeTitle.copyWith(fontSize: 12.sp),
            ),
            SizedBox(height: 2.h),
            Divider(
              color: AppColors.primary.withOpacity(0.5),
              height: 0.h,
              thickness: 2,
            ),
            SizedBox(height: 2.h),
          ],
        );
      },
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppCliper(),
      child: Container(
          padding: EdgeInsets.only(bottom: 4.h, top: 3.h),
          width: 100.w,
          height: 13.h,
          decoration: const BoxDecoration(
            color: AppColors.secondary,
          ),
          child: Image.asset(
            Images.appLogo,
          )),
    );
  }
}

class DrawerShimmer extends StatelessWidget {
  const DrawerShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
        child: Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 15.w,
        ),
        SizedBox(height: 2.h),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          height: 3.h,
          width: 30.w,
        )
      ],
    ));
  }
}
