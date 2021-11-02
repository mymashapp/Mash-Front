import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> description = TextEditingController().obs;
  RxInt private = 0.obs;
  RxBool loading = false.obs;
}
