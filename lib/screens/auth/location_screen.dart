import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/home/API/get_user_location.dart';
import 'package:mash/screens/home/home_screen.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/spacers.dart';

class LocationEnable extends StatelessWidget {
  const LocationEnable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  "assets/maplogo.png",
                  height: Get.height / 4,
                ),
                Text(
                  "Enable Location",
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 20.sp, color: AppColors.kOrange),
                ),
                y16,
                Text(
                  "You'll need to enable your location in\norder to use Mash",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(
                  height: 45.h,
                ),
                Spacer(),
                appButton(
                    onTap: () async {
                      if (!testing) {
                        await getUserLocation();
                      }
                      Get.to(() => HomeScreen());
                    },
                    textColor: Colors.white,
                    buttonName: "Allow Location",
                    buttonBgColor: AppColors.kOrange),
                y16,
                y16
              ],
            ),
          ),
          Obx(() => authController.loading.value
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
              : SizedBox())
        ],
      ),
    );
  }
}
