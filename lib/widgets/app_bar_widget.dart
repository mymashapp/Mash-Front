import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';

AppBar appAppBar({title, IconData? icon, Color? backIconColor, bool? isBack}) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColors.kOrange,
    leading: IconButton(
      onPressed: () {
        HapticFeedback.mediumImpact();
        if (isBack == false) Get.back();
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: backIconColor != null ? backIconColor : Colors.white,
      ),
    ),
    title: Text(
      title,
      style: GoogleFonts.sourceSansPro(),
    ),
    centerTitle: true,
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 16.0.sp),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    ],
  );
}
