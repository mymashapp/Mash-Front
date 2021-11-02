import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/home/API/get_user_location.dart';
import 'package:mash/screens/home/controller/home_controller.dart';
import 'package:mash/screens/home/model/all_event_model.dart';

fetchAllEventssss() async {
  HomeController homeController = Get.put(HomeController());
  authController.apiMessage.value = "Searching";
  homeController.loading.value = true;
  if (!testing) await getUserLocation();
  String url = testing
      ? "${WebApi.baseUrl + "event?user_lat=${42.34784169448538}&user_log=${-71.07124328613281}&stream=1&limit=20&random=true"}"
      : "${WebApi.baseUrl + "event?user_lat=${authController.lat.value}&user_log=${authController.lon.value}&stream=1&limit=20&random=true"}";
  var response = await http.get(Uri.parse(url),
      headers: {"Authorization": "Bearer ${authController.accessToken.value}"});

  homeController.loading.value = false;
  if (response.statusCode == 200) {
    homeController.allEventModel.clear();
    print("START");
    homeController.allEventModel.value =
        allEventModelFromJson(response.body).data!;
    print("END");
  } else if (response.statusCode == 400) {
    authController.apiMessage.value = "Error Something went wrong";
  } else if (response.statusCode == 601) {
    authController.apiMessage.value = "Daily quota limit exceeded";
  } else if (response.statusCode == 602) {
    authController.apiMessage.value = "We are coming soon at this location";
  } else if (response.statusCode == 603) {
    authController.apiMessage.value =
        "Please wait for 0 seconds we are updating events for your location.";
  } else {
    print(response.statusCode);
    print(response.body);
  }
}
