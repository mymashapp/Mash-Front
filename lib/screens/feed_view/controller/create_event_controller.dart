import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:mash/configs/app_data.dart';

class CreateEventController extends GetxController {
  RxInt selectedCategory = 0.obs;
  RxInt selectedParty = 1.obs;
  RxInt selectedTime = 0.obs;
  Rx<DateTime> eventDate = DateTime.now().add(Duration(days: 2)).obs;
  Rx<TextEditingController> createEventTitle = TextEditingController().obs;
  Rx<TextEditingController> location = TextEditingController().obs;
  RxBool loading = false.obs;
  RxList<AutocompletePrediction> pred = <AutocompletePrediction>[].obs;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
}
