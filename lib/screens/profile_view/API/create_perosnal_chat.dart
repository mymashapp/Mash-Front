import 'dart:convert';

import 'package:get/get.dart';
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/chat_view/chat_view.dart';
import 'package:mash/widgets/error_snackbar.dart';

Future<String> createPersonalChat(
    int userId, String name, bool navigate) async {
  var response = await ApiBaseHelper.post(
      WebApi.createPersonalChat, {"friend_id": userId}, true);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (navigate) {
      Get.to(() => ChatView(
          messageId: data["chat_id"],
          eventName: name,
          event: false,
          eventImage: userId.toString()));
      return "";
    } else {
      return data["chat_id"];
    }
  } else {
    errorSnackBar("Something went wrong", "Please try again");
    return "";
  }
}
