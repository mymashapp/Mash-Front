import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/widgets/app_button.dart';

import 'API/upload_user_detail.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  List<String> genderList = ["Man", "Woman", "Both"];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          // appButton(
          //     onTap: () {
          //       //Get.to(()=>UpComingEventsScreen());
          //       Get.to(() => MashPremium());
          //     },
          //     buttonBgColor: AppColors.kOrange,
          //     textColor: Colors.white,
          //     buttonName: "Get Mash Premium"),
          SizedBox(
            height: 10.h,
          ),
          // Obx(() => Container(
          //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(8.r),
          //           border: Border.all(color: Colors.black, width: 1)),
          //       child: Column(
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 "Distance",
          //                 style: GoogleFonts.sourceSansPro(
          //                     fontSize: 15, fontWeight: FontWeight.bold),
          //               ),
          //               Text(
          //                 "${authController.distance.value.toInt()} Miles",
          //                 style: GoogleFonts.sourceSansPro(
          //                     fontSize: 15, fontWeight: FontWeight.bold),
          //               )
          //             ],
          //           ),
          //           Slider(
          //             value: authController.distance.value,
          //             onChanged: (v) {
          //               authController.distance.value = v;
          //             },
          //             inactiveColor: Colors.grey,
          //             activeColor: AppColors.kOrange,
          //             min: 1,
          //             max: 19,
          //           )
          //         ],
          //       ),
          //     )),
          // SizedBox(
          //   height: 10.h,
          // ),
          Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Age",
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${authController.minAge.value.toInt()} - ${authController.maxAge.value.toInt()}",
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    RangeSlider(
                      values: RangeValues(authController.minAge.value,
                          authController.maxAge.value),
                      onChanged: (v) {
                        authController.minAge.value = v.start;
                        authController.maxAge.value = v.end;
                      },
                      inactiveColor: Colors.grey,
                      activeColor: AppColors.kOrange,
                      min: 18,
                      max: 45,
                    )
                  ],
                ),
              )),

          // ListView.builder(
          //     physics: NeverScrollableScrollPhysics(),
          //     padding: EdgeInsets.zero,
          //     shrinkWrap: true,
          //     itemCount: homeController.datingList.length,
          //     itemBuilder: (context, i) {
          //       return Obx(() => Container(
          //             height: 52.h,
          //             decoration: BoxDecoration(
          //                 color: homeController.datingSelectedIndex.value == i
          //                     ? AppColors.kOrange
          //                     : Colors.white,
          //                 border: Border.all(
          //                     color:
          //                         homeController.datingSelectedIndex.value == i
          //                             ? AppColors.kOrange
          //                             : Colors.transparent),
          //                 borderRadius: BorderRadius.circular(8.r)),
          //             child: Material(
          //               color: Colors.transparent,
          //               child: InkWell(
          //                   borderRadius: BorderRadius.circular(8.r),
          //                   onTap: () {
          //                     HapticFeedback.mediumImpact();
          //                     homeController.datingSelectedIndex.value = i;
          //                   },
          //                   child: Container(
          //                     padding: EdgeInsets.symmetric(horizontal: 16.w),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           homeController.datingList[i],
          //                           style: GoogleFonts.sourceSansPro(
          //                             fontSize: 16.sp,
          //                             color: homeController
          //                                         .datingSelectedIndex.value ==
          //                                     i
          //                                 ? Colors.white
          //                                 : Colors.black,
          //                           ),
          //                         ),
          //                         homeController.datingSelectedIndex.value == i
          //                             ? Icon(
          //                                 Icons.task_alt_outlined,
          //                                 color: Colors.white,
          //                                 size: 30.sp,
          //                               )
          //                             : SizedBox()
          //                       ],
          //                     ),
          //                   )),
          //             ),
          //           ));
          //     }),
          SizedBox(
            height: 10.h,
          ),
          Divider(),
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: genderList.length,
              itemBuilder: (context, i) {
                return Obx(() => Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                          color: authController.genderPre.value == genderList[i]
                              ? AppColors.kOrange
                              : Colors.white,
                          border: Border.all(
                              color: authController.genderPre.value ==
                                      genderList[i]
                                  ? AppColors.kOrange
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(8.r),
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              authController.genderPre.value = genderList[i];
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    genderList[i],
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 16.sp,
                                      color: authController.genderPre.value ==
                                              genderList[i]
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  authController.genderPre.value ==
                                          genderList[i]
                                      ? Icon(
                                          Icons.task_alt_outlined,
                                          color: Colors.white,
                                          size: 30.sp,
                                        )
                                      : SizedBox()
                                ],
                              ),
                            )),
                      ),
                    ));
              }),
          SizedBox(
            height: 20.h,
          ),
          appButton(
              onTap: () {
                updateUserPreferenceData();
                //   Get.to(()=>OnTimeRatingScreen());
              },
              buttonBgColor: AppColors.kOrange,
              textColor: Colors.white,
              buttonName: "Accept Changes"),
        ],
      ),
    );
  }
}
