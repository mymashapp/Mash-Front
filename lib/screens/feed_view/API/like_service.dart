import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';

giveLike(postId) async {
  // var response =
  //     await ApiBaseHelper.post(WebApi.giveLike, {"pic_id": postId}, true);

  var response =
      await http.post(Uri.parse(WebApi.baseUrl + WebApi.giveLike), headers: {
    // 'Content-Type': 'application/json',
    "Authorization": "Bearer ${authController.accessToken.value}"
  }, body: {
    "pic_id": postId
  });
  print("HEllo :: ${response.statusCode}");
  print("HEllo :: ${response.body}");
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

removeLike(postId) async {
  // var response =
  //     await ApiBaseHelper.post(WebApi.giveLike, {"pic_id": postId}, true);

  var response =
      await http.post(Uri.parse(WebApi.baseUrl + WebApi.removeLike), headers: {
    // 'Content-Type': 'application/json',
    "Authorization": "Bearer ${authController.accessToken.value}"
  }, body: {
    "pic_id": postId
  });
  print("Remove :: ${response.statusCode}");
  print("Remove :: ${response.body}");
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
