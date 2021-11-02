import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/feed_view/API/get_leaderboard.dart';
import 'package:mash/screens/feed_view/controller/leaderboard_controller.dart';
import 'package:mash/screens/profile_view/other_user_profile.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/user_profile.dart';

import '../../../main.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard>
    with TickerProviderStateMixin {
  late TabController tabController;
  LeaderBoardController leaderBoardController =
      Get.put(LeaderBoardController());
  List<String> tabs = ["This month", "All Time"];
  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 90.h,
                width: 90.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.shadowColor,
                          offset: Offset(2, 2),
                          blurRadius: 6)
                    ],
                    border: Border.all(color: AppColors.kOrange, width: 3)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Obx(() => authController.profileUploading.value
                      ? loading()
                      : FancyShimmerImage(
                          imageUrl: authController.profileUrl.value.length > 1
                              ? authController.profileUrl.value
                              : "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                          shimmerBaseColor: Colors.white,
                          shimmerHighlightColor: AppColors.lightOrange,
                          shimmerBackColor: AppColors.lightOrange,
                          boxFit: BoxFit.cover,
                        )),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: SizedBox(
                height: 90.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${authController.user.value.fullName}",
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() => Text(
                                leaderBoardController.selectedTab.value == 0
                                    ? authController
                                        .user.value.userBasicMonthlyPoints
                                        .toString()
                                    : authController
                                        .user.value.userBasicTotalPoints
                                        .toString(),
                                style: GoogleFonts.sourceSansPro(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kOrange),
                              )),
                          Text(
                            "Points earned",
                            style: GoogleFonts.sourceSansPro(fontSize: 16.sp),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
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
              controller: tabController,
              onTap: (index) {
                leaderBoardController.selectedTab.value = index;
                getLeaderBoard();
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
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            Obx(() => leaderBoardController.loading.value
                ? loading()
                : leaderBoardController.leaderBoardUser.length == 0
                    ? Center(
                        child: Text("No User Found"),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                HapticFeedback.mediumImpact();

                                Get.to(() => OtherUserProfile(
                                    alreadyFriend: false,
                                    userName: leaderBoardController
                                        .leaderBoardUser[index].fullName!,
                                    userId: leaderBoardController
                                        .leaderBoardUser[index].userId!));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.shadowColor,
                                          blurRadius: 10,
                                          offset: Offset(4, 4))
                                    ],
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Text(
                                      "${index + 1}.",
                                      style: GoogleFonts.sourceSansPro(
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    userProfile(
                                        leaderBoardController
                                            .leaderBoardUser[index].userId
                                            .toString(),
                                        15),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      leaderBoardController
                                          .leaderBoardUser[index].fullName!,
                                      style: GoogleFonts.sourceSansPro(
                                          fontSize: 16),
                                    ),
                                    Spacer(),
                                    Text(
                                      leaderBoardController
                                          .leaderBoardUser[index]
                                          .userBasicMonthlyPoints
                                          .toString(),
                                      style: GoogleFonts.sourceSansPro(
                                          fontSize: 16,
                                          color: AppColors.kOrange),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount:
                            leaderBoardController.leaderBoardUser.length)),
            Obx(() => leaderBoardController.loading.value
                ? loading()
                : leaderBoardController.leaderBoardUser.length == 0
                    ? Center(
                        child: Text("No User Found"),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                Get.to(() => OtherUserProfile(
                                    alreadyFriend: false,
                                    userName: leaderBoardController
                                        .leaderBoardUser[index].fullName!,
                                    userId: leaderBoardController
                                        .leaderBoardUser[index].userId!));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.shadowColor,
                                          blurRadius: 10,
                                          offset: Offset(4, 4))
                                    ],
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Text(
                                      "${index + 1}.",
                                      style: GoogleFonts.sourceSansPro(
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    userProfile(
                                        leaderBoardController
                                            .leaderBoardUser[index].userId
                                            .toString(),
                                        15),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      leaderBoardController
                                          .leaderBoardUser[index].fullName!,
                                      style: GoogleFonts.sourceSansPro(
                                          fontSize: 16),
                                    ),
                                    Spacer(),
                                    Text(
                                      leaderBoardController
                                          .leaderBoardUser[index]
                                          .userBasicTotalPoints
                                          .toString(),
                                      style: GoogleFonts.sourceSansPro(
                                          fontSize: 16,
                                          color: AppColors.kOrange),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount:
                            leaderBoardController.leaderBoardUser.length)),
          ],
        ))
      ],
    );
  }
}
