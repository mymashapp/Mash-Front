import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';
import 'package:mash/noti/set_fcm_token.dart';
import 'package:mash/screens/profile_view/models/profile_model.dart';

getProfileDetails() async {
  authController.loading.value = true;
  var response = await http.get(WebApi.getProfile,
      headers: {"Authorization": "Bearer ${authController.accessToken.value}"});
  authController.loading.value = false;
  print("USER ::: ${response.statusCode}");
  print("USER ::: ${response.body}");
  if (response.statusCode == 200) {
    APIUser apiUser = profileModelFromJson(response.body).user!;
    authController.user.value = apiUser;
    authController.covidVaccinated.value = apiUser.vaccinationStatus == 1;
    authController.dob.value = apiUser.dob!;
    if (apiUser.userBasicExtra != null) {
      authController.location.value.text = apiUser.userBasicExtra!.location!;
      authController.interestList.value = apiUser.userBasicExtra!.interests!;
    }
    authController.distance.value = apiUser.distance!.toDouble();
    if (apiUser.minAge != null && apiUser.maxAge != null) {
      authController.minAge.value = apiUser.minAge!.toDouble();
      authController.maxAge.value = apiUser.maxAge!.toDouble();
    }
    authController.showLocation.value = apiUser.showLocation == 1;

    authController.genderPre.value = apiUser.genederPre == "M"
        ? "Man"
        : apiUser.genederPre == "W"
            ? "Woman"
            : "Both";
    setFcmToken();

    authController.refreshProfile();
  } else {
    // errorSnackBar("Something went wrong", "Please try again");
  }
}
