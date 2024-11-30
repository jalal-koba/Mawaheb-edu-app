 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Modules/Widgets/back_step.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.fontSize = 14,
  });
  final String title;
  final Widget body;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: BackStep(
            fontSize: fontSize,
            title: title,
          ),
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: AppColors.secondary),
          automaticallyImplyLeading: false,
          shadowColor: Colors.black,
          backgroundColor: AppColors.secondary,
          surfaceTintColor: Colors.transparent,
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.appBack), fit: BoxFit.fill)),
            child: body));
  }
}
