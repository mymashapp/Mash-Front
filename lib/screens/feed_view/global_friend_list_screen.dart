import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/feed_view/video_screen.dart';
import 'package:mash/widgets/app_bar_widget.dart';

class GlobalFriendsList extends StatefulWidget {
  @override
  _GlobalFriendsListState createState() => _GlobalFriendsListState();
}

class _GlobalFriendsListState extends State<GlobalFriendsList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(
          title: "Leaderboard", icon: Icons.filter_alt_outlined, isBack: false),
      body: Column(
        children: [
          TabBar(
              indicatorColor: AppColors.kOrange,
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              tabs: [
                Container(
                    alignment: Alignment.center,
                    height: 45,
                    child: Text(
                      "Global",
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 18, color: AppColors.kOrange),
                    )),
                Container(
                    alignment: Alignment.center,
                    height: 45,
                    child: Text(
                      "Friend",
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 18, color: AppColors.kOrange),
                    )),
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: 6,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => VideoScreen());
                      },
                      child: Container(
                        width: 100,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://assets.entrepreneur.com/content/3x2/2000/20180801175416-ent18-sept-survey.jpeg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.kOrange.withOpacity(0.2)),
                      ),
                    );
                  }),
              Center(child: Text("Friend"))
            ]),
          )
        ],
      ),
    );
  }
}
