import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';

class AppPopScope extends StatelessWidget {
  const AppPopScope({super.key, required this.canPop, required this.child});

  final bool canPop;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    bool pop = canPop;
    return PopScope(
        canPop: pop,
        onPopInvoked: (didPop) {
          if (!didPop) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog.adaptive(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  'هل أنت متأكد من الخروج؟',
                  style: AppTextStyles.meduimTitle,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      pop = true;

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'خروج',
                      style: AppTextStyles.meduimTitle.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'إلغاء',
                      style: AppTextStyles.meduimTitle.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
        child: child);
  }
}
