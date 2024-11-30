import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart'; 
import 'package:talents/Modules/Payments_Orders/Model/payment_order.dart'; 
import 'package:talents/Modules/Payments_Orders/View/Widgets/order_state.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';

class PaymentOrderCard extends StatelessWidget {
  const PaymentOrderCard({
    super.key,
    required this.order,
  });
  final PaymentOrder order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      height: 12.h,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              const Border(bottom: BorderSide(color: AppColors.secondary, width: 2)),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(1.w),
              height: 12.h,
              width: 30.w,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: CachedImage(
                imageUrl: order.image,
              )),
          SizedBox(
            width: 1.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  order.section.name,
                  style: AppTextStyles.secondTitle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  maxLines: 1,
                  '${order.section.price} ل.س',
                  style: AppTextStyles.secondTitle,
                )
              ],
            ),
          ),
          OrderState(state: order.status)
        ],
      ),
    );
  }
}
