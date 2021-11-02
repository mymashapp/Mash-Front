import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/home/API/swipe_airbnb.dart';
import 'package:mash/screens/home/API/swiped_service.dart';
import 'package:mash/screens/home/controller/home_controller.dart';
import 'package:mash/screens/home/model/mix_event_model.dart';

import 'air_bnb_card.dart';
import 'event_card.dart';
import 'groupon_card.dart';

class TCardPage extends StatefulWidget {
  const TCardPage({Key? key}) : super(key: key);

  @override
  _TCardPageState createState() => _TCardPageState();
}

class _TCardPageState extends State<TCardPage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.loading.value || homeController.mixEvent.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/animations/searching.json",
                    width: Get.width),
                Lottie.asset("assets/animations/searching.json",
                    width: Get.width),
                Center(
                  child: Text(
                    authController.apiMessage.value,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 18.sp, color: AppColors.kOrange),
                  ),
                )
              ],
            )
          :
          // Obx(() => TCard(
          //           size: Size(MediaQuery.of(context).size.width, Get.height),
          //           cards: List.generate(
          //             homeController.mixEvent.length,
          //             (int index) {
          //               MixEventModel data = homeController.mixEvent[index];
          //               return data.type == "Event"
          //                   ? eventCard(data.event!)
          //                   : data.type == "AirBnb"
          //                       ? airBnbCard(data.airBnb!)
          //                       : grouponCard(data.groupon!);
          //             },
          //           ),
          //           lockYAxis: true,
          //           slideSpeed: 12,
          //           delaySlideFor: 300,
          //           onBack: (int, info) {
          //             HapticFeedback.mediumImpact();
          //             print("$int === ${info.direction}");
          //           },
          //           onEnd: () async {},
          //           onForward: (value, info) async {
          //             HapticFeedback.mediumImpact();
          //             print("VALUE ::: ${info.cardIndex}");
          //             print("INDEX ::: ${value - 1}");
          //             MixEventModel data = homeController.mixEvent[info.cardIndex];
          //             print(data.type);
          //             if (info.direction == SwipDirection.Left) {
          //               if (data.type == "Event") {
          //                 homeController.eventId.value = data.event!.eventId!;
          //                 homeController.eventName.value = data.event!.eventName!;
          //                 if (data.event!.eventExtra != null) {
          //                   homeController.eventImage.value =
          //                       data.event!.eventExtra!.imageUrl!;
          //                 }
          //                 swipeEvent(false);
          //               } else if (data.type == "AirBnb") {
          //                 await swipeAirbnb(data.airBnb!.id.toString(), 0);
          //               } else {
          //                 swipeGroupon(data.groupon!.goid.toString(), 0);
          //               }
          //             } else {
          //               if (data.type == "Event") {
          //                 homeController.eventId.value = data.event!.eventId!;
          //                 homeController.eventName.value = data.event!.eventName!;
          //                 if (data.event!.eventExtra != null) {
          //                   homeController.eventImage.value =
          //                       data.event!.eventExtra!.imageUrl!;
          //                 }
          //                 swipeEvent(true);
          //               } else if (data.type == "AirBnb") {
          //                 swipeAirbnb(data.airBnb!.id.toString(), 1);
          //               } else {
          //                 swipeGroupon(data.groupon!.id.toString(), 1);
          //               }
          //             }
          //             homeController.mixEvent.remove(data);
          //             if (homeController.mixEvent.length == 0) {
          //               await homeController.fetchAllEvents();
          //               await homeController.fetchAirBnb();
          //               await homeController.fetchGroupon();
          //             }
          //             setState(() {});
          //           },
          //         ));
          Padding(
              padding: EdgeInsets.all(10),
              child: Stack(
                children:
                    List.generate(homeController.mixEvent.length, (index) {
                  MixEventModel data = homeController.mixEvent[index];
                  return Stack(
                    children: [
                      Swipable(
                          animationDuration: 300,
                          verticalSwipe: false,
                          onSwipeStart: (drag) {
                            authController.swipeId.value = data.type == "Event"
                                ? data.event!.eventId.toString()
                                : data.type == "AirBnb"
                                    ? data.airBnb!.id.toString()
                                    : data.groupon!.id.toString();
                          },
                          onSwipeCancel: (offset, drag) {
                            authController.swipeStatus.value = 2;
                          },
                          onPositionChanged: (drag) {
                            if (!drag.delta.dx.isNegative) {
                              authController.swipeStatus.value = 1;
                            } else {
                              authController.swipeStatus.value = 0;
                            }
                          },
                          onSwipeLeft: (offset) async {
                            if (data.type == "Event") {
                              homeController.eventId.value =
                                  data.event!.eventId!;
                              homeController.eventName.value =
                                  data.event!.eventName!;
                              if (data.event!.eventExtra != null) {
                                homeController.eventImage.value =
                                    data.event!.eventExtra!.imageUrl!;
                              }
                              swipeEvent(false);
                            } else if (data.type == "AirBnb") {
                              await swipeAirbnb(data.airBnb!.id.toString(), 0);
                            } else {
                              swipeGroupon(data.groupon!.goid.toString(), 0);
                            }
                            homeController.mixEvent.removeAt(index);
                            if (homeController.mixEvent.length == 0) {
                              homeController.fetchAllEvents();
                              homeController.fetchAirBnb();
                              homeController.fetchGroupon();
                            }
                          },
                          onSwipeRight: (offset) async {
                            if (data.type == "Event") {
                              homeController.eventId.value =
                                  data.event!.eventId!;
                              homeController.eventName.value =
                                  data.event!.eventName!;
                              if (data.event!.eventExtra != null) {
                                homeController.eventImage.value =
                                    data.event!.eventExtra!.imageUrl!;
                              }
                              swipeEvent(true);
                            } else if (data.type == "AirBnb") {
                              swipeAirbnb(data.airBnb!.id.toString(), 1);
                            } else {
                              swipeGroupon(data.groupon!.id.toString(), 1);
                            }
                            homeController.mixEvent.removeAt(index);
                            if (homeController.mixEvent.length == 0) {
                              homeController.fetchAllEvents();
                              homeController.fetchAirBnb();
                              homeController.fetchGroupon();
                            }
                          },
                          threshold: 0.3,
                          child: data.type == "Event"
                              ? eventCard(data.event!)
                              : data.type == "AirBnb"
                                  ? airBnbCard(data.airBnb!)
                                  : grouponCard(data.groupon!)),
                    ],
                  );
                }),
              ),
            );

      // Padding(
      //         padding: EdgeInsets.all(10.0),
      //         child: SwipableStack(
      //           builder: (BuildContext context, int index,
      //               BoxConstraints constraints) {
      //             MixEventModel data = homeController.mixEvent[index];
      //             return data.type == "Event"
      //                 ? eventCard(data.event!)
      //                 : data.type == "AirBnb"
      //                     ? airBnbCard(data.airBnb!)
      //                     : grouponCard(data.groupon!);
      //           },
      //           onSwipeCompleted: (swipeIndex, direction) {
      //             if (homeController.mixEvent[swipeIndex].type == "Event") {
      //               homeController.eventId.value =
      //                   homeController.mixEvent[swipeIndex].event!.eventId!;
      //               homeController.eventName.value =
      //                   homeController.mixEvent[swipeIndex].event!.eventName!;
      //               if (homeController.mixEvent[swipeIndex].event!.eventExtra !=
      //                   null) {
      //                 homeController.eventImage.value = homeController
      //                     .mixEvent[swipeIndex].event!.eventExtra!.imageUrl!;
      //               }
      //             }
      //             if (direction == SwipeDirection.left) {
      //               if (homeController.mixEvent[swipeIndex].type == "Event") {
      //                 swipeEvent(false);
      //               }
      //             } else {
      //               if (homeController.mixEvent[swipeIndex].type == "Event") {
      //                 swipeEvent(true);
      //               }
      //             }
      //             homeController.mixEvent.removeAt(swipeIndex);
      //             if (homeController.mixEvent.length == 0) {
      //               homeController.fetchAllEvents();
      //               homeController.fetchAirBnb();
      //               homeController.fetchGroupon();
      //             }
      //           },
      //           onWillMoveNext: (index, direction) {
      //             final allowedActions = [
      //               SwipeDirection.right,
      //               SwipeDirection.left,
      //             ];
      //             return allowedActions.contains(direction);
      //           },
      //           allowVerticalSwipe: false,
      //           itemCount: homeController.mixEvent.length,
      //           swipeAnchor: SwipeAnchor.bottom,
      //         ),
      //       );

      ////////HEELLLLEOOO
    });
  }
}

Widget infoTiles(
    {required String title, String value = "", required IconData iconData}) {
  return Container(
    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            offset: Offset(2, 2),
            blurRadius: 10,
          )
        ]),
    child: Row(
      children: [
        Icon(
          iconData,
          color: AppColors.kOrange,
        ),
        SizedBox(
          width: 10,
        ),
        Text(title, style: GoogleFonts.sourceSansPro(fontSize: 16)),
        Spacer(),
        Text(
          value,
          style: GoogleFonts.sourceSansPro(
              color: AppColors.kOrange,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}
