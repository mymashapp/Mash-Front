import 'package:get/get.dart';
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/feed_view/controller/leaderboard_controller.dart';
import 'package:mash/screens/feed_view/models/friend_only_pics.dart';

getFriendOnlyPics() async {
  LeaderBoardController leaderBoardController =
      Get.put(LeaderBoardController());
  leaderBoardController.loading.value = true;
  var response = await ApiBaseHelper.get(
      WebApi.friendOnlyPics + "?stream=1&limit=3", true);
  leaderBoardController.loading.value = false;

  print("FRD PHOTO :: ${response.statusCode}");
  print("FRD PHOTO :: ${response.body}");

  leaderBoardController.friendPics.value =
      friendOnlyPicsFromJson(response.body).data!;
}
