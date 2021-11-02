import 'package:get/get.dart';
import 'package:mash/screens/feed_view/models/friend_list_model.dart';
import 'package:mash/screens/feed_view/models/friend_request_list_model.dart';

class FriendController extends GetxController {
  RxList<FriendRequest> friendRequestList = <FriendRequest>[].obs;
  RxList<Friend> friendList = <Friend>[].obs;
  RxBool loading = false.obs;
}
