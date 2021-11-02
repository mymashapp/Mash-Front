import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/feed_view/controller/create_event_controller.dart';
import 'package:mash/screens/profile_view/API/compress_file.dart';
import 'package:mash/widgets/error_snackbar.dart';
import 'package:path_provider/path_provider.dart';

createEventService(File? file) async {
  CreateEventController createEventController =
      Get.put(CreateEventController());
  createEventController.loading.value = true;
  print({
    "event_name": createEventController.createEventTitle.value.text,
    "event_lat": createEventController.lat.value,
    "event_log": createEventController.lng.value,
    "place_name": createEventController.location.value.text,
    "event_date_timestamp":
        DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
    "category": createEventController.selectedCategory.value,
    "party": createEventController.selectedParty.value
  });
  DateTime dateTime = createEventController.eventDate.value;
  int time = createEventController.selectedTime.value;
  http.Response response = await ApiBaseHelper.put(
      WebApi.createEvent,
      {
        "event_name": createEventController.createEventTitle.value.text,
        "event_lat": createEventController.lat.value,
        "event_log": createEventController.lng.value,
        "place_name": createEventController.location.value.text,
        "event_date_timestamp": time == 0
            ? DateTime.now().add(Duration(seconds: 3)).millisecondsSinceEpoch ~/
                1000
            : time == 1
                ? DateTime.now()
                        .add(Duration(days: 1))
                        .millisecondsSinceEpoch ~/
                    1000
                : dateTime.millisecondsSinceEpoch ~/ 1000,
        "category": createEventController.selectedCategory.value,
        "party": createEventController.selectedParty.value
      },
      true);
  createEventController.loading.value = false;
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    if (file != null) {
      updateEventPic(decodedData["event_id"].toString(), file);
    } else {
      Get.back();
      appSnackBar("Event Created Successfully",
          "Wait to someone find your event interesting");
    }
  }
}

updateEventPic(String eventId, File file) async {
  CreateEventController createEventController =
      Get.put(CreateEventController());
  //create multipart request for POST or PATCH method
  createEventController.loading.value = true;

  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  //create multipart request for POST or PATCH method
  File compressed = await testCompressAndGetFile(file, tempPath);
  var request = http.MultipartRequest(
      "POST", Uri.parse(WebApi.baseUrl + WebApi.updateEventPic));
  request.headers.addAll({
    'Content-Type': 'application/json',
    "Authorization": "Bearer ${authController.accessToken.value}"
  });
  //add text fields
  request.fields["event_id"] = eventId;
  //create multipart using filepath, string or bytes
  var pic = await http.MultipartFile.fromPath("pic", compressed.path);
  //add multipart to request
  request.files.add(pic);
  var response = await request.send();

  //Get the response from the server
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  print("PHOTO :::::: ${responseString}");
  print("PHOTo ::;::: ${responseData}");
  print(response.statusCode);
  createEventController.loading.value = false;

  Get.back();
  appSnackBar("Event Created Successfully",
      "Wait to someone find your event interesting");
}
