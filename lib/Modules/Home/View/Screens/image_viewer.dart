import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: AppColors.secondary,
      ),
      body: InteractiveViewer(
        child: Center(child: CachedImage(imageUrl: imageUrl)

            /* Image.network(
            "${Urls.storageBaseUrl}$imageUrl",
            fit: BoxFit.contain,

            loadingBuilder: (context, child, loadingProgress) {


              print(loadingProgress?.cumulativeBytesLoaded);
              if (loadingProgress != null) {
                return const AppLoading();
              } else {
                return child;
              }
            },
          ),*/
            ),
      ),
    );
  }
}
