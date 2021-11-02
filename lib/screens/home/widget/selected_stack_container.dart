import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/widgets/app_button.dart';

Widget selectedStackContainer(
    {listLength, selectedIndex, title, onTap, onSelect}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15.r),
    child: Container(
      margin: EdgeInsets.all(32),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Color(0xffFBD8B4).withAlpha(200),
          borderRadius: BorderRadius.circular(15.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: listLength /*homeController.categoryList.length*/,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    onSelect(i);
                  },
                  child: Container(
                    height: 52.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                        color: selectedIndex == i
                            ? AppColors.kOrange
                            : Colors.transparent,
                        boxShadow: selectedIndex == i
                            ? [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(4, 4),
                                  blurRadius: 6,
                                )
                              ]
                            : null,
                        /* border: Border.all(
                              color: selectedIndex==i ?Colors.black:Colors.transparent
                          ),*/
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title[i],
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 20.sp,
                              color: selectedIndex == i
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        selectedIndex == i
                            ? Icon(
                                Icons.task_alt_outlined,
                                color: selectedIndex == i
                                    ? Colors.white
                                    : Colors.black,
                                size: 30.sp,
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                );
              }),
          appButton(
            onTap: onTap,
            buttonBgColor: Color(0xff564B40),
            buttonName: "Apply",
            textColor: Colors.white,
          )
        ],
      ),
    ),
  );
}
