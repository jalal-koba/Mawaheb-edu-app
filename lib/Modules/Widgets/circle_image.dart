import 'package:animate_do/animate_do.dart'; 
import 'package:flutter/material.dart'; 
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/public_constant.dart';

import 'cached_image.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.imageUrl,
    required this.size,
  });
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: boxShadow,
          border: Border.all(color: AppColors.primary, width: 0.5),
          shape: BoxShape.circle,
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(100),
          child: CachedImage(imageUrl: imageUrl),
        ),
      ),
    );
  }
}
