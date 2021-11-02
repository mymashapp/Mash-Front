import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/auth/widget/logo.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/fade_in_images.dart';
import 'package:url_launcher/url_launcher.dart';

import 'sign_in _screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void launchURL(url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FadeInImages(),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            width: Get.width,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              logo(),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: " Privacy policy",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                print("url");
                                launchURL(
                                    "https://mymashapp.com/Privacy_Policy.html");
                              },
                            style: GoogleFonts.sourceSansPro(
                              color: AppColors.kOrange,
                            ),
                          ),
                          TextSpan(
                              text: " and cookies policy",
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white))
                        ],
                        text:
                            "By tapping create account or sign in,you agree to our Term. Learn how we process your data in our",
                        style: GoogleFonts.sourceSansPro(color: Colors.white))),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: appButtonLogin(
                  onTap: () {
                    Get.to(() => SignIn());
                  },
                  isBorder: true,
                  buttonName: "SIGN IN",
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text("Terms of Service",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 14.sp,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 16.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}
