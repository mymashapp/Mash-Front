import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';

Widget appButton(
    {required Color buttonBgColor,
    String? buttonName,
    Color? textColor,
    required VoidCallback onTap}) {
  return Container(
    alignment: Alignment.center,
    height: 52.h,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 10,
        offset: Offset(2, 12),
      )
    ], color: buttonBgColor, borderRadius: BorderRadius.circular(8.r)),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
          child: Text(
            buttonName!,
            style: GoogleFonts.sourceSansPro(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: textColor == null ? Colors.white : textColor),
          ),
        ),
      ),
    ),
  );
}

Widget appButtonLogin(
    {bool? isBorder,
    Color? buttonBgColor,
    String? buttonName,
    Color? textColor,
    required VoidCallback onTap}) {
  return Container(
    alignment: Alignment.center,
    height: 52.h,
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: buttonBgColor,
      border: Border.all(
          color: isBorder == true ? Colors.white : Colors.transparent),
      borderRadius: BorderRadius.circular(40.r),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25.r),
        onTap: () {
          HapticFeedback.mediumImpact();
          onTap();
        },
        child: Center(
          child: Text(
            buttonName!,
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: textColor!),
          ),
        ),
      ),
    ),
  );
}
