import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/chat_view/models/other_user_model.dart';
import 'package:mash/widgets/error_snackbar.dart';

Future<OtherUser> getOtherProfileDetails(String userId) async {
  var response = await ApiBaseHelper.get(
      WebApi.getOtherProfile + "?user_id=$userId", true);
  print("OTHER USER ::: ${response.statusCode}");
  print("OTHER USER ::: ${response.body}");
  if (response.statusCode == 200) {
    try{
      otherUserModelFromJson(response.body);
    }catch (e){
      print(e.toString());
    }
    OtherUser user = otherUserModelFromJson(response.body).data!;
    print(user.fullName);
    return user;
  } else {
    errorSnackBar("Something went wrong", "Please try again");
    return OtherUser();
  }
}
