import 'package:get/get.dart';
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/auth/API/refresh_token.dart';
import 'package:mash/screens/profile_view/controller/profile_controller.dart';
import 'package:mash/widgets/error_snackbar.dart';

ProfileController profileController = Get.put(ProfileController());

updateUserDetail() async {
  profileController.loading.value = true;
  var response = await ApiBaseHelper.post(
      WebApi.updateUserDetail,
      {
        "full_name": authController.fullName.value.text,
        "dob_timestamp":
            authController.dob.value.millisecondsSinceEpoch ~/ 1000,
        "gender": authController.user.value.gender,
        "pronoun": "Mr.",
        "height": double.parse(authController.height.value.text),
        "school": authController.school.value.text
      },
      true);
  profileController.loading.value = false;

  print("USER DETAIL :: ${{
    "full_name": authController.fullName.value.text,
    "dob_timestamp": authController.dob.value.millisecondsSinceEpoch * 1000,
    "gender": authController.user.value.gender,
    "pronoun": "Mr.",
    "height": double.parse(authController.height.value.text),
    "school": authController.school.value.text
  }}");
  print("USER DETAIL ::: ${response.statusCode}");
  print("USER DETAIL ::: ${response.body}");
}

updateUserBasicData() async {
  profileController.loading.value = true;
  var response = await ApiBaseHelper.post(
      WebApi.updateUserBasicData,
      {
        "vaccination_status": authController.covidVaccinated.value ? 1 : 0,
        "user_basic_extra": {
          "interests": authController.interestList.value,
          "location": authController.location.value.text
        }
      },
      true);
  profileController.loading.value = false;
  print("BASIC :: ${{
    "vaccination_status": authController.covidVaccinated.value ? 1 : 0,
    "user_basic_extra": {
      "interests": authController.interestList.value,
      "location": authController.location.value.text
    }
  }}");
  print("BASIC :: ${response.statusCode}");
  print("BASIC :: ${response.body}");
  refreshTokenService();
  appSnackBar(
      "Profile updated successfully", "Your profile is successfully updated");
}

updateUserPreferenceData() async {
  profileController.loading.value = true;
  var response = await ApiBaseHelper.post(
      WebApi.updateUserPreferenceData,
      {
        "distance": authController.distance.value.toInt(),
        "min_age": authController.minAge.value.toInt(),
        "max_age": authController.maxAge.value.toInt(),
        "geneder_pre": authController.gender.value == "Man"
            ? "M"
            : authController.gender.value == "Woman"
                ? "F"
                : "A"
      },
      true);
  print({
    "distance": authController.distance.value.toInt(),
    "min_age": authController.minAge.value.toInt(),
    "max_age": authController.maxAge.value.toInt(),
    "geneder_pre": authController.gender.value == "Man"
        ? "M"
        : authController.gender.value == "Woman"
            ? "F"
            : "A"
  });
  profileController.loading.value = false;
  print("PREF :: ${response.statusCode}");
  print(response.body);

  refreshTokenService();
  appSnackBar("Preferences updated successfully",
      "Your preferences is successfully updated");
}
