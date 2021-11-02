import 'package:get/get.dart';
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/chat_view/controller/chat_controller.dart';
import 'package:mash/widgets/error_snackbar.dart';

leaveChat(String chatId) async {
  ChatController chatController = Get.put(ChatController());
  chatController.loading.value = true;
  Get.back();
  var response =
      await ApiBaseHelper.post(WebApi.leaveChat, {"chat_id": chatId}, true);
  chatController.loading.value = false;
  if (response.statusCode == 200) {
    chatController.chatUserList.clear();
    chatController.currentPage.value = 1;
    chatController.lastPage.value = false;
    Get.back();
  } else {
    errorSnackBar("Something went wrong", "Please try again later");
  }
}
