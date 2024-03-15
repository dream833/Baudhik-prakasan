import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ssgc/app/data/app_image.dart';

// class AppImageLoader {
//   static appImage(String imageUrl, double height, double width){
//
//   }
// }

class AppImageLoader extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Color? loaderColor;
  const AppImageLoader({super.key, required this.imageUrl, required this.height, required this.width, this.loaderColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: loaderColor,)),
        errorWidget: (context, url, error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image(
                  height: height,
                  width: width,
                  image: AssetImage('assets/images/no_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              // Text("No image found"),
            ],
          ),
        ),
      ),
    );
  }
}
