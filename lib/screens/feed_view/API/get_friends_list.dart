import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/feed_view/controller/friend_controller.dart';
import 'package:mash/screens/feed_view/models/friend_list_model.dart';

getFriendList() async {
  FriendController friendController = Get.put(FriendController());
  friendController.loading.value = true;
  http.Response response =
      await ApiBaseHelper.get(WebApi.friendList + "?limit=10&stream=1", true);
  friendController.loading.value = false;
  print("HHEEEE ${response.statusCode}");
  print(response.body);
  if (response.statusCode == 200) {
    friendController.friendList.clear();

    FriendListModel friendModel = friendListModelFromJson(response.body);
    friendModel.data!.forEach((element) {
      friendController.friendList.add(element);
    });
  }
}

Future<bool> checkFriend(int id) async {
  bool yes = false;
  http.Response response =
      await ApiBaseHelper.get(WebApi.friendList + "?limit=1000&stream=1", true);
  if (response.statusCode == 200) {
    FriendListModel friendModel = friendListModelFromJson(response.body);
    friendModel.data!.forEach((element) {
      if (element.usersFriendsListFriendId == id) {
        yes = true;
      }
    });
  }
  return yes;
}
