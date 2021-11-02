import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/screens/chat_view/API/chat_opened.dart';
import 'package:mash/screens/chat_view/chat_view.dart';
import 'package:mash/screens/home/API/remash_service.dart';
import 'package:mash/screens/home/controller/home_controller.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/loading_circular_image.dart';

Widget oneToOneMashedView() {
  HomeController homeController = Get.put(HomeController());
  return ClipRRect(
    borderRadius: BorderRadius.circular(15.r),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
            color: AppColors.lightOrange.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mashed!",
              style: GoogleFonts.sourceSansPro(
                fontSize: 40.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Wrap(
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.spaceBetween,
              alignment: WrapAlignment.center,
              runSpacing: 16,
              spacing: 16,
              children: List.generate(
                  homeController.userOfMashList.length,
                  (index) => Column(
                        children: [
                          FutureBuilder<String>(
                              future: getProfile(homeController
                                  .userOfMashList[index].chatMainUsersId),
                              builder: (context, snap) {
                                return loadingCircularImage(
                                    snap.data == null
                                        ? "https://image.shutterstock.com/image-vector/profile-icon-vectororange-260nw-591156221.jpg"
                                        : snap.data!,
                                    50);
                              }),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${homeController.userOfMashList[index].fullName}",
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
            ),
            Spacer(),
            appButton(
              onTap: () {
                chatOpenedService(
                    homeController.userOfMashList[0].chatMainUsersChatId!);
                Get.to(() => ChatView(
                          messageId: homeController
                              .userOfMashList[0].chatMainUsersChatId!,
                          event: true,
                          eventName: homeController.eventName.value,
                          eventImage: homeController.eventImage.value,
                        ))!
                    .then((value) => homeController.userOfMashList.clear());
              },
              buttonBgColor: AppColors.kOrange,
              buttonName: "Send a Message",
              textColor: Colors.white,
            ),
            SizedBox(
              height: 10.h,
            ),
            appButton(
              onTap: () {
                homeController.userOfMashList.clear();
              },
              buttonBgColor: AppColors.kBlue,
              buttonName: "Keep Swiping",
              textColor: Colors.white,
            ),
            SizedBox(
              height: 10.h,
            ),
            appButton(
              onTap: () {
                homeController.userOfMashList.clear();
                remashService();
              },
              buttonBgColor: Colors.white,
              buttonName: "Re-Mash with New Person",
              textColor: Colors.black,
            )
          ],
        ),
      ),
    ),
  );
}
