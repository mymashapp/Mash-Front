import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/auth/introduce_your_self.dart';
import 'package:mash/widgets/app_bar_widget.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final bool link;

  OtpScreen(this.verificationId, this.link);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(
        isBack: false,
        title: "Verify OTP",
      ),
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
            child: Column(
              children: [
                Text(
                    "Verification Code sent to +1${authController.mobileNumber.value.text}"),
                SizedBox(
                  height: 20,
                ),
                PinPut(
                  animationCurve: Curves.easeIn,
                  inputDecoration: InputDecoration(
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                  fieldsAlignment: MainAxisAlignment.spaceAround,
                  eachFieldWidth: 45.0,
                  eachFieldHeight: 45.0,
                  validator: (value) {
                    if (value!.length == 0) {
                      return "required otp number";
                    }
                  },
                  withCursor: false,
                  fieldsCount: 6,
                  focusNode: _pinPutFocusNode,
                  controller: authController.pinPutController.value,
                  onSubmit: (String pin) {
                    authController.otpCode.value = pin;
                  },
                  submittedFieldDecoration: BoxDecoration(
                    color: AppColors.kOrange,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  selectedFieldDecoration: BoxDecoration(
                    color: AppColors.kOrange,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  followingFieldDecoration: BoxDecoration(
                    color: AppColors.kOrange,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  textStyle:
                      const TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                // GestureDetector(
                //     onTap: () {},
                //     child: Text(
                //       "Resend",
                //       style: TextStyle(
                //           color: Colors.grey, fontWeight: FontWeight.bold),
                //     )),
                Spacer(),
                appButton(
                    onTap: () async {
                      if (widget.link) {
                        await FirebaseAuth.instance.currentUser!
                            .linkWithCredential(PhoneAuthProvider.credential(
                                verificationId: widget.verificationId,
                                smsCode:
                                    authController.pinPutController.value.text))
                            .then((value) {
                          Get.to(() => IntroduceYourSelf());
                          authController.pinPutController.value.clear();
                        }).catchError((e) {
                          Get.snackbar(
                              "${e.toString().replaceAll(e.toString().split(" ")[0], "").trim()}",
                              e.toString().split(" ")[0],
                              colorText: Colors.white,
                              backgroundColor: Colors.redAccent,
                              borderRadius: 0,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: EdgeInsets.zero);
                        });
                      } else {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: widget.verificationId,
                                smsCode:
                                    authController.pinPutController.value.text))
                            .then((value) async {
                          authController.pinPutController.value.clear();
                          authController.loginMethod(
                              await value.user!.getIdToken(), false);
                        }).catchError((e) {
                          print(e.toString());
                          Get.snackbar(
                              "Invalid OTP", "Please provide right OTP",
                              colorText: Colors.white,
                              backgroundColor: Colors.redAccent,
                              borderRadius: 0,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: EdgeInsets.zero);
                        });
                      }
                      // Get.to(() => EmailScreen());
                    },
                    textColor: Colors.white,
                    buttonBgColor: AppColors.kOrange,
                    buttonName: "Continue")
              ],
            ),
          ),
          blurLoader(),
        ],
      ),
    );
  }
}
