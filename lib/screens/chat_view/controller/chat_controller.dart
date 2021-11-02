import 'package:get/get.dart';
import 'package:mash/screens/chat_view/models/chat_users_model.dart';
import 'package:mash/screens/chat_view/models/direct_chat_model.dart';

class ChatController extends GetxController {
  RxInt selectedIndex = 100.obs;
  RxInt selectedRate = 100.obs;
  RxList<ChatUsersModel> chatUserList = <ChatUsersModel>[].obs;
  RxList<Direct> direct = <Direct>[].obs;
  RxInt currentPage = 1.obs;
  RxInt currentTab = 0.obs;
  RxBool lastPage = false.obs;
  RxBool bottomLoader = false.obs;
  RxBool loading = false.obs;
}
