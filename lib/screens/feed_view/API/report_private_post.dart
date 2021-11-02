import 'package:get/get.dart';
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/feed_view/controller/leaderboard_controller.dart';
import 'package:mash/widgets/error_snackbar.dart';

reportPrivatePost(String report) async {
  LeaderBoardController leaderBoardController =
      Get.put(LeaderBoardController());
  leaderBoardController.reportOpen.value = false;
  var response = await ApiBaseHelper.post(WebApi.reportPrivatePic,
      {"pic_id": leaderBoardController.picId.value, "report": report}, true);

  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201) {
    appSnackBar("Post Reported Successfully",
        "Thank you for reporting post, we will look into this.");
  } else {
    errorSnackBar("Something went wrong!", "please try again after sometime.");
  }
}
