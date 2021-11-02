import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/chat_view/API/sned_personal_message.dart';
import 'package:mash/screens/feed_view/API/get_friends_list.dart';
import 'package:mash/screens/feed_view/controller/friend_controller.dart';
import 'package:mash/screens/home/model/air_bnb_model.dart';
import 'package:mash/screens/home/widget/tcard.dart';
import 'package:mash/screens/profile_view/API/create_perosnal_chat.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

Widget airBnbCard(AirBnb airBnb) {
  return Stack(children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: FancyShimmerImage(
        height: Get.height,
        width: Get.width,
        imageUrl: airBnb.image!,
        shimmerBaseColor: AppColors.lightOrange,
        shimmerHighlightColor: AppColors.kOrange,
        shimmerBackColor: AppColors.lightOrange,
        boxFit: BoxFit.cover,
        errorWidget: Container(
            color: Colors.white, child: Image.asset("assets/mash_logo.png")),
      ),
    ),
    Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.black.withOpacity(0.8),
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.black.withOpacity(0.8)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
            decoration: BoxDecoration(
                color: AppColors.kOrange,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                gradient: LinearGradient(
                  colors: [AppColors.kOrange, Colors.black.withOpacity(0.2)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                )),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    FriendController friendController =
                        Get.put(FriendController());
                    getFriendList();
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      insetPadding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 16, left: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Friends",
                                  style: TextStyle(
                                      fontSize: 20, color: AppColors.kOrange),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: AppColors.kOrange,
                                    ))
                              ],
                            ),
                          ),
                          Obx(() => friendController.loading.value
                              ? SizedBox(
                                  height: Get.height / 2, child: loading())
                              : friendController.friendList.length == 0
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      child: Center(child: Text("No Friends")),
                                    )
                                  : ListView.separated(
                                      padding: EdgeInsets.all(16),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          AppColors.shadowColor,
                                                      offset: Offset(2, 2),
                                                      blurRadius: 6)
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              children: [
                                                userProfile(
                                                    friendController
                                                        .friendList[index]
                                                        .usersFriendsListFriendId
                                                        .toString(),
                                                    20),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  friendController
                                                      .friendList[index]
                                                      .fullName!,
                                                  style: TextStyle(
                                                      color: AppColors.kOrange,
                                                      fontSize: 16),
                                                )),
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  onPressed: () async {
                                                    if (friendController
                                                            .friendList[index]
                                                            .usersFriendsListChatId ==
                                                        null) {
                                                      await createPersonalChat(
                                                          friendController
                                                              .friendList[index]
                                                              .usersFriendsListFriendId!,
                                                          friendController
                                                              .friendList[index]
                                                              .fullName!,
                                                          false);
                                                    } else {
                                                      sendPersonalMessage(
                                                          airBnb.id.toString(),
                                                          friendController
                                                              .friendList[index]
                                                              .usersFriendsListChatId!,
                                                          "airbnb");
                                                    }
                                                  },
                                                  child: Text(
                                                    "Send",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  color: AppColors.kOrange,
                                                )
                                              ],
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 16,
                                          ),
                                      itemCount:
                                          friendController.friendList.length))
                        ],
                      ),
                    ));
                  },
                  icon: Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        airBnb.name!,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]),
                      ),
                      Text(
                        airBnb.act!,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]),
                      ),
                      Text(
                        airBnb.price!,
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]),
                      ),
                      Text(
                        "(${airBnb.time!})",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBar.builder(
                    initialRating: airBnb.rating!,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemSize: 25,
                    unratedColor: AppColors.lightOrange,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.kOrange,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  Spacer(),
                  Image.network(
                    "https://cdn.freebiesupply.com/logos/large/2x/airbnb-2-logo-png-transparent.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  InkWell(
                    onTap: () {
                      Get.dialog(Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        insetPadding: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // SizedBox(
                              //   height: 16,
                              // ),
                              // Image.network(
                              //   "https://cdn.freebiesupply.com/logos/large/2x/airbnb-2-logo-png-transparent.png",
                              //   height: 70,
                              // ),
                              // Text(data.eventId.toString()),
                              Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        airBnb.name!,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: AppColors.kOrange,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     launch(
                                    //         "tel:${airBnb.}");
                                    //   },
                                    //   icon: Icon(Icons.call),
                                    //   color: AppColors.kOrange,
                                    // ),
                                    IconButton(
                                      onPressed: () {
                                        launch(airBnb.link!);
                                      },
                                      icon: Icon(Icons.link),
                                      color: AppColors.kOrange,
                                    )
                                  ],
                                ),
                              ),
                              infoTiles(
                                  title: "Total People allowed",
                                  value: "${airBnb.people}",
                                  iconData: Icons.groups_outlined),
                              infoTiles(
                                  title: "# of right swipes today",
                                  value: "0",
                                  iconData: Icons.groups_outlined),
                              // infoTiles(
                              //     title: "Total Allowed Peoples",
                              //     value:
                              //         "${data.}",
                              //     iconData: Icons.badge_outlined),
                              infoTiles(
                                  title: "Distance",
                                  value:
                                      "${airBnb.distanceInMiles!.toStringAsFixed(2)} Miles",
                                  iconData: Icons.directions_outlined),
                            ],
                          ),
                        ),
                      ));
                    },
                    child: Icon(
                      Icons.error,
                      size: 40,
                      color: AppColors.kOrange,
                    ),
                  ),
                ],
              ))
        ],
      ),
    ),
    // likeNope(airBnb.id.toString())
  ]);
}
