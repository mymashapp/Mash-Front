import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/widgets/error_snackbar.dart';

blockUser(int userId) async {
  var response =
      await ApiBaseHelper.post(WebApi.blockUser, {"friend_id": userId}, true);

  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201) {
    appSnackBar("User is successfully blocked.",
        "User was blocked Now you can't see their activity");
  }
}
