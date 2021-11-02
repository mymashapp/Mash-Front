import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/configs/app_textfield.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/screens/chat_view/API/sned_personal_message.dart';
import 'package:mash/screens/chat_view/models/other_user_model.dart';
import 'package:mash/screens/feed_view/API/update_user_location.dart';
import 'package:mash/screens/feed_view/controller/leaderboard_controller.dart';
import 'package:mash/screens/feed_view/models/friend_location_model.dart';
import 'package:mash/screens/profile_view/API/create_perosnal_chat.dart';
import 'package:mash/screens/profile_view/API/get_other_profile.dart';
import 'package:mash/widgets/loading_circular_image.dart';
import 'package:path_provider/path_provider.dart';

import '../../../main.dart';

class AppMap extends StatefulWidget {
  @override
  _AppMapState createState() => _AppMapState();
}

class _AppMapState extends State<AppMap> {
  LeaderBoardController leaderBoardController =
      Get.put(LeaderBoardController());

  Completer<GoogleMapController> _controller = Completer();
  late String _mapStyle;

  late GoogleMapController mapController;

  Set<Marker> markers = {};
  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    // TODO: implement initState
    super.initState();

    getNearByFriends();
  }

  int id = 0000;
  bool loading = false;

  getNearByFriends() async {
    loading = true;
    var response = await ApiBaseHelper.get(
        testing
            ? WebApi.getNearByFriends + "?lat=23&lon=72.571365&radius=8"
            : WebApi.getNearByFriends +
                "?lat=${authController.lat.value}&lon=${authController.lon.value}&radius=8",
        true);
    print(friendsLocationModelFromJson(response.body).data!.length);
    loading = false;

    createMarkers(friendsLocationModelFromJson(response.body).data!);
  }

  createMarkers(List<FriendLocation> fl) async {
    Marker marker;
    fl.forEach((element) async {
      marker = Marker(
          markerId: MarkerId(element.userId.toString()),
          position: LatLng(element.userLat!, element.userLong!),
          icon: await getMarkerIcon(
              await getProfile(element.userId!), Size(100, 100)),
          infoWindow: InfoWindow(
            title: element.fullName,
            snippet: "${element.distanceInMiles!.toStringAsFixed(2)} Miles",
          ),
          onTap: () {
            if (id == element.userId) {
              id = 0000;
            } else {
              id = element.userId!;
            }
            setState(() {});
          });
      markers.add(marker);
      setState(() {});
    });
    if (authController.showLocation.value) {
      markers.add(Marker(
        markerId: MarkerId(authController.user.value.userId.toString()),
        position: LatLng(authController.lat.value, authController.lon.value),
        icon: await getMarkerIcon(
            await getProfile(authController.user.value.userId!),
            Size(100, 100)),
        infoWindow: InfoWindow(
          title: authController.user.value.fullName,
          snippet: "Me",
        ),
      ));
    }
    loading = false;
    setState(() {});
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    final response = await http.get(Uri.parse(imagePath));

    final documentDirectory = await getTemporaryDirectory();

    final file = File(documentDirectory.path + 'imagetest.png');

    file.writeAsBytesSync(response.bodyBytes);

    File imageFile = file;

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    // final Paint tagPaint = Paint()..color = AppColors.kOrange;
    // final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = AppColors.kOrange;
    final double shadowWidth = 5.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    // canvas.drawRRect(
    //     RRect.fromRectAndCorners(
    //       Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
    //       topLeft: radius,
    //       topRight: radius,
    //       bottomLeft: radius,
    //       bottomRight: radius,
    //     ),
    //     tagPaint);

    // Add tag text
    // TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    // textPainter.text = TextSpan(
    //   text: '1',
    //   style: TextStyle(fontSize: 20.0, color: Colors.white),
    // );
    //
    // textPainter.layout();
    // textPainter.paint(
    //     canvas,
    //     Offset(size.width - tagWidth / 2 - textPainter.width / 2,
    //         tagWidth / 2 - textPainter.height / 2));

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await getImageFromPath(
        imagePath); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(uint8List);
  }

  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mash Map",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors.kOrange,
                            fontWeight: FontWeight.w600),
                      ),
                      Switch(
                        value: authController.showLocation.value,
                        onChanged: (value) async {
                          loading = true;
                          updateUserLocation(value);
                          authController.showLocation.value = value;
                          if (value) {
                            markers.add(Marker(
                              markerId: MarkerId(
                                  authController.user.value.userId.toString()),
                              position: LatLng(authController.lat.value,
                                  authController.lon.value),
                              icon: await getMarkerIcon(
                                  await getProfile(
                                      authController.user.value.userId!),
                                  Size(100, 100)),
                              infoWindow: InfoWindow(
                                title: authController.user.value.fullName,
                                snippet: "Me",
                              ),
                            ));
                          } else {
                            markers.removeWhere((element) =>
                                element.markerId ==
                                MarkerId(authController.user.value.userId
                                    .toString()));
                          }
                          loading = false;
                          setState(() {});
                        },
                        activeColor: AppColors.kOrange,
                      )
                    ],
                  ),
                ),
                loading
                    ? LinearProgressIndicator(
                        color: AppColors.kOrange,
                        backgroundColor: AppColors.lightOrange,
                      )
                    : SizedBox(),
                Expanded(
                    child: GoogleMap(
                  mapType: MapType.normal,
                  markers: markers,
                  // minMaxZoomPreference: MinMaxZoomPreference(14, 17),
                  myLocationButtonEnabled: false,
                  initialCameraPosition: leaderBoardController.current.value,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    mapController = controller;

                    mapController.setMapStyle(_mapStyle);
                  },
                ))
              ],
            ),
            if (id == 0000)
              SizedBox()
            else
              Container(
                height: 130,
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                margin: EdgeInsets.only(left: 10, right: 10, top: 66),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.kOrange, width: 3),
                    color: AppColors.lightOrange,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(4, 4),
                          blurRadius: 10)
                    ]),
                child: FutureBuilder<OtherUser>(
                  future: getOtherProfileDetails(id.toString()),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return InkWell(
                        onTap: () {
                          // Get.to(() => OtherUserProfile(
                          //     userId: snap.data!.userId!,
                          //     userName: snap.data!.fullName!,
                          //     alreadyFriend: false));
                        },
                        child: Row(
                          children: [
                            FutureBuilder<String>(
                                future: getProfile(snap.data!.userId!),
                                builder: (context, profileSnap) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(4, 4),
                                              blurRadius: 6)
                                        ]),
                                    child: loadingCircularImage(
                                        profileSnap.hasData
                                            ? profileSnap.data!
                                            : "",
                                        38),
                                  );
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        snap.data!.fullName!,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ", ${DateTime.now().difference(snap.data!.dob!).inDays ~/ 365}"
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text(
                                        snap.data!.userBasicExtra!.location!),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: appTextField(
                                              controller: msgController,
                                              hintText: "Send Message")),
                                      IconButton(
                                          onPressed: () async {
                                            if (msgController.text
                                                    .trim()
                                                    .length >
                                                0) {
                                              createPersonalChat(
                                                      snap.data!.userId!,
                                                      snap.data!.fullName!,
                                                      false)
                                                  .then((value) {
                                                sendPersonalMessage(
                                                    msgController.text,
                                                    value,
                                                    "msg");
                                                msgController.clear();
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.send,
                                            color: AppColors.kOrange,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kOrange,
                        ),
                      );
                    }
                  },
                ),
              )
          ],
        ),
      );
    });
  }
}
