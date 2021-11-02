import 'dart:convert';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/auth/sign_in%20_screen.dart';
import 'package:mash/screens/auth/widget/profile_uploading_dialog.dart';
import 'package:mash/screens/feed_view/models/post_model.dart';
import 'package:mash/screens/home/controller/home_controller.dart';
import 'package:mash/screens/profile_view/controller/profile_controller.dart';
import 'package:mash/screens/profile_view/create_post.dart';
import 'package:mash/screens/profile_view/profile_tab.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/spacers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());
  FirebaseAuth auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.reference();
  List<PostModel> list = <PostModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                authController.fullName.value.text =
                    authController.user.value.fullName ?? "";
                authController.height.value.text =
                    authController.user.value.height == null
                        ? ""
                        : authController.user.value.height.toString();
                authController.school.value.text =
                    authController.user.value.school ?? "";
                Get.to(() => ProfileTab());
              },
              icon: Icon(
                Icons.manage_accounts_outlined,
                color: AppColors.kOrange,
                size: 38,
              )),
          SizedBox(
            width: 14,
          )
        ],
      ),
      body: Obx(() => authController.loading.value
          ? loading()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 230.h,
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            height: 130.h,
                            width: Get.width,
                            alignment: Alignment.bottomRight,
                            color: AppColors.lightOrange,
                            child: Image.network(
                              // "https://s3.envato.com/files/244485530/Sweep_03_loop_Preview.jpg",
                              "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg",
                              fit: BoxFit.fitWidth,
                              width: Get.width,
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
                                  profileUploadingDialog();
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
                                          color: AppColors.kOrange, width: 3)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(500.r),
                                    child: Obx(() => authController
                                            .profileUploading.value
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      AppColors.kOrange),
                                            ),
                                          )
                                        : FancyShimmerImage(
                                            imageUrl: authController.profileUrl
                                                        .value.length >
                                                    1
                                                ? authController
                                                    .profileUrl.value
                                                : "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                            shimmerBaseColor: Colors.white,
                                            shimmerHighlightColor:
                                                AppColors.lightOrange,
                                            shimmerBackColor:
                                                AppColors.lightOrange,
                                            boxFit: BoxFit.cover,
                                          )),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.h, top: 130.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Obx(() => Text(
                                          "${authController.user.value.fullName}, ${authController.user.value.dob == null ? "" : DateTime.now().difference(authController.user.value.dob!).inDays ~/ 365}",
                                          style: GoogleFonts.sourceSansPro(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Row(
                                      children: [
                                        Icon(Icons.place_outlined),
                                        authController.user.value
                                                    .userBasicExtra ==
                                                null
                                            ? Text(
                                                "No Location",
                                                style: TextStyle(fontSize: 16),
                                              )
                                            : Text(
                                                authController
                                                        .user
                                                        .value
                                                        .userBasicExtra!
                                                        .location ??
                                                    "",
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        fontSize: 16.sp),
                                              ),
                                        Spacer(),
                                      ],
                                    ),
                                    authController
                                                .user.value.vaccinationStatus ==
                                            0
                                        ? SizedBox()
                                        : InkWell(
                                            onTap: () {
                                              Get.dialog(Dialog(
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.0),
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
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
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
                    child: Obx(() => Column(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                outLineBorderButton(
                                    authController.user.value.height == null
                                        ? "No Height"
                                        : "${authController.user.value.height} ft.",
                                    "Height"),
                                SizedBox(
                                  width: 10,
                                ),
                                outLineBorderButton(
                                    authController.user.value.school ??
                                        "No School",
                                    "School"),
                              ],
                            ),
                            y16,
                            Text(
                              "Top 3 Interests",
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kOrange),
                            ),
                            y10,
                            authController.interestList.length == 3
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      outLineBorderButton(
                                          authController.interestList[0], null),
                                      SizedBox(width: 10.w),
                                      outLineBorderButton(
                                          authController.interestList[1], null),
                                      SizedBox(width: 10.w),
                                      outLineBorderButton(
                                          authController.interestList[2], null),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      outLineBorderButton(
                                          "No Interest Found", null),
                                    ],
                                  ),
                          ],
                        )),
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
                          padding: EdgeInsets.only(left: 16),
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {
                                      Get.to(() => CreatePost());
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: AppColors.kOrange,
                                    )),
                              )
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream: databaseRef
                              .child("global_sharing")
                              .orderByChild("user_id")
                              .equalTo(authController.user.value.userId)
                              // .orderByChild("timestamp")
                              .onValue,
                          builder: (context, AsyncSnapshot<Event> snap) {
                            if (snap.hasData) {
                              DataSnapshot dataValues = snap.data!.snapshot;
                              if (dataValues.value != null) {
                                Map<dynamic, dynamic> values = dataValues.value;
                                list.clear();
                                values.forEach((key, values) {
                                  list.insert(
                                      0, postModelFromJson(jsonEncode(values)));
                                });
                                print(list[0].likes);
                              }
                              return list.length == 0
                                  ? SizedBox()
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
                                                      BorderRadius.circular(6),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          AppColors.shadowColor,
                                                      offset: Offset(3, 3),
                                                      blurRadius: 6,
                                                    )
                                                  ],
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          postModel.imgUrl!))),
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
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: appButton(
                        onTap: () {
                          HomeController homeController =
                              Get.put(HomeController());
                          homeController.bottomIndex.value = 0;
                          final box = GetStorage();
                          box.erase();
                          auth.signOut();
                          Get.offAll(() => SignIn());
                        },
                        buttonName: "Logout",
                        buttonBgColor: AppColors.kOrange,
                        textColor: Colors.white),
                  )
                ],
              ),
            )),
    );
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
}
