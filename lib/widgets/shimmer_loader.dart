import 'package:flutter/material.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoadingCard(
    {required double height, double? radius, double? width}) {
  return Shimmer.fromColors(
    baseColor: AppColors.lightOrange,
    highlightColor: Colors.white,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: radius == null
            ? BorderRadius.circular(40)
            : BorderRadius.circular(radius),
        color: AppColors.kOrange,
      ),
    ),
  );
}
