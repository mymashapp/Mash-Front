import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/profile_view/API/compress_file.dart';
import 'package:mash/screens/profile_view/controller/profile_controller.dart';
import 'package:mash/widgets/error_snackbar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../main.dart';

updatePostPic(File file) async {
  ProfileController profileController = Get.put(ProfileController());
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  //create multipart request for POST or PATCH method
  profileController.loading.value = true;
  File compressed = await testCompressAndGetFile(file, tempPath);
  var request = http.MultipartRequest(
      "POST", Uri.parse(WebApi.baseUrl + WebApi.updatePostPic));
  //create multipart using filepath, string or bytes
  var pic = await http.MultipartFile.fromPath("pic", compressed.path);
  //add multipart to request
  request.fields.addIf(true, "desc", profileController.description.value.text);
  request.headers
      .addAll({"Authorization": "Bearer ${authController.accessToken.value}"});
  request.files.add(pic);
  var response = await request.send();

  //Get the response from the server
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  print(responseString);
  profileController.loading.value = false;
  profileController.description.value.clear();
  Get.back();
  appSnackBar(
      "Photo is successfully uploaded", "You can see it in discover section");
}

updatePrivatePostPic(File file) async {
  ProfileController profileController = Get.put(ProfileController());
  //create multipart request for POST or PATCH method
  profileController.loading.value = true;
  var request = http.MultipartRequest(
      "POST", Uri.parse(WebApi.baseUrl + WebApi.updatePrivatePic));
  //create multipart using filepath, string or bytes
  var pic = await http.MultipartFile.fromPath("pic", file.path);
  //add multipart to request
  request.files.add(pic);
  request.headers
      .addAll({"Authorization": "Bearer ${authController.accessToken.value}"});
  var response = await request.send();

  //Get the response from the server
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  print(responseString);
  profileController.loading.value = false;
  Get.back();
}
