import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/profile_view/API/get_profile.dart';

refreshTokenService() async {
  var response = await http.post(
      Uri.parse(WebApi.baseUrl + WebApi.refreshToken),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"token": authController.refreshToken.value}));
  print("REfresh : ${response.statusCode}");
  print("REfresh : ${response.body}");
  final box = GetStorage();
  box.write("accessToken", jsonDecode(response.body)["accessToken"]);
  authController.checkAuth();
  getProfileDetails();
}
