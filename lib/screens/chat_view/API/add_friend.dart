import 'package:http/http.dart' as http;
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/widgets/error_snackbar.dart';

addFriend(int userId) async {
  http.Response response = await ApiBaseHelper.post(
      WebApi.sendFriendRequest, {"friend_id": userId}, true);

  print("heeee :: ${response.statusCode}");
  print(response.body);
  if (response.statusCode == 201) {
    appSnackBar("Friend Request Sent Successfully",
        "Sending request to your friend has been completed");
  } else if (response.statusCode == 400) {
    errorSnackBar("Already Friend", "Please try again later");
  } else {
    errorSnackBar("Something went wrong", "Please try again later");
  }
}
