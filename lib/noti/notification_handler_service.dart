import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:mash/screens/feed_view/API/get_friend_request_list.dart';
import 'package:mash/screens/home/controller/home_controller.dart';

import '../main.dart';

notificationHandlerService() {
  HomeController homeController = Get.put(HomeController());
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    print(event.notification!.body);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    if (message.data["type"] == "Friend Request") {
      authController.feedTabController.value.animateTo(1);
      authController.friendController.value.animateTo(1);
      getFriendRequestList();
      homeController.bottomIndex.value = 2;
      homeController.pageController.value.jumpToPage(2);
    } else if (message.data["type"] == "Friend Photos") {
      authController.feedTabController.value.animateTo(0);
      authController.discoverController.value.animateTo(1);
      homeController.bottomIndex.value = 2;
      homeController.pageController.value.jumpToPage(2);
    } else if (message.data["type"] == "New Mash") {
      homeController.bottomIndex.value = 1;
      homeController.pageController.value.jumpToPage(1);
    }
  });
}
