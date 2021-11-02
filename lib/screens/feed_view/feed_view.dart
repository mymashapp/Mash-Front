import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/feed_view/tabs/discover.dart';
import 'package:mash/screens/feed_view/tabs/friends.dart';
import 'package:mash/screens/feed_view/tabs/leaderboard.dart';

import 'API/get_friends_list.dart';
import 'API/get_leaderboard.dart';

class FeedViewScreen extends StatefulWidget {
  const FeedViewScreen({Key? key}) : super(key: key);

  @override
  _FeedViewScreenState createState() => _FeedViewScreenState();
}

class _FeedViewScreenState extends State<FeedViewScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> tabs = ["Discover", "Friends", "LeaderBoard"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: 90,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(2, 2),
                blurRadius: 10)
          ]),
          padding: EdgeInsets.only(top: 50),
          child: TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 20),
              indicatorColor: AppColors.kOrange,
              physics: BouncingScrollPhysics(),
              controller: authController.feedTabController.value,
              onTap: (index) async {
                HapticFeedback.mediumImpact();
                if (index == 1) {
                  getFriendList();
                } else if (index == 2) {
                  getLeaderBoard();
                } else if (index == 3) {
                  // await getNearByFriends();
                }
              },
              tabs: List.generate(
                  tabs.length,
                  (index) => Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        tabs[index],
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 16,
                          color: AppColors.kOrange,
                        ),
                        textAlign: TextAlign.center,
                      )))),
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: authController.feedTabController.value,
            children: [Discover(), Friends(), LeaderBoard()],
          ),
        )
      ],
    );
  }
}
