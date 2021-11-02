import 'package:mash/main.dart';

class WebApi {
  static String baseUrl = 'http://newmashserver.rpsoftech.net:3333/';
  // static String baseUrl =
  //     'http://7232-2401-4900-1f3e-714b-78f2-88e4-1db2-c87e.ngrok.io/';
  static String loginUrl = "login";
  static String signUpUrl = "login/signup";
  static String fetchAllEvents = "event";
  static Uri getProfile = Uri.parse(baseUrl + "login/is_login");
  static String getOtherProfile = "user/get_user_data";
  static String createPersonalChat = "chat/create_chat";
  static String updateEventPic = "event/update_event_pic";
  static String updatePostPic = "user/add_public_pic";
  static String updatePrivatePic = "user/add_private_pic";
  static String getUsersFromChatId = "chat/chat_id_user_list?msg_id=";
  static String getChatIds = "chat/get_chat_ids";
  static String getPrivateChatIds = "chat/individual_chat_ids";
  static String chatOpened = "chat/chat_opened";
  static String sendMessage = "chat/send_message";
  static String sendPersonalMessage = "chat/send_personal_message";
  static String swipedService = "event/user_event_swiped";
  static String remash = "event/remash";
  static String refreshToken = "login/refresh_token";
  static String leaderBoard = "user/leaderbord";
  static String getNearByPlaces = "event/neighbourhood";
  static String getNearByFriends = "user/other_users_location";
  static String leaveChat = "chat/leave_chat";
  static String sendFriendRequest = "user/add_friend";
  static String friendRequestList = "user/requset_list";
  static String friendList = "user/friend_list";
  static String responseToFriend = "user/responce_to_reqest";
  static String updateUserDetail = "user/update_main_data";
  static String updateUserBasicData = "user/update_basic_data";
  static String updateUserPreferenceData = "user/update_preferance_data";
  static String createEvent = "event/insert_update_event";
  static String addComment = "lc/add_comment";
  static String addPrivateComment = "lc/add_prv_comment";
  static String giveLike = "lc/give_like";
  static String removeLike = "lc/remove_like";
  static String friendOnlyPics = "user/get_friends_pics";
  static String updateUserLocation = "user/update_user_location";
  static String getGroupon = "coupon/groupon";
  static String getAirBnb = "coupon/ar_bnb";
  static String likeOnPrivatePic = "lc/give_prv_like";
  static String removeLikeOnPrivatePic = "lc/remove_prv_like";
  static String airBnbSwipe = "coupon/insert_swipe";
  static String setToken = "user/set_notification_data";
  static String reportPost = "lc/report_post";
  static String blockUser = "user/block_user";
  static String reportPrivatePic = "lc/report_prv_post";

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    "Authorization": "Bearer ${authController.accessToken.value}"
  };
}
