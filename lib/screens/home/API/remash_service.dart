import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/home/controller/home_controller.dart';

remashService() async {
  HomeController homeController = Get.put(HomeController());
  var response = await http.put(Uri.parse(WebApi.baseUrl + WebApi.remash),
      headers: WebApi.header,
      body: jsonEncode({"event_id": homeController.eventId.value}));
  print(response.statusCode);
  print(response.body);
}
