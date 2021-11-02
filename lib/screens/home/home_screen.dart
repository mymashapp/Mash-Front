import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/chat_view/chat_user_screen.dart';
import 'package:mash/screens/feed_view/API/get_friend_request_list.dart';
import 'package:mash/screens/feed_view/feed_view.dart';
import 'package:mash/screens/feed_view/tabs/app_map.dart';
import 'package:mash/screens/home/controller/home_controller.dart';
import 'package:mash/screens/home/widget/home_tab.dart';
import 'package:mash/screens/profile_view/profile_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  List<String> iconList = [
    "assets/icons/home.png",
    "assets/icons/chat.png",
    "assets/icons/feed.png",
    "assets/icons/map.png",
    "assets/icons/profile-user.png",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data);
      if (message.data["type"] == "Friend Request") {
        authController.feedTabController.value.animateTo(1);
        authController.friendController.value.animateTo(1);
        getFriendRequestList();
        homeController.bottomIndex.value = 2;
        homeController.pageController.value.jumpToPage(2);
      } else if (message.data["type"] == "Friend Photos") {
        authController.feedTabController.value.animateTo(0);
        authController.discoverController.value.animateTo(1);
        homeController.bottomIndex.value = 2;
        homeController.pageController.value.jumpToPage(2);
      } else if (message.data["type"] == "New Mash") {
        homeController.bottomIndex.value = 1;
        homeController.pageController.value.jumpToPage(1);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar.builder(
          itemCount: 5,
          height: 50.h,
          tabBuilder: (index, isActive) {
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Image.asset(
                iconList[index],
                color: isActive ? AppColors.kOrange : Colors.black,
              ),
            );
          },
          splashColor: AppColors.kOrange,
          splashRadius: 20.h,
          elevation: 0,
          rightCornerRadius: 32,
          leftCornerRadius: 32,
          activeIndex: homeController.bottomIndex.value,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          onTap: (index) {
            HapticFeedback.mediumImpact();
            homeController.bottomIndex.value = index;
            homeController.pageController.value.jumpToPage(index);
          })),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: homeController.pageController.value,
        children: [
          HomeTab(),
          ChatUserScreen(),
          FeedViewScreen(),
          AppMap(),
          ProfileScreen()
        ],
      ),
    );
  }
}
