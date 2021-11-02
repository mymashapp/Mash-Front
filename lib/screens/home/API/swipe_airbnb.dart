import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';

swipeAirbnb(String id, int status) async {
  var response = await ApiBaseHelper.put(WebApi.airBnbSwipe,
      {"type": "ab_expi", "status": status, "id": id}, true);
  print("AIRBNB SWIPE :: ${response.statusCode}");
  print("AIRBNB SWIPE :: ${response.body}");
}

swipeGroupon(String id, int status) async {
  var response = await ApiBaseHelper.put(WebApi.airBnbSwipe,
      {"type": "group_on", "status": status, "id": id}, true);
  print("GROUPON SWIPE :: ${response.statusCode}");
  print("GROUPON SWIPE :: ${response.body}");
}
