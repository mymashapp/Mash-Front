import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';

Future<bool> addComment(String msg, String postId) async {
  var response = await ApiBaseHelper.post(
      WebApi.addComment, {"comment": msg, "pic_id": postId}, true);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
