import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';

Widget appTextField(
    {String? hintText,
    String? suffixText,
    Widget? icon,
    bool? readOnly,
    Widget? prefix,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    TextInputType? textInputType}) {
  return TextFormField(
    controller: controller,
    onChanged: onChanged,
    readOnly: readOnly == null ? false : readOnly,
    validator: validator,
    onFieldSubmitted: onSubmitted,
    keyboardType: textInputType,
    textInputAction: textInputAction,
    style: GoogleFonts.sourceSansPro(fontSize: 16.sp),
    cursorColor: AppColors.kOrange,
    decoration: InputDecoration(
      suffixText: suffixText,
      prefix: prefix,
      prefixIconConstraints: BoxConstraints(minHeight: 40, minWidth: 40),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kOrange,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kOrange,
          )),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kOrange,
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.kOrange,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Colors.red,
          )),
      prefixIcon: icon,
      hintStyle: GoogleFonts.sourceSansPro(
        color: Colors.grey,
        fontSize: 16.sp,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.kOrange)),
      hintText: hintText,
    ),
  );
}
