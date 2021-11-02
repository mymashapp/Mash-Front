import 'package:firebase_storage/firebase_storage.dart';

Future<String> getProfile(int? userId) async {
  String url = await FirebaseStorage.instance
      .ref('users/$userId/thumbnails/profile_pic_300x300.png')
      // .ref('users/$userId/thumbnails/profile_pic_300x300.png')
      .getDownloadURL()
      .catchError((e) {
    return "https://mbevivino.files.wordpress.com/2011/08/silhouette_orange.jpg";
  });
  url = url.length == 0 ? "" : url;
  return url;
}
