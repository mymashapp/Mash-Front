import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File> testCompressAndGetFile(File file, String targetPath) async {
  print(file.path);
  print(file.absolute.path);
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath + "Upload.jpg",
    quality: 50,
  );

  print("FILE ::: ${file.lengthSync()}");
  print("COMPRESS ::: ${result!.lengthSync()}");

  return result;
}
