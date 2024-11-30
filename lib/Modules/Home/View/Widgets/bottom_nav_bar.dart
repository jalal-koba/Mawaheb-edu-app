import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Modules/Home/Cubit/cubit/main_page_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: context.watch<MainPageCubit>().selectedPage,
      height: 60.0,
      items:const <Widget>[
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.menu_book_outlined,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
      ],
      color: AppColors.secondary,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      buttonBackgroundColor: AppColors.buttonColor,
      animationDuration: const Duration(milliseconds: 400),
      onTap: (index) {
        print(index);
    
        context.read<MainPageCubit>().moveTab(index);
      },
      letIndexChange: (index) => true,
    );
  }
}
