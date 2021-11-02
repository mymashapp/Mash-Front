import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/auth/mobile_number_screen.dart';
import 'package:mash/screens/auth/widget/logo.dart';
import 'package:mash/widgets/fade_in_images.dart';
import 'package:mash/widgets/spacers.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile', 'user_birthday']);
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  final _firebaseAuth = FirebaseAuth.instance;
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // 1. perform the sign-in request
    final credential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ], nonce: nonce);

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      rawNonce: rawNonce,
    );
    final userCredential =
        await _firebaseAuth.signInWithCredential(oauthCredential);

    final firebaseUser = userCredential.user!;

    return firebaseUser;
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
          Padding(
            padding: EdgeInsets.only(top: 45.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //     onPressed: () {
                //       HapticFeedback.mediumImpact();
                //       Get.back();
                //     },
                //     icon: Icon(
                //       Icons.arrow_back_ios,
                //       color: Colors.white,
                //     )),
                logo(),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Terms & Conditions. ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  launch("https://mymashapp.com/Terms.html");
                                },
                              style: TextStyle(
                                color: AppColors.kOrange,
                              ),
                            ),
                            TextSpan(
                                text: "By tapping Sign In, you agree to our "),
                            TextSpan(
                              text: " Privacy Policy.",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  launch(
                                      "https://mymashapp.com/Privacy_Policy.html");
                                },
                              style: TextStyle(
                                color: AppColors.kOrange,
                              ),
                            ),
                          ],
                          text: "Learn how we process your data in our ",
                          style: TextStyle(color: Colors.white))),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    signInWithApple().then((value) async {
                      authController.emailController.value.text =
                          value.email ?? value.providerData.first.email!;
                      authController.readOnlyEmail.value =
                          authController.emailController.value.text.length > 0;
                      await authController.loginMethod(
                          await value.getIdToken(), true);
                    });
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: SvgPicture.asset(
                                "assets/icons/apple_logo.svg")),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Sign in with Apple",
                            style: TextStyle(color: Colors.black, fontSize: 19),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    signInWithFacebook().then((value) async {
                      authController.fullName.value.text =
                          value.user!.displayName!;
                      authController.profileUrl.value = value.user!.photoURL!;
                      authController.emailController.value.text =
                          value.additionalUserInfo!.profile!['email'];
                      List<String> date = value
                          .additionalUserInfo!.profile!["birthday"]
                          .toString()
                          .split("/");
                      authController.dob.value = DateTime(int.parse(date[2]),
                          int.parse(date[0]), int.parse(date[1]));

                      authController.readOnlyEmail.value =
                          authController.emailController.value.text.length > 0;
                      print(authController.profileUrl.value);
                      // authController.mobileNumber.text =
                      //     value.user!.phoneNumber!;
                      // authController.emailController.text =
                      //     value.user!.email!;
                      await authController.loginMethod(
                          await value.user!.getIdToken(), true);
                      // Get.to(() => IntroduceYourSelf());
                    });
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.kBlue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 9),
                            child:
                                SvgPicture.asset("assets/icons/facebook.svg"),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign in with Facebook",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => MobileNumberScreen(
                          link: false,
                        ));
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.kOrange,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Icon(
                          Icons.phone_iphone,
                          color: Colors.white,
                        )),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Sign in with Phone",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Center(
                //   child: Text(
                //     "Trouble Signing in ?",
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                y32
              ],
            ),
          ),
          Obx(() => authController.loading.value
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    alignment: Alignment.center,
                    color: AppColors.kOrange.withOpacity(0.5),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : SizedBox())
        ],
      ),
    );
  }
}
