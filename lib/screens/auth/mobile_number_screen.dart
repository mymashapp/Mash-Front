import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/configs/app_textfield.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/auth/otp_screen.dart';
import 'package:mash/screens/auth/widget/country_code_picker.dart';
import 'package:mash/widgets/app_bar_widget.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/error_snackbar.dart';

class MobileNumberScreen extends StatefulWidget {
  final bool link;

  const MobileNumberScreen({Key? key, required this.link}) : super(key: key);

  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: appAppBar(title: "Phone Number", isBack: false),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: appTextField(
                  textInputType: TextInputType.number,
                  hintText: "Enter your phone number",
                  controller: authController.mobileNumber.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                  },
                  icon: countryCodePicker(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "We will send a text for verification code.",
                textAlign: TextAlign.center,
              ),
              Spacer(),
              appButton(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseAuth.instance
                        .verifyPhoneNumber(
                          phoneNumber:
                              "+1${authController.mobileNumber.value.text}",
                          verificationCompleted:
                              (PhoneAuthCredential credential) {
                            print(credential);
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            print(e.toString());
                            print(e.code);
                            if (e.code == 'invalid-phone-number') {
                              errorSnackBar("Phone Number Invalid",
                                  "Please Check Your Phone Number.");
                            } else if (e.code == "too-many-requests") {
                              errorSnackBar("Too many requests",
                                  "We have blocked all requests from this device due to unusual activity. Try again later");
                            }
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            authController.mobileNumber.value.clear();
                            Get.to(
                                () => OtpScreen(verificationId, widget.link));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            print("CART ::: $verificationId");
                          },
                        )
                        .catchError((e) => print(e.toString()));
                  }
                },
                buttonName: "Continue",
                buttonBgColor: AppColors.kOrange,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
