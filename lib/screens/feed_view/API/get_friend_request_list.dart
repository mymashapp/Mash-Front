import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/feed_view/controller/friend_controller.dart';
import 'package:mash/screens/feed_view/models/friend_request_list_model.dart';

getFriendRequestList() async {
  FriendController friendController = Get.put(FriendController());
  friendController.loading.value = true;
  http.Response response = await ApiBaseHelper.get(
      WebApi.friendRequestList + "?limit=10&stream=1", true);
  friendController.loading.value = false;
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    friendController.friendRequestList.clear();
    FriendRequestModel friendRequestModel =
        friendRequestListModelFromJson(response.body);
    friendRequestModel.data!.forEach((element) {
      friendController.friendRequestList.add(element);
    });
  }
}
