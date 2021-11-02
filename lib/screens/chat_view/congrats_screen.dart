import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CongratsScreen extends StatelessWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: 16,right: 16,top:50.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [GestureDetector(
                onTap: (){
                  Get.back();
                },
                  child: Icon(Icons.clear,size: 30,))],
            ),
            Lottie.network("https://assets10.lottiefiles.com/packages/lf20_l4xxtfd3.json",repeat: false),
            Text("You earned 20 Mash points",style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
