import 'package:get/get.dart';
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/feed_view/controller/leaderboard_controller.dart';
import 'package:mash/screens/feed_view/models/leaderboard_user_model.dart';

getLeaderBoard() async {
  LeaderBoardController leaderBoardController =
      Get.put(LeaderBoardController());

  leaderBoardController.loading.value = true;
  var response = await ApiBaseHelper.get(
      WebApi.leaderBoard +
          "?from_total=${leaderBoardController.selectedTab.value == 1}",
      true);
  leaderBoardController.loading.value = false;
  leaderBoardController.leaderBoardUser.clear();
  print(response.statusCode);
  print(response.body);
  leaderboardUsersFromJson(response.body).data!.forEach((element) {
    leaderBoardController.leaderBoardUser.add(element);
  });
}
