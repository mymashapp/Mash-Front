import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/screens/home/controller/home_controller.dart';
import 'package:mash/screens/home/model/user_list_model.dart';

getUsersFromChatId(String chatId) async {
  HomeController homeController = Get.put(HomeController());
  var response = await http.get(
      Uri.parse(WebApi.baseUrl + WebApi.getUsersFromChatId + chatId),
      headers: WebApi.header);

  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    homeController.userOfMashList.value =
        usersOfMashFromJson(response.body).list!;
    homeController.userOfMashList.forEach((element) async {
      String url = await getProfile(element.chatMainUsersId);
      homeController.userProfile.addIf(true, element.chatMainUsersId!, url);
    });
  } else {}
}
