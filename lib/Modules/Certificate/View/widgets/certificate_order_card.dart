import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Certificate/Model/certificate_order.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';

class CertificateOrderCard extends StatelessWidget {
  const CertificateOrderCard({
    super.key,
    required this.certificateOrder,
  });
  final CertificateOrder certificateOrder;

  String getTitle({required String state}) {
    final List<String> titles = ["تحميل الشهادة", "قيد الانتظار", "مرفوضة"];
    switch (state) {
      case "accepted":
        return titles[0];

      case "pending":
        return titles[1];

      case "rejected":
        return titles[2];

      default:
        return "";
    }
  }

  Color? getColor({required String state}) {
    final List<Color?> colors = [
      null,
      const Color.fromRGBO(255, 152, 0, 50),
      Colors.red[800]
    ];
    switch (state) {
      case "accepted":
        return colors[0];
      case "pending":
        return colors[1];
      case "rejected":
        return colors[2];

      default:
        return AppColors.primary;
    }
  }

  String getDate({required CertificateOrder order}) {
    switch (order.status) {
      case "accepted":
        return order.acceptedAt ?? "";
      case "pending":
        return order.cereatedAt ?? "";
      case "rejected":
        return order.rejectedAt ?? "";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.5.w),
      margin: EdgeInsets.only(
        bottom: 2.h,
        left: 4.w,
        right: 4.w,
      ),
      decoration: BoxDecoration(
        // boxShadow: boxShadow,
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border:
            const Border(bottom: BorderSide(width: 2, color: AppColors.secondary)),
      ),
      height: 15.h,
      width: 100.w,
      child: Row(
        children: <Widget>[
          Container(
            width: 30.w,
            clipBehavior: Clip.hardEdge,
            height: 18.h,
            decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(15)),
            child: CachedImage(imageUrl: certificateOrder.course.image),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                certificateOrder.course.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.secondTitle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Text(
                certificateOrder.course.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.secondTitle,
              ),
              const Spacer(),
              Row(
                children: [
                  CustomButton(
                      background: getColor(state: certificateOrder.status),
                      width: 22,
                      height: 3.5,
                      fontSize: 8,
                      titlebutton: getTitle(
                          state:  certificateOrder.status ), // stateText[index % 3],
                      onPressed: () async {
                        if (certificateOrder.status == "accepted") {
                          await EasyLauncher.url(
                              url:
                                  "${Urls.storageBaseUrl}${certificateOrder.file}");
                        }
                      }),
                  const Spacer(),
                  Text(
                    getDate(order: certificateOrder).substring(0, 10),
                    style: AppTextStyles.questionsText
                        .copyWith(color: AppColors.primary),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
