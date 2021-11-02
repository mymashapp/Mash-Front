import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/widgets/app_bar_widget.dart';
import 'package:mash/widgets/app_button.dart';

class MashPremium extends StatelessWidget {
  const MashPremium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(title: "Active Mash", isBack: false),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(top: 10.h),
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              width: Get.width,
              decoration:
                  BoxDecoration(color: AppColors.kOrange.withOpacity(0.2)),
              child: Column(
                children: [
                  Text(
                    "Activate Mash Premium",
                    style: TextStyle(
                        color: AppColors.kOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Container(
                    // width: 50,
                    height: 40,
                    child: Expanded(
                      child: ListView.builder(
                          //padding: EdgeInsets.symmetric(vertical: 10.h),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, i) {
                            return CircleAvatar(
                              radius: 30.r,
                              backgroundColor: AppColors.kOrange,
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Text(
                    "You’ve run out of swipes! Get Mash \nPremium to get unlimited swipes\n\nGet 1 free boost a month!",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.kOrange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              height: 150,
              width: Get.width,
              margin: EdgeInsets.all(20.w),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.5,
                      crossAxisSpacing: 2,
                      childAspectRatio: 5),
                  itemCount: 8,
                  itemBuilder: (context, i) {
                    return Row(
                      children: [
                        Text(
                          "Unlimited Matches",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                        Checkbox(
                          value: true,
                          onChanged: (v) {},
                          activeColor: AppColors.kOrange,
                        )
                      ],
                    );
                  }),
            ),
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //  childAspectRatio: 5,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, i) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.kOrange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1 month\n \$31.99/mo",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.kBlue,
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Save 15%",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Padding(
              padding: EdgeInsets.all(16),
              child: appButton(
                  onTap: () {},
                  textColor: Colors.white,
                  buttonBgColor: AppColors.kOrange,
                  buttonName: "Continue"),
            )
          ],
        ),
      ),
    );
  }
}
