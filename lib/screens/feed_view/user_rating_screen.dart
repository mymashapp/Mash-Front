import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/widgets/app_bar_widget.dart';

class UserRatingScreen extends StatelessWidget {
  const UserRatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(title: "Central park"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Rating",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.kOrange),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "4.6",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            height: 130.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                                color: AppColors.kOrange,
                                borderRadius: BorderRadius.circular(15.r)),
                          ),
                          Text(
                            "Last [500] ratings",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Past Events",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.kOrange),
                      ),
                      ListTile(
                        title: Text("Black Flamingo, Brooklyn NY 10010"),
                        subtitle: Text("May 25, 2021"),
                      ),
                      Divider(
                        color: AppColors.kOrange,
                        height: 0.2.h,
                      ),
                      ListTile(
                        title: Text("Black Flamingo, Brooklyn NY 10010"),
                        subtitle: Text("May 25, 2021"),
                      ),
                      Divider(
                        color: AppColors.kOrange,
                        height: 0.2.h,
                      ),
                      ListTile(
                        title: Text("Black Flamingo, Brooklyn NY 10010"),
                        subtitle: Text("May 25, 2021"),
                      ),
                      Divider(
                        color: AppColors.kOrange,
                        height: 0.2.h,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 250.h,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Media",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.kOrange),
                      ),
                      Expanded(
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 0.1,
                                    crossAxisSpacing: 0.1),
                            itemCount: 6,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Image.network(
                                "https://images.unsplash.com/photo-1618588507085-c79565432917?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhdXRpZnVsJTIwbmF0dXJlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
                                fit: BoxFit.cover,
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
