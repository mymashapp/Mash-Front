import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/screens/auth/API/refresh_token.dart';
import 'package:mash/screens/auth/introduce_your_self.dart';
import 'package:mash/screens/auth/location_screen.dart';
import 'package:mash/screens/auth/mobile_number_screen.dart';
import 'package:mash/screens/auth/models/user_post_data_model.dart';
import 'package:mash/screens/home/home_screen.dart';
import 'package:mash/screens/profile_view/models/profile_model.dart';
import 'package:mash/widgets/error_snackbar.dart';

class AuthController extends GetxController with SingleGetTickerProviderMixin {
  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> height = TextEditingController().obs;
  Rx<TextEditingController> school = TextEditingController().obs;
  Rx<TextEditingController> interest = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  TextEditingController otpNumber = TextEditingController();
  Rx<TextEditingController> pinPutController = TextEditingController().obs;
  RxString otpCode = ''.obs;
  RxString countryCode = ''.obs;
  Rx<DateTime> dob = DateTime.now().subtract(Duration(days: 6570)).obs;
  RxString gender = "Male".obs;
  RxString genderPre = "Man".obs;
  RxString pronoun = "He/Him/His".obs;
  RxString firebaseToken = "".obs;
  RxBool loading = false.obs;
  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;
  RxBool readOnlyEmail = false.obs;
  RxBool logged = false.obs;
  RxString accessToken = "".obs;
  RxString refreshToken = "".obs;
  Rx<APIUser> user = APIUser().obs;
  RxString profileUrl = "".obs;
  RxString apiMessage = "".obs;
  RxBool profileUploading = false.obs;
  RxBool covidVaccinated = false.obs;
  RxList<String> interestList = <String>[].obs;
  RxList<String> userMedia = <String>[].obs;
  RxDouble distance = 1.0.obs;
  RxDouble minAge = 21.0.obs;
  RxDouble maxAge = 45.0.obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  RxList<AutocompletePrediction> pred = <AutocompletePrediction>[].obs;
  RxBool showLocation = false.obs;
  RxInt swipeStatus = 2.obs;
  RxString swipeId = "0".obs;

  late Rx<TabController> feedTabController =
      TabController(length: 3, vsync: this).obs;
  late Rx<TabController> friendController =
      TabController(length: 2, vsync: this).obs;
  late Rx<TabController> discoverController =
      TabController(length: 2, vsync: this).obs;

  refreshProfile() async {
    authController.profileUrl.value =
        await getProfile(authController.user.value.userId);
    print("PROFILE URL ::: ${authController.profileUrl.value}");
  }

  checkAuth() async {
    final box = GetStorage();
    if (FirebaseAuth.instance.currentUser != null &&
        box.read("accessToken") != null) {
      logged.value = true;
      accessToken.value = box.read("accessToken");
      refreshToken.value = box.read("refreshToken");
    } else {
      FirebaseAuth.instance.signOut();
      logged.value = false;
    }
  }

  loginMethod(String fT, bool link) async {
    final box = GetStorage();
    firebaseToken.value = fT;
    print(fT);
    authController.loading.value = true;
    var response =
        await http.post(Uri.parse(WebApi.baseUrl + WebApi.loginUrl), body: {
      "firebase_token": fT,
    });
    authController.loading.value = false;
    print("Status Code ::: ${response.statusCode}");
    print("Response ::: ${response.body}");
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (data["success"] == -1) {
        if (link) {
          Get.to(() => MobileNumberScreen(
                link: link,
              ));
        } else {
          Get.to(() => IntroduceYourSelf());
        }
      } else {
        final box = GetStorage();
        box.write("accessToken", data["accessToken"]);
        box.write("refreshToken", data["refressToken"]);
        FirebaseAuth.instance
            .signInWithCustomToken(data["firebaseCustomToken"]);
        authController.checkAuth();
        refreshTokenService();
        Get.to(() => HomeScreen());
      }
    } else {
      errorSnackBar("Something went wrong", "Please try again later");
    }
  }

  signUpMethod() async {
    final box = GetStorage();
    UserPostDataModel userPostDataModel = UserPostDataModel(
        userData: UserData(
            fullName: fullName.value.text,
            dobTimestamp: dob.value.millisecondsSinceEpoch ~/ 1000,
            email: emailController.value.text,
            phone: int.parse("1${mobileNumber.value.text}"),
            gender: gender.value[0]),
        firebaseToken: firebaseToken.value);
    authController.loading.value = true;
    var response = await http.post(Uri.parse(WebApi.baseUrl + WebApi.signUpUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userPostDataModel.toJson()));
    authController.loading.value = false;
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      box.write("accessToken", data["accessToken"]);
      box.write("refreshToken", data["refressToken"]);
      FirebaseAuth.instance.signInWithCustomToken(data["firebaseCustomToken"]);
      authController.checkAuth();
      refreshTokenService();
      Get.to(() => LocationEnable());
    } else {
      errorSnackBar("Something went wrong", "Please try again!");
    }
  }

  @override
  void onInit() {
    checkAuth();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    if (logged.value) {
      refreshTokenService();
    }
    // TODO: implement onReady
    super.onReady();
  }
}
