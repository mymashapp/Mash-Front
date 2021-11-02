// getNearByFriends() async {
//   LeaderBoardController leaderBoardController =
//       Get.put(LeaderBoardController());
//   var response = await ApiBaseHelper.get(
//       testing
//           ? WebApi.getNearByFriends + "?lat=23&lon=72.571365&radius=8"
//           : WebApi.getNearByFriends +
//               "?lat=${authController.lat.value}&lon=${authController.lon.value}&radius=8",
//       true);
//
//   leaderBoardController.friendLocation.value =
//       friendsLocationModelFromJson(response.body).data!;
//   createMarkers();
// }
//
// createMarkers() {
//   LeaderBoardController leaderBoardController =
//       Get.put(LeaderBoardController());
//   leaderBoardController.loading.value = true;
//
//   Marker marker;
//
//   leaderBoardController.friendLocation.forEach((element) async {
//     marker = Marker(
//         markerId: MarkerId(element.userId.toString()),
//         position: LatLng(element.userLat!, element.userLong!),
//         icon: await getMarkerIcon(
//             await getProfile(element.userId!), Size(100, 100)),
//         infoWindow: InfoWindow(
//           title: element.fullName,
//           snippet: "${element.distanceInMiles!.toStringAsFixed(2)} Miles",
//         ),
//         onTap: () {
//           if (leaderBoardController.selectedUserId.value == element.userId) {
//             leaderBoardController.selectedUserId.value = 0000;
//           } else {
//             leaderBoardController.selectedUserId.value = element.userId!;
//           }
//         });
//     leaderBoardController.markers.add(marker);
//     leaderBoardController.markers.add(Marker(
//       markerId: MarkerId(authController.user.value.userId.toString()),
//       position: LatLng(23, 72.571365),
//       icon: await getMarkerIcon(
//           await getProfile(authController.user.value.userId!), Size(100, 100)),
//       infoWindow: InfoWindow(
//         title: authController.user.value.fullName,
//         snippet: "Me",
//       ),
//     ));
//   });
//   leaderBoardController.loading.value = false;
// }
//
// Future<ui.Image> getImageFromPath(String imagePath) async {
//   final response = await http.get(Uri.parse(imagePath));
//
//   final documentDirectory = await getApplicationDocumentsDirectory();
//
//   final file = File(documentDirectory.path + 'imagetest.png');
//
//   file.writeAsBytesSync(response.bodyBytes);
//
//   File imageFile = file;
//
//   Uint8List imageBytes = imageFile.readAsBytesSync();
//
//   final Completer<ui.Image> completer = new Completer();
//
//   ui.decodeImageFromList(imageBytes, (ui.Image img) {
//     return completer.complete(img);
//   });
//
//   return completer.future;
// }
//
// Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
//   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//   final Canvas canvas = Canvas(pictureRecorder);
//
//   final Radius radius = Radius.circular(size.width / 2);
//
//   // final Paint tagPaint = Paint()..color = AppColors.kOrange;
//   // final double tagWidth = 40.0;
//
//   final Paint shadowPaint = Paint()..color = AppColors.kOrange;
//   final double shadowWidth = 5.0;
//
//   final Paint borderPaint = Paint()..color = Colors.white;
//   final double borderWidth = 3.0;
//
//   final double imageOffset = shadowWidth + borderWidth;
//
//   // Add shadow circle
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(0.0, 0.0, size.width, size.height),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       shadowPaint);
//
//   // Add border circle
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(shadowWidth, shadowWidth, size.width - (shadowWidth * 2),
//             size.height - (shadowWidth * 2)),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       borderPaint);
//
//   // Add tag circle
//   // canvas.drawRRect(
//   //     RRect.fromRectAndCorners(
//   //       Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
//   //       topLeft: radius,
//   //       topRight: radius,
//   //       bottomLeft: radius,
//   //       bottomRight: radius,
//   //     ),
//   //     tagPaint);
//
//   // Add tag text
//   // TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
//   // textPainter.text = TextSpan(
//   //   text: '1',
//   //   style: TextStyle(fontSize: 20.0, color: Colors.white),
//   // );
//   //
//   // textPainter.layout();
//   // textPainter.paint(
//   //     canvas,
//   //     Offset(size.width - tagWidth / 2 - textPainter.width / 2,
//   //         tagWidth / 2 - textPainter.height / 2));
//
//   // Oval for the image
//   Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
//       size.width - (imageOffset * 2), size.height - (imageOffset * 2));
//
//   // Add path for oval image
//   canvas.clipPath(Path()..addOval(oval));
//
//   // Add image
//   ui.Image image = await getImageFromPath(
//       imagePath); // Alternatively use your own method to get the image
//   paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
//
//   // Convert canvas to image
//   final ui.Image markerAsImage = await pictureRecorder
//       .endRecording()
//       .toImage(size.width.toInt(), size.height.toInt());
//
//   // Convert image to bytes
//   final ByteData? byteData =
//       await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
//   final Uint8List uint8List = byteData!.buffer.asUint8List();
//   return BitmapDescriptor.fromBytes(uint8List);
// }
