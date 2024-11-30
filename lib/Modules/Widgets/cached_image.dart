import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Constant/app_colors.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.isPerson = false,
  });

  final String? imageUrl;
  final bool isPerson;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
       
      progressIndicatorBuilder: (context, url, progress) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        child: Container(
          color: Colors.grey,
        ),
      ),
      imageUrl: "${Urls.storageBaseUrl}$imageUrl",
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => isPerson
          ? Icon(
              Icons.person,
              size: 30 .sp,
              color: AppColors.secondary,
            )
          : Icon(
              Icons.error,
              size: 30.sp,
              color: AppColors.favoriteBlue,
            ),
    );
  }
}
