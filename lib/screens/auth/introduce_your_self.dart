import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/configs/app_textfield.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/auth/widget/profile_uploading_dialog.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/spacers.dart';

List<String> genders = ["Male", "Female", "Other"];
List<String> pronouns = [
  "He/Him/His",
  "She/Her/Hers",
  "They/Them/Theirs",
  "Ze/Hir/Hirs",
  "I use all gender pronouns.",
  "I do not use a pronoun.",
];

class IntroduceYourSelf extends StatefulWidget {
  @override
  _IntroduceYourSelfState createState() => _IntroduceYourSelfState();
}

class _IntroduceYourSelfState extends State<IntroduceYourSelf> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Introduce yourself",
          style: GoogleFonts.sourceSansPro(
              fontSize: 18.sp, color: AppColors.kOrange),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  y32,
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      authController.profileUrl.value.length > 0
                          ? Obx(() => Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.shadowColor,
                                          blurRadius: 60,
                                          offset: Offset(4, 24))
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            authController.profileUrl.value),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.kOrange, width: 4)),
                              ))
                          : Image.asset("assets/person_icon.png"),
                      InkWell(
                        onTap: () {
                          profileUploadingDialog();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.kOrange, width: 3)),
                          child: Icon(
                            Icons.add,
                            color: AppColors.kOrange,
                          ),
                        ),
                      )
                    ],
                  ),
                  y32,
                  Obx(() => appTextField(
                      hintText: "Your full name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                      },
                      controller: authController.fullName.value)),
                  y16,
                  appTextField(
                      controller: authController.emailController.value,
                      hintText: "Enter your email",
                      readOnly: authController.readOnlyEmail.value),
                  y16,
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: authController.dob.value,
                          firstDate: DateTime(1970),
                          lastDate:
                              DateTime.now().subtract(Duration(days: 6570)));
                      if (pickedDate != null) {
                        authController.dob.value = pickedDate;
                      }
                    },
                    child: Obx(() => Container(
                          alignment: Alignment.centerLeft,
                          height: 55,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: AppColors.kOrange,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "DOB",
                                style: GoogleFonts.sourceSansPro(fontSize: 16),
                              ),
                              Text(
                                DateFormat("dd MMM yyyy")
                                    .format(authController.dob.value),
                                style: GoogleFonts.sourceSansPro(fontSize: 16),
                              )
                            ],
                          ),
                        )),
                  ),
                  y16,
                  Obx(
                    () => Container(
                      height: 55,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.kOrange,
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: authController.gender.value,
                        onChanged: (value) {
                          authController.gender.value = value!;
                        },
                        underline: SizedBox(),
                        items: List.generate(
                          genders.length,
                          (index) => DropdownMenuItem(
                            child: Text(
                              genders[index],
                              style: GoogleFonts.sourceSansPro(),
                            ),
                            value: genders[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  y16,
                  Obx(() => Container(
                        height: 55,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.kOrange,
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: authController.pronoun.value,
                          onChanged: (value) {
                            authController.pronoun.value = value!;
                          },
                          underline: SizedBox(),
                          items: List.generate(
                            pronouns.length,
                            (index) => DropdownMenuItem(
                              child: Text(
                                pronouns[index],
                                style: GoogleFonts.sourceSansPro(),
                              ),
                              value: pronouns[index],
                            ),
                          ),
                        ),
                      )),
                  Spacer(),
                  appButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await FirebaseAuth.instance.currentUser!
                            .linkWithCredential(EmailAuthProvider.credential(
                                email:
                                    authController.emailController.value.text,
                                password: "123456"))
                            .catchError((e) {
                          print("ERROR ::: $e");
                        });
                        authController.firebaseToken.value = await FirebaseAuth
                            .instance.currentUser!
                            .getIdToken();
                        authController.signUpMethod();
                        // Get.to(() => LocationEnable());
                      }
                    },
                    buttonBgColor: AppColors.kOrange,
                    buttonName: "NEXT",
                    textColor: Colors.white,
                  ),
                  y32
                ],
              ),
            ),
          ),
          Obx(() => authController.loading.value ? blurLoader() : SizedBox())
        ],
      ),
    );
  }
}
