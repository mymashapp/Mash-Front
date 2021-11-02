import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/screens/feed_view/API/get_friend_request_list.dart';
import 'package:mash/screens/feed_view/API/get_friends_list.dart';
import 'package:mash/screens/feed_view/API/response_to_request.dart';
import 'package:mash/screens/feed_view/controller/friend_controller.dart';
import 'package:mash/screens/profile_view/other_user_profile.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/loading_circular_image.dart';
import 'package:shimmer/shimmer.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> with TickerProviderStateMixin {
  FriendController friendController = Get.put(FriendController());
  List<String> tabs = ["Friends", "Friend Requests"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(2, 2),
                blurRadius: 10)
          ]),
          child: TabBar(
              indicatorColor: AppColors.kOrange,
              physics: BouncingScrollPhysics(),
              controller: authController.friendController.value,
              onTap: (index) {
                if (index == 0) {
                  getFriendList();
                } else {
                  getFriendRequestList();
                }
                HapticFeedback.mediumImpact();
              },
              tabs: List.generate(
                  tabs.length,
                  (index) => Container(
                      alignment: Alignment.topCenter,
                      height: 40,
                      child: Text(
                        tabs[index],
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 18,
                          color: AppColors.kOrange,
                        ),
                        textAlign: TextAlign.center,
                      )))),
        ),
        Expanded(
          child: TabBarView(
              controller: authController.friendController.value,
              children: [FriendScreen(), FriendRequestScreen()]),
        )
      ],
    );
  }
}

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({Key? key}) : super(key: key);

  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  FriendController friendController = Get.put(FriendController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => friendController.loading.value
        ? loading()
        : friendController.friendRequestList.length == 0
            ? Center(
                child: Text(
                  "You don't have any friend requests",
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 16, color: AppColors.kOrange),
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.only(left: 16, top: 16),
                separatorBuilder: (ctx, index) {
                  return SizedBox(
                    height: 16,
                  );
                },
                itemCount: friendController.friendRequestList.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder<String>(
                          future: getProfile(friendController
                              .friendRequestList[i].usersFriendsListFriendId!),
                          builder: (context, snap) {
                            return snap.hasData
                                ? loadingCircularImage(
                                    snap.hasData
                                        ? snap.data!
                                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0J3UmFWmkCK1dScxjgh-2UXHB25ZLHkX9Lg&usqp=CAU",
                                    20.h)
                                : Shimmer.fromColors(
                                    child: Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                    ),
                                    baseColor: AppColors.lightOrange,
                                    highlightColor: Colors.white);
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          friendController.friendRequestList[i].fullName!,
                          style: GoogleFonts.sourceSansPro(fontSize: 16.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      MaterialButton(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        onPressed: () {
                          responseToRequest(
                              friendController.friendRequestList[i]
                                  .usersFriendsListFriendId!,
                              1);
                        },
                        child: Text(
                          "Accept",
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                        color: AppColors.kOrange,
                      ),
                      IconButton(
                          onPressed: () {
                            responseToRequest(
                                friendController.friendRequestList[i]
                                    .usersFriendsListFriendId!,
                                0);
                          },
                          icon: Icon(
                            Icons.clear,
                            color: AppColors.kOrange,
                          )),
                    ],
                  );
                }));
  }
}

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  FriendController friendController = Get.put(FriendController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(20.r),
        //         boxShadow: [
        //           BoxShadow(
        //               blurRadius: 6,
        //               offset: Offset(2, 2),
        //               color: AppColors.shadowColor)
        //         ]),
        //     margin: EdgeInsets.only(
        //       left: 16.w,
        //       right: 16.w,
        //       top: 16.h,
        //     ),
        //     child: Row(
        //       children: [
        //         SizedBox(
        //           width: 16,
        //         ),
        //         Icon(Icons.search),
        //         Expanded(
        //           child: TextFormField(
        //             decoration: InputDecoration(
        //                 border: InputBorder.none,
        //                 hintText: "Search",
        //                 contentPadding:
        //                     EdgeInsets.symmetric(horizontal: 16),
        //                 hintStyle: GoogleFonts.sourceSansPro()),
        //           ),
        //         ),
        //       ],
        //     )),
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: appTextField(
        //       hintText: "Search",
        //       prefix: Icon(
        //         Icons.search,
        //         color: AppColors.kOrange,
        //       )),
        // ),
        Expanded(
          child: Obx(() => friendController.loading.value
              ? loading()
              : friendController.friendList.length == 0
                  ? Center(
                      child: Text(
                        "No Friends Found",
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 16, color: AppColors.kOrange),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      separatorBuilder: (ctx, index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                      itemCount: friendController.friendList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            print(friendController
                                .friendList[i].usersFriendsListFriendId);
                            Get.to(() => OtherUserProfile(
                                alreadyFriend: true,
                                userId: friendController
                                    .friendList[i].usersFriendsListFriendId!,
                                userName:
                                    friendController.friendList[i].fullName!));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder<String>(
                                  future: getProfile(friendController
                                      .friendList[i].usersFriendsListFriendId!),
                                  builder: (context, snap) {
                                    return snap.hasData
                                        ? loadingCircularImage(
                                            snap.hasData
                                                ? snap.data!
                                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0J3UmFWmkCK1dScxjgh-2UXHB25ZLHkX9Lg&usqp=CAU",
                                            20)
                                        : Shimmer.fromColors(
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                            ),
                                            baseColor: AppColors.lightOrange,
                                            highlightColor: Colors.white);
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  friendController.friendList[i].fullName!,
                                  style: GoogleFonts.sourceSansPro(
                                      fontSize: 16.sp),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
        ),
      ],
    );
  }
}
