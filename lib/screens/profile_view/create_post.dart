import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/configs/app_textfield.dart';
import 'package:mash/screens/profile_view/controller/profile_controller.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/error_snackbar.dart';

import 'API/upload_post.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  ProfileController profileController = Get.put(ProfileController());
  File? image;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.kOrange,
        title: Text("Create Post"),
      ),
      body: Obx(() => profileController.loading.value
          ? loading()
          : Form(
              key: formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.dialog(Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  Get.back();
                                  XFile? res = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (res != null) {
                                    image = File(res.path);
                                    setState(() {});
                                  } else {
                                    print("NOT");
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                        height: 60,
                                        child: Icon(
                                          Icons.camera,
                                          color: AppColors.kOrange,
                                          size: 60,
                                        )),
                                    Text(
                                      "Camera",
                                      style: GoogleFonts.sourceSansPro(
                                          color: AppColors.kOrange,
                                          fontSize: 16.sp),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () async {
                                  Get.back();

                                  XFile? res = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 10);
                                  if (res != null) {
                                    image = File(res.path);
                                    setState(() {});
                                  } else {
                                    print("NOT");
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                        height: 60,
                                        child: Icon(
                                          Icons.collections_outlined,
                                          color: AppColors.kOrange,
                                          size: 60,
                                        )),
                                    Text(
                                      "Gallery",
                                      style: GoogleFonts.sourceSansPro(
                                          color: AppColors.kOrange,
                                          fontSize: 16.sp),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowColor,
                              offset: Offset(4, 4),
                              blurRadius: 10,
                            )
                          ]),
                      child: image == null
                          ? Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 50,
                              color: AppColors.kOrange,
                            )
                          : Image.file(image!),
                    ),
                  ),

                  Obx(() => Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 0,
                              groupValue: profileController.private.value,
                              onChanged: (value) {
                                profileController.private.value = 0;
                              },
                              fillColor:
                                  MaterialStateProperty.all(AppColors.kOrange),
                            ),
                            Text(
                              "Everyone",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Radio(
                                value: 1,
                                groupValue: profileController.private.value,
                                onChanged: (value) {
                                  profileController.private.value = 1;
                                },
                                fillColor: MaterialStateProperty.all(
                                    AppColors.kOrange)),
                            Text(
                              "Friends",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                  Obx(()=> profileController.private.value == 1
                      ? SizedBox()
                      : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: appTextField(
                      controller: profileController.description.value,
                      hintText: "Description",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                      },
                    ),
                  ),),
                  SizedBox(height: 16,),
                  Expanded(
                      child: Text(
                          "We encourage you to upload photos of your meetups.")),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: appButton(
                        buttonName: "Upload",
                        buttonBgColor: AppColors.kOrange,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (image != null) {
                              if (profileController.private.value == 1) {
                                updatePrivatePostPic(image!);
                              } else {
                                updatePostPic(image!);
                              }
                            } else {
                              errorSnackBar("Photo is required",
                                  "Please Select photo to upload");
                            }
                          }
                        }),
                  )
                ],
              ),
            )),
    );
  }
}
