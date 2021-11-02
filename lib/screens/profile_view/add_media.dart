import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/widgets/app_button.dart';

class AddMediaScreen extends StatelessWidget {
  const AddMediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: authController.userMedia.length,
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.kOrange),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 2),
                              blurRadius: 4)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.kOrange,
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
            child: appButton(
              onTap: () {
                //Get.to(()=>PreferencesScreen());
              },
              buttonName: "Submit",
              textColor: Colors.white,
              buttonBgColor: AppColors.kOrange,
            ),
          )
        ],
      ),
    );
  }
}
