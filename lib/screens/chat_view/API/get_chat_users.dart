import 'package:get/get.dart';
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/chat_view/controller/chat_controller.dart';
import 'package:mash/screens/chat_view/models/chat_users_model.dart';
import 'package:mash/screens/chat_view/models/direct_chat_model.dart';

getChatUsers() async {
  ChatController chatController = Get.put(ChatController());
  chatController.loading.value = true;
  var response = await ApiBaseHelper.get(
      WebApi.getChatIds +
          "?stream=${chatController.currentPage.value}&limit=9&order_by=DESC&at_least_have_user=2",
      true);
  chatController.loading.value = false;

  List<ChatUsersModel> chatUserList = chatUsersModelFromJson(response.body);
  chatUserList.forEach((element) {
    chatController.chatUserList.add(element);
  });
  chatController.currentPage.value = chatController.currentPage.value + 1;
  if (chatUserList.length < 9) {
    chatController.lastPage.value = true;
  }
  chatController.bottomLoader.value = false;
}

getPrivateChatUsers() async {
  ChatController chatController = Get.put(ChatController());
  chatController.loading.value = true;
  var response = await ApiBaseHelper.get(
      WebApi.getPrivateChatIds +
          "?stream=${chatController.currentPage.value}&limit=9&order_by=DESC&at_least_have_user=2",
      true);
  print("HEE ::: ${response.statusCode}");
  print("HEE ::: ${response.body}");
  chatController.loading.value = false;
  List<Direct> chatUserList = directChatListFromJson(response.body).data!;
  chatUserList.forEach((element) {
    chatController.direct.add(element);
  });
  chatController.currentPage.value = chatController.currentPage.value + 1;
  if (chatUserList.length < 9) {
    chatController.lastPage.value = true;
  }
  chatController.bottomLoader.value = false;
}
