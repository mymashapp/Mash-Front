import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';

import '../main.dart';

Widget blurLoader() {
  return Obx(() => authController.loading.value
      ? BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            alignment: Alignment.center,
            color: AppColors.kOrange.withOpacity(0.5),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        )
      : SizedBox());
}

Widget bluLoader() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    child: Container(
      alignment: Alignment.center,
      color: AppColors.kOrange.withOpacity(0.5),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    ),
  );
}

Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.kOrange),
    ),
  );
}
