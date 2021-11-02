import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/configs/app_textfield.dart';
import 'package:mash/screens/auth/introduce_your_self.dart';
import 'package:mash/screens/profile_view/API/upload_user_detail.dart';
import 'package:mash/screens/profile_view/controller/profile_controller.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/error_snackbar.dart';
import 'package:mash/widgets/spacers.dart';

import '../../main.dart';

class BackGroundScreen extends StatefulWidget {
  const BackGroundScreen({Key? key}) : super(key: key);

  @override
  _BackGroundScreenState createState() => _BackGroundScreenState();
}

class _BackGroundScreenState extends State<BackGroundScreen> {
  ProfileController profileController = Get.put(ProfileController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            Obx(() => SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        appTextField(
                            hintText: "Name",
                            controller: authController.fullName.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              }
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now()
                                    .subtract(Duration(days: 6570)),
                                firstDate: DateTime(1970),
                                lastDate: DateTime.now()
                                    .subtract(Duration(days: 6570)));
                            if (pickedDate != null) {
                              authController.dob.value = pickedDate;
                            }
                          },
                          child: Obx(() => Container(
                                alignment: Alignment.centerLeft,
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.r),
                                  border: Border.all(color: AppColors.kOrange),
                                ),
                                child: Text(
                                  DateFormat("dd MMM yyyy")
                                      .format(authController.dob.value),
                                  style:
                                      GoogleFonts.sourceSansPro(fontSize: 16),
                                ),
                              )),
                        ),
                        y10,
                        Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(color: AppColors.kOrange),
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
                        y10,
                        appTextField(
                          hintText: "Location",
                          textInputAction: TextInputAction.search,
                          controller: authController.location.value,
                          onChanged: (val) async {},
                          onSubmitted: (val) async {
                            if (val.trim().length != 0) {
                              var googlePlace = GooglePlace(
                                  "AIzaSyArgtGCvxqhaW-EdFHnSeI4vTANeGvRFTg");
                              authController.pred.clear();
                              var result =
                                  await googlePlace.autocomplete.get(val);
                              authController.pred.value = result!.predictions!;
                            } else {
                              authController.pred.clear();
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                          },
                        ),
                        y10,
                        // Obx(() => Container(
                        //       padding: EdgeInsets.symmetric(horizontal: 10.w),
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(6.r),
                        //         border: Border.all(color: AppColors.kOrange),
                        //       ),
                        //       child: DropdownButton<String>(
                        //         isExpanded: true,
                        //         value: authController.pronoun.value,
                        //         onChanged: (value) {
                        //           authController.pronoun.value = value!;
                        //         },
                        //         underline: SizedBox(),
                        //         items: List.generate(
                        //           pronouns.length,
                        //           (index) => DropdownMenuItem(
                        //             child: Text(
                        //               pronouns[index],
                        //               style: GoogleFonts.sourceSansPro(),
                        //             ),
                        //             value: pronouns[index],
                        //           ),
                        //         ),
                        //       ),
                        //     )),
                        // y10,
                        appTextField(
                            hintText: "Height",
                            controller: authController.height.value,
                            suffixText: 'Feet',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              } else if (!value.isNum) {
                                return "Enter valid height";
                              }
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        // appTextField(hintText: "Relationship status"),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        appTextField(
                            hintText: "School",
                            controller: authController.school.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              }
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        appTextField(
                            hintText: "Top 3 Interests",
                            onSubmitted: (value) {
                              if (authController.interestList.length != 3) {
                                authController.interestList.add(value);
                              } else {
                                errorSnackBar("Only 3 Interests are Allowed.",
                                    "Please remove other interest to add new.");
                              }
                              authController.interest.value.clear();
                            },
                            controller: authController.interest.value),
                        authController.interestList.length == 0
                            ? Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text("No Interest Added"),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Wrap(
                                  runAlignment: WrapAlignment.start,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(
                                      authController.interestList.length,
                                      (index) => Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: AppColors.kOrange,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  authController
                                                      .interestList[index],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    authController.interestList
                                                        .remove(authController
                                                                .interestList[
                                                            index]);
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                ),
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: authController.covidVaccinated.value,
                              onChanged: (value) {
                                authController.covidVaccinated.value = value!;
                              },
                              fillColor:
                                  MaterialStateProperty.all(AppColors.kOrange),
                            ),
                            Text(
                              "Covid Vaccinated",
                              style: TextStyle(
                                  color: AppColors.kOrange, fontSize: 16),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Text(
                            "Covid Vaccinated sticker is self-reported and not independently verified by Mash App. We can't guarantee that a member is vaccinated or can't transmit the COVID-19 virus.",
                            style: TextStyle(
                                color: AppColors.kOrange, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: appButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (authController.interestList.length >= 3) {
                          updateUserDetail();
                          updateUserBasicData();
                        } else {
                          errorSnackBar("Minimum 3 interest is required",
                              "Please add at least 3 interest to your profile");
                        }
                      }
                    },
                    buttonBgColor: AppColors.kOrange,
                    textColor: Colors.white,
                    buttonName: "Submit"),
              ),
            ),
            Obx(
              () => authController.pred.length == 0
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(top: 260, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 24)
                          ]),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () async {
                                  authController.location.value.text =
                                      authController.pred[index]
                                          .structuredFormatting!.mainText!;
                                  authController.pred.clear();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: AppColors.kOrange,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.shadowColor,
                                              offset: Offset(3, 3),
                                              blurRadius: 10)
                                        ],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      authController.pred[index].description!,
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white),
                                    )),
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: authController.pred.length),
                    ),
            ),
            Obx(() =>
                profileController.loading.value ? bluLoader() : SizedBox())
          ],
        ),
      ),
    );
  }
}
