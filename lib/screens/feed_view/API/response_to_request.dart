import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/feed_view/API/get_friend_request_list.dart';
import 'package:mash/screens/feed_view/controller/friend_controller.dart';
import 'package:mash/widgets/error_snackbar.dart';

responseToRequest(int id, int status) async {
  FriendController friendController = Get.put(FriendController());
  friendController.loading.value = true;
  http.Response response = await ApiBaseHelper.post(
      WebApi.responseToFriend, {"friend_id": id, "responce": status}, true);
  friendController.loading.value = false;
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201) {
    getFriendRequestList();
    appSnackBar(
        "Friend request accepted", "Friend list is updated successfully");
  } else {
    errorSnackBar("Something went wrong", "Please try again after sometime");
  }
}
