import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/home/API/get_user_from_chat_id.dart';
import 'package:mash/screens/home/controller/home_controller.dart';

// swipedService(int eventId, bool right) async {
//   var response = await ApiBaseHelper.put(
//       WebApi.swipedService, {"event_id": eventId, "swiped": right}, true);
//   print("RESPONSE ::: $response");
// }

swipeEvent(bool right) async {
  HomeController homeController = Get.put(HomeController());
  var response = await http.put(
      Uri.parse(WebApi.baseUrl + WebApi.swipedService),
      headers: WebApi.header,
      body: jsonEncode(
          {"event_id": homeController.eventId.value, "swiped": right}));
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    if (decodedData["extra"] != {}) {
      if (decodedData["extra"]["total_joinde_people"] > 1) {
        getUsersFromChatId(decodedData["extra"]["chat_id"]);
      }
    }
  } else if (response.statusCode == 400) {
  } else {}
}
