import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/chat_view/congrats_screen.dart';
import 'package:mash/screens/chat_view/controller/chat_controller.dart';
import 'package:mash/widgets/app_bar_widget.dart';
import 'package:mash/widgets/app_button.dart';

class MeetUpRate extends StatefulWidget {
  @override
  _MeetUpRateState createState() => _MeetUpRateState();
}

class _MeetUpRateState extends State<MeetUpRate> {
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(title: "Rate your mash!", isBack: false),
      body: Padding(
        padding: EdgeInsets.only(left: 16.r, right: 16.r, top: 16.r),
        child: Container(
          height: Get.height,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.kOrange.withOpacity(0.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.kOrange,
                      radius: 60.r,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "David",
                      style: TextStyle(fontSize: 20.sp, color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Did the mashup happen?",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.black),
                      )),
                  OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
              Text(
                "Were they on time (0= No show, 5 = On Time)?",
                style: TextStyle(color: Colors.black, fontSize: 20.sp),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, i) {
                      return SizedBox(
                        width: 5.w,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, i) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            chatController.selectedIndex.value = i;
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                chatController.selectedIndex.value == i
                                    ? AppColors.kOrange
                                    : Colors.grey.withOpacity(0.5),
                            child: Text(
                              "$i",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Text(
                "How was the venue?",
                style: TextStyle(color: Colors.black, fontSize: 20.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: AppColors.kOrange,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Do you want to add [] as a friend?",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.black),
                      )),
                  OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload photo / video of mash",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.camera_alt_outlined)
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25.h),
                child: appButton(
                  onTap: () {
                    Get.to(() => CongratsScreen());
                  },
                  buttonName: "Submit",
                  buttonBgColor: AppColors.kOrange,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
