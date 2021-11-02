import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/profile_view/mash_point_faq.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Map<String, dynamic>> items = [
    {
      "title": "Vision And Mission",
      "icon": Icons.favorite,
      "onTap": () {
        Get.dialog((Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Vision And Mission",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kOrange),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "To become the go-to platform to meet your next best friend",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )));
      }
    },
    {
      "title": "Privacy Policy",
      "icon": Icons.remove_red_eye_outlined,
      "onTap": () {
        launch("https://mymashapp.com/Privacy_Policy.html");
      }
    },
    {
      "title": "Terms and Conditions",
      "icon": Icons.sticky_note_2_outlined,
      "onTap": () {
        launch("https://mymashapp.com/Terms.html");
      }
    },
    {
      "title": "About Mash",
      "icon": Icons.info,
      "onTap": () {
        Get.dialog((Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "About Mash",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kOrange),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Mash is a swipe-based mobile application that facilitates in-person meetups.",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )));
      }
    },
    {
      "title": "Mash Points FAQ",
      "icon": Icons.emoji_events_outlined,
      "onTap": () {
        Get.to(() => MashPointFAQ());
      }
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) => InkWell(
              onTap: items[index]["onTap"],
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.shadowColor,
                          offset: Offset(3, 3),
                          blurRadius: 6)
                    ]),
                child: Row(
                  children: [
                    Icon(
                      items[index]["icon"],
                      color: AppColors.kOrange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      items[index]["title"],
                      style: TextStyle(color: AppColors.kOrange, fontSize: 16),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.kOrange,
                    )
                  ],
                ),
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(
              height: 15,
            ),
        itemCount: items.length);
  }
}
