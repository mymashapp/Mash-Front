import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/profile_view/API/upload_profile.dart';

profileUploadingDialog() {
  Get.dialog(Dialog(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              XFile? res =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (res != null) {
                Get.back();
                authController.profileUploading.value = true;
                await uploadProfile(res.path).then((value) async {
                  await Future.delayed(Duration(seconds: 2));
                  await authController.refreshProfile();
                  authController.profileUploading.value = false;
                });
              }
            },
            child: SizedBox(
                height: 60,
                child: Icon(
                  Icons.camera,
                  color: AppColors.kOrange,
                  size: 60,
                )),
          ),
          SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () async {
              XFile? res =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (res != null) {
                Get.back();
                authController.profileUploading.value = true;
                await uploadProfile(res.path).then((value) async {
                  await Future.delayed(Duration(seconds: 2));
                  await authController.refreshProfile();
                  authController.profileUploading.value = false;
                });
              }
            },
            child: SizedBox(
              height: 60,
              child: Icon(
                Icons.add_photo_alternate_outlined,
                color: AppColors.kOrange,
                size: 60,
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}
