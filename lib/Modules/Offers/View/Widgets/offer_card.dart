import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Offers/Models/offer.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    required this.offer,
    this.isHome = false,
    super.key,
  });
  final Offer offer;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isHome ? 0.4.h : 0),
      child: Stack(
        children: [
          Container(
            height: 22.h,
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    offset: const Offset(0, 0.5),
                    blurRadius: 1.5,
                    spreadRadius: 1,
                  )
                ],
                image: DecorationImage(
                    image: offer.image == null
                        ? AssetImage(Images.offersBack)
                        : CachedNetworkImageProvider(
                            "${Urls.storageBaseUrl}${offer.image}"),
                    fit: BoxFit.cover),
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20)),
            foregroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)),
          ),
          Container(
            width: double.infinity,
            height: 22.h,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (offer.discount != null)
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    '${offer.discount}% مجاني',
                    style: AppTextStyles.secondTitle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: textShadow,
                        fontSize: 9.sp),
                  ),
                if (offer.name != null)
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    offer.name!,
                    style: AppTextStyles.secondTitle.copyWith(
                        color: Colors.white,
                        shadows: textShadow,
                        fontSize: 9.sp),
                  ),
                if (offer.description != null)
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    offer.description!,
                    style: AppTextStyles.secondTitle.copyWith(
                        color: Colors.white,
                        shadows: textShadow,
                        fontSize: 9.sp),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
