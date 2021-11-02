import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mash/main.dart';

Future<void> uploadProfile(String filePath) async {
  print("START");
  File file = File(filePath);

  try {
    await FirebaseStorage.instance
        .ref('users/${authController.user.value.userId}/profile_pic.png')
        .putFile(file)
        .then((val) => print(val));
  } on FirebaseException catch (e) {
    print("ERROR ::: ${e.toString()}");
    // e.g, e.code == 'canceled'
  }
  print("END");
}
