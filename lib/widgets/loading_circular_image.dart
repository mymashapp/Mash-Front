import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mash/configs/app_colors.dart';

Widget loadingCircularImage(String imageUrl, [double? radius]) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(200),
    child: FancyShimmerImage(
      height: radius == null ? 44.h : radius.h * 2.h,
      width: radius == null ? 44.h : radius.h * 2.h,
      boxDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      imageUrl: imageUrl,
      shimmerBaseColor: AppColors.lightOrange,
      shimmerHighlightColor: AppColors.kOrange,
      shimmerBackColor: AppColors.lightOrange,
      boxFit: BoxFit.cover,
      errorWidget: Container(
          color: Colors.white, child: Image.asset("assets/mash_logo.png")),
    ),
  );
}

Widget loadingImage(String imageUrl, [BoxFit? fit]) {
  return FancyShimmerImage(
    boxDecoration: BoxDecoration(
      color: AppColors.lightOrange,
    ),
    imageUrl: imageUrl,
    shimmerBaseColor: AppColors.lightOrange,
    shimmerHighlightColor: AppColors.kOrange,
    shimmerBackColor: AppColors.lightOrange,
    width: double.infinity,
    boxFit: fit == null ? BoxFit.contain : fit,
    errorWidget: Container(
        color: Colors.white, child: Image.asset("assets/mash_logo.png")),
  );
}
