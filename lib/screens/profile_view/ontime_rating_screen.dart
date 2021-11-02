import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';

class OnTimeRatingScreen extends StatelessWidget {
  const OnTimeRatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:   appAppBar(title: "David's On Time Ratings"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "(0= No Show ,5=onTime)",
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                alignment: Alignment.center,
                height: 130.h,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.kOrange.withOpacity(0.5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "1.52",
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.black, fontSize: 30.sp),
                    ),
                    Text("Davis is usually late",
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.black, fontSize: 17.sp)),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ratingRow(),
                    SizedBox(
                      height: 3.w,
                    ),
                    ratingRow(),
                    SizedBox(
                      height: 3.w,
                    ),
                    ratingRow(),
                    SizedBox(
                      height: 3.w,
                    ),
                    ratingRow(),
                    SizedBox(
                      height: 3.w,
                    ),
                    ratingRow(),
                    SizedBox(
                      height: 3.w,
                    ),
                    ratingRow(),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Last [500] ratings",
                style: TextStyle(fontSize: 21.sp),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row ratingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          child: Text(
            "5",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.kOrange,
        ),
        SizedBox(
          width: 10.w,
        ),
        Container(
          width: 200,
          height: 15,
          child: Container(
            width: 50,
            height: 15,
            decoration: BoxDecoration(color: AppColors.kOrange),
          ),
          decoration: BoxDecoration(color: Colors.grey),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          "[5]",
        )
      ],
    );
  }
}
