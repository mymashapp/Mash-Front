import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';

errorSnackBar(title, message) {
  Get.snackbar(title, message,
      colorText: Colors.white,
      backgroundColor: Colors.redAccent,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      shouldIconPulse: true);
}

appSnackBar(title, message) {
  Get.snackbar(title, message,
      colorText: Colors.white,
      backgroundColor: AppColors.kOrange,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        Icons.check_circle_outlined,
        color: Colors.white,
      ),
      shouldIconPulse: true);
}
