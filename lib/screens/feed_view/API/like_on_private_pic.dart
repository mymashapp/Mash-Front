import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';

givePrivateLike(postId) async {
  var response = await http
      .post(Uri.parse(WebApi.baseUrl + WebApi.likeOnPrivatePic), headers: {
    // 'Content-Type': 'application/json',
    "Authorization": "Bearer ${authController.accessToken.value}"
  }, body: {
    "pic_id": postId
  });
  print("PRIVATE LIKE :: ${response.statusCode}");
  print("PRIVATE LIKE :: ${response.body}");
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

removePrivateLike(postId) async {
  var response = await http.post(
      Uri.parse(WebApi.baseUrl + WebApi.removeLikeOnPrivatePic),
      headers: {
        // 'Content-Type': 'application/json',
        "Authorization": "Bearer ${authController.accessToken.value}"
      },
      body: {
        "pic_id": postId
      });
  print("PRIVATE LIKE :: ${response.statusCode}");
  print("PRIVATE LIKE :: ${response.body}");
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
