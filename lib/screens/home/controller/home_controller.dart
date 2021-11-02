import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/home/API/get_user_location.dart';
import 'package:mash/screens/home/model/air_bnb_model.dart';
import 'package:mash/screens/home/model/all_event_model.dart';
import 'package:mash/screens/home/model/groupon_model.dart';
import 'package:mash/screens/home/model/mix_event_model.dart';
import 'package:mash/screens/home/model/user_list_model.dart';

class HomeController extends GetxController {
  RxBool oneToOne = false.obs;
  RxBool threeChat = false.obs;
  RxBool groupChat = false.obs;
  RxBool isFilerButtonShow = false.obs;
  RxInt bottomIndex = 0.obs;
  RxInt selectedIndex = 99.obs;
  RxInt categorySelected = 0.obs;
  RxInt activitySelected = 0.obs;
  RxInt partySelectedIndex = 0.obs;
  RxInt genderSelected = 0.obs;
  RxInt datingSelectedIndex = 0.obs;
  RxInt timeListSelectedIndex = 0.obs;
  RxBool loading = false.obs;
  RxBool endOfEvents = false.obs;
  RxString eventName = "".obs;
  RxString eventImage = "".obs;
  RxMap<int, String> userProfile = Map<int, String>().obs;
  Rx<PageController> pageController = PageController().obs;

  RxList categoryList =
      ["Food / Drink", "Entertainment", "Recreation", "All of the Above"].obs;
  RxList activityList =
      ["Resturant", "Bar", "Coffee", "Desert", "Other", "All of the Above"].obs;
  RxList partyList = [
    "Individual",
    "Group of 3",
    "Group of 4",
  ].obs;
  RxList genderList = ["Man", "Woman", "Both"].obs;
  RxList datingList = [
    "Dating",
    "No - Dating",
  ].obs;
  RxList timeList = ["Today", "Tomorrow", "Weekend", "Set date"].obs;

  RxList buttonList = ["Category", "Activity", "Party", "Dating", "Time"].obs;

  RxList<Event> allEventModel = <Event>[].obs;
  RxList<UserOfMashList> userOfMashList = <UserOfMashList>[].obs;
  RxInt eventId = 0.obs;
  RxList<MixEventModel> mixEvent = <MixEventModel>[].obs;

  fetchAllEvents() async {
    loading.value = true;
    authController.apiMessage.value = "Fetching Location...";

    if (!testing) await getUserLocation();

    allEventModel.clear();

    authController.apiMessage.value = "Fetching Experiences around you...";
    String url = testing
        ? "${WebApi.baseUrl + "event?user_lat=${42.34784169448538}&user_log=${-71.07124328613281}&stream=1&limit=15&random=true"}"
        : "${WebApi.baseUrl + "event?user_lat=${authController.lat.value}&user_log=${authController.lon.value}&stream=1&limit=20&random=true"}";
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer ${authController.accessToken.value}"
    });
    loading.value = false;

    print("EVENT ::: ${response.statusCode}");
    print("EVENT BODY ::: ${response.body}");

    if (response.statusCode == 200) {
      List<Event> event = allEventModelFromJson(response.body).data!;
      print("TOTAL EVENTS ::: ${event.length}");
      event.forEach((element) {
        mixEvent.add(MixEventModel(
            event: element, airBnb: null, groupon: null, type: "Event"));
      });
      mixEvent.shuffle();
    } else if (response.statusCode == 400) {
    } else if (response.statusCode == 601) {
      authController.apiMessage.value = "Daily quota limit exceeded";
    } else if (response.statusCode == 602) {
      authController.apiMessage.value = "We are coming soon at this location";
    } else if (response.statusCode == 603) {
      authController.apiMessage.value =
          "Please wait for 0 seconds we are updating events for your location.";
    } else {}
  }

  fetchAirBnb() async {
    allEventModel.clear();
    authController.apiMessage.value = "Fetching Experiences around you...";
    loading.value = true;
    if (!testing) await getUserLocation();
    String url = testing
        ? "${WebApi.baseUrl + "coupon/ar_bnb?lat=${30.3079823}&log=${-97.8938302}&stream=1&limit=5&random=true"}"
        : "${WebApi.baseUrl + "coupon/ar_bnb?lat=${authController.lat.value}&log=${authController.lon.value}&stream=1&limit=5&random=true"}";
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer ${authController.accessToken.value}"
    });
    loading.value = false;

    print("AIR BNB ::: ${response.statusCode}");
    print("AIR BNB BODY ::: ${response.body}");
    if (response.statusCode == 200) {
      List<AirBnb> airBnb = airBnBModelFromJson(response.body).data!;
      print("TOTAL AIRBNB ::: ${airBnb.length}");

      airBnb.forEach((element) {
        mixEvent.add(MixEventModel(
            event: null, airBnb: element, groupon: null, type: "AirBnb"));
      });
      mixEvent.shuffle();
    } else if (response.statusCode == 400) {
      authController.apiMessage.value = "Something went wrong!";
    } else if (response.statusCode == 601) {
      authController.apiMessage.value = "Daily quota limit exceeded";
    } else if (response.statusCode == 602) {
      authController.apiMessage.value = "We are coming soon at this location";
    } else if (response.statusCode == 603) {
      authController.apiMessage.value =
          "Please wait for 0 seconds we are updating events for your location.";
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  fetchGroupon() async {
    allEventModel.clear();
    loading.value = true;
    if (!testing) await getUserLocation();

    print(authController.lat.value);
    print(authController.lon.value);
    String url = testing
        ? "${WebApi.baseUrl + "coupon/groupon?lat=${30.3079823}&log=${-97.8938302}&stream=1&limit=5&random=true"}"
        : "${WebApi.baseUrl + "coupon/groupon?lat=${authController.lat.value}&log=${authController.lon.value}&stream=1&limit=5&random=true"}";
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer ${authController.accessToken.value}"
    });
    loading.value = false;
    print("GROUPON BNB ::: ${response.statusCode}");
    print("GROUPON BODY ::: ${response.body}");
    if (response.statusCode == 200) {
      List<Groupon> groupon = grouponModelFromJson(response.body).data!;
      print("TOTAL GROUPON ::: ${groupon.length}");

      groupon.forEach((element) {
        mixEvent.add(MixEventModel(
            event: null, airBnb: null, groupon: element, type: "Groupon"));
      });
      mixEvent.shuffle();
    } else if (response.statusCode == 400) {
      authController.apiMessage.value = "Something went wrong!";
    } else if (response.statusCode == 601) {
      authController.apiMessage.value = "Daily quota limit exceeded";
    } else if (response.statusCode == 602) {
      authController.apiMessage.value = "We are coming soon at this location";
    } else if (response.statusCode == 603) {
      authController.apiMessage.value =
          "Please wait for 0 seconds we are updating events for your location.";
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  @override
  void onInit() async {
    fetchAllEvents();
    fetchAirBnb();
    fetchGroupon();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
  }
}
