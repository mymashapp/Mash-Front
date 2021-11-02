import 'package:flutter/material.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/widgets/loading_circular_image.dart';

Widget userProfile(String id, double radius) {
  return FutureBuilder<String>(
    future: getProfile(int.parse(id)),
    builder: (context, snap) {
      return loadingCircularImage(snap.hasData ? snap.data! : "", radius);
    },
  );
}
