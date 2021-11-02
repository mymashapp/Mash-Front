import 'dart:convert';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/screens/chat_view/API/add_friend.dart';
import 'package:mash/screens/chat_view/models/other_user_model.dart';
import 'package:mash/screens/feed_view/API/get_friends_list.dart';
import 'package:mash/screens/feed_view/models/post_model.dart';
import 'package:mash/screens/profile_view/API/create_perosnal_chat.dart';
import 'package:mash/screens/profile_view/API/get_other_profile.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/spacers.dart';

class OtherUserProfile extends StatefulWidget {
  final int userId;
  final String userName;
  final bool alreadyFriend;
  const OtherUserProfile(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.alreadyFriend})
      : super(key: key);

  @override
  _OtherUserProfileState createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  final databaseRef = FirebaseDatabase.instance.reference();
  List<PostModel> list = <PostModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        backgroundColor: AppColors.kOrange,
      ),
      body: FutureBuilder<OtherUser>(
          future: getOtherProfileDetails(widget.userId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 240.h,
                      padding: EdgeInsets.all(16.w),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Container(
                              height: 120.h,
                              width: Get.width,
                              color: AppColors.lightOrange,
                              child: Image.network(
                                "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // profileUploadingDialog();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    height: 120.h,
                                    width: 120.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.shadowColor,
                                              offset: Offset(2, 2),
                                              blurRadius: 6)
                                        ],
                                        border: Border.all(
                                            color: AppColors.kOrange,
                                            width: 3)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500.r),
                                        child: FutureBuilder<String>(
                                            future: getProfile(widget.userId),
                                            builder: (context, urlSnap) {
                                              return FancyShimmerImage(
                                                imageUrl: urlSnap.hasData
                                                    ? urlSnap.data!
                                                    : "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                                shimmerBaseColor: Colors.white,
                                                shimmerHighlightColor:
                                                    AppColors.lightOrange,
                                                shimmerBackColor:
                                                    AppColors.lightOrange,
                                                boxFit: BoxFit.cover,
                                              );
                                            })),
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.h, top: 130.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data!.fullName} ${DateTime.now().difference(snapshot.data!.dob!).inDays ~/ 365}",
                                        style: GoogleFonts.sourceSansPro(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.place_outlined),
                                          Text(
                                            snapshot.data!.userBasicExtra ==
                                                    null
                                                ? "No location"
                                                : snapshot.data!.userBasicExtra!
                                                    .location!,
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                      snapshot.data!.vaccinationStatus == 0
                                          ? SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                Get.dialog(Dialog(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.warning,
                                                          color:
                                                              AppColors.kOrange,
                                                          size: 40,
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        Text(
                                                          "Covid Vaccinated sticker is self-reported and not independently verified by Mash App. We can't guarantee that a member is vaccinated or can't transmit the COVID-19 virus.",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .kOrange,
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/covid1.png",
                                                    width: 70,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Not verified by Mash. Tap to view more information.",
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: FutureBuilder<bool>(
                        future: checkFriend(widget.userId),
                        builder: (context, snap) {
                          if (snap.hasData) {
                            return Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    onPressed: () {
                                      createPersonalChat(snapshot.data!.userId!,
                                          snapshot.data!.fullName!, true);
                                    },
                                    child: Text(
                                      "Send Message",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: AppColors.kOrange,
                                  ),
                                ),
                                SizedBox(
                                  width: snap.data! ? 0 : 16,
                                ),
                                snap.data!
                                    ? SizedBox()
                                    : Expanded(
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          onPressed: () {
                                            addFriend(snapshot.data!.userId!);
                                          },
                                          child: Text(
                                            "Add Friend",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: AppColors.kOrange,
                                        ),
                                      ),
                              ],
                            );
                          } else {
                            return loading();
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 16.h),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.shadowColor,
                              blurRadius: 12,
                              offset: Offset(0, 4))
                        ],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Basic Info",
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kOrange),
                          ),
                          y10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              outLineBorderButton(
                                  snapshot.data!.height == null
                                      ? "No Height"
                                      : snapshot.data!.height.toString(),
                                  "Height"),
                              SizedBox(
                                width: 10,
                              ),
                              outLineBorderButton(
                                  snapshot.data!.school ?? "No School",
                                  "School"),
                            ],
                          ),
                          y16,
                          Text(
                            "Top 3 Interest",
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kOrange),
                          ),
                          y10,
                          snapshot.data!.userBasicExtra != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    outLineBorderButton(
                                        snapshot.data!.userBasicExtra!
                                            .interests![0],
                                        null),
                                    SizedBox(width: 10.w),
                                    outLineBorderButton(
                                        snapshot.data!.userBasicExtra!
                                            .interests![1],
                                        null),
                                    SizedBox(width: 10.w),
                                    outLineBorderButton(
                                        snapshot.data!.userBasicExtra!
                                            .interests![2],
                                        null),
                                  ],
                                )
                              : Row(
                                  children: [
                                    outLineBorderButton(
                                        "No Interest Found", null),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    y16,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.shadowColor,
                              blurRadius: 12,
                              offset: Offset(0, 4))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Media",
                                  style: GoogleFonts.sourceSansPro(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kOrange),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          StreamBuilder(
                            stream: databaseRef
                                .child("global_sharing")
                                .orderByChild("user_id")
                                .equalTo(snapshot.data!.userId)
                                // .orderByChild("timestamp")
                                .onValue,
                            builder: (context, AsyncSnapshot<Event> snap) {
                              if (snap.hasData) {
                                DataSnapshot dataValues = snap.data!.snapshot;
                                if (dataValues.value != null) {
                                  Map<dynamic, dynamic> values =
                                      dataValues.value;
                                  list.clear();
                                  values.forEach((key, values) {
                                    list.insert(0,
                                        postModelFromJson(jsonEncode(values)));
                                  });
                                  print(list[0].likes);
                                }
                                return list.length == 0
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 32),
                                        child: Center(
                                          child: Text("No Media available"),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 150,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder: (ctx, index) {
                                              return SizedBox(
                                                width: 16,
                                              );
                                            },
                                            physics: BouncingScrollPhysics(),
                                            itemCount: list.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.all(16),
                                            itemBuilder: (context, i) {
                                              PostModel postModel = list[i];
                                              return Container(
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: AppColors
                                                            .shadowColor,
                                                        offset: Offset(3, 3),
                                                        blurRadius: 6,
                                                      )
                                                    ],
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            postModel
                                                                .imgUrl!))),
                                              );
                                            }),
                                      );
                              } else {
                                return loading();
                              }
                            },
                          ),
                          // Container(
                          //   height: 100.h,
                          //   child: ListView.separated(
                          //       separatorBuilder: (context, index) {
                          //         return SizedBox(
                          //           width: 10,
                          //         );
                          //       },
                          //       padding: EdgeInsets.zero,
                          //       shrinkWrap: true,
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: 6,
                          //       itemBuilder: (context, i) {
                          //         return Container(
                          //           width: 100.w,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(10.r),
                          //               image: DecorationImage(
                          //                   fit: BoxFit.cover,
                          //                   image: NetworkImage(
                          //                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIJ45Vo-GeeNNu5HKQZbRHkFvjhv5x_5GrKQ&usqp=CAU"))),
                          //         );
                          //       }),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return loading();
            }
          }),
    );
  }
}

Expanded outLineBorderButton(String title, String? hint) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hint == null
            ? SizedBox()
            : Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  hint,
                  style: TextStyle(color: AppColors.kOrange),
                ),
              ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
                color: AppColors.lightOrange,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.shadowColor,
                      offset: Offset(2, 2),
                      blurRadius: 4)
                ],
                border: Border.all(color: AppColors.kOrange),
                borderRadius: BorderRadius.circular(6.r)),
            child: Text(
              title,
              style: GoogleFonts.sourceSansPro(color: AppColors.kOrange),
            ),
          ),
        )
      ],
    ),
  );
}
