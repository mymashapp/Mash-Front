import 'dart:convert';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/screens/chat_view/API/add_friend.dart';
import 'package:mash/screens/chat_view/API/get_event_by_event_id.dart';
import 'package:mash/screens/chat_view/API/get_single_air_bnb.dart';
import 'package:mash/screens/chat_view/API/get_single_groupon.dart';
import 'package:mash/screens/chat_view/API/send_message.dart';
import 'package:mash/screens/chat_view/controller/chat_controller.dart';
import 'package:mash/screens/chat_view/models/air_bnb_model.dart';
import 'package:mash/screens/chat_view/models/message_model.dart';
import 'package:mash/screens/chat_view/models/single_event_model.dart';
import 'package:mash/screens/chat_view/models/single_groupon_model.dart';
import 'package:mash/screens/chat_view/single_detail_screen.dart';
import 'package:mash/screens/feed_view/single_airbnb_page.dart';
import 'package:mash/screens/feed_view/single_groupon_page.dart';
import 'package:mash/screens/home/controller/home_controller.dart';
import 'package:mash/screens/profile_view/other_user_profile.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/loading_circular_image.dart';
import 'package:mash/widgets/time_ago.dart';

import 'API/sned_personal_message.dart';

class ChatView extends StatefulWidget {
  final String messageId;
  final String eventName;
  final String eventImage;
  final bool event;
  ChatView(
      {required this.messageId,
      required this.eventName,
      required this.event,
      required this.eventImage});
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController controller = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.reference();
  List<MessageItem> list = <MessageItem>[];
  HomeController homeController = Get.put(HomeController());
  ChatController chatController = Get.put(ChatController());
  var data = {
    "event_feedbacks_message_id": "",
    "event_id": "",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kOrange,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            homeController.userOfMashList.clear();
            Get.back();
          },
        ),
        title: Row(
          children: [
            widget.event
                ? CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.eventImage),
                  )
                : FutureBuilder<String>(
                    future: getProfile(int.parse(widget.eventImage)),
                    builder: (context, snap) {
                      return loadingCircularImage(
                          snap.hasData ? snap.data! : "", 15);
                    },
                  ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.eventName,
              style: GoogleFonts.sourceSansPro(),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.dialog(Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.event
                          ? Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.kOrange,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Total Joined Peoples",
                                style: GoogleFonts.sourceSansPro(
                                    color: Colors.white, fontSize: 18),
                              ))
                          : SizedBox(),
                      widget.event
                          ? SizedBox(
                              height: 10,
                            )
                          : SizedBox(),
                      widget.event
                          ? Column(
                              children: homeController.userOfMashList.length ==
                                      0
                                  ? [SizedBox()]
                                  : List.generate(
                                      homeController.userOfMashList.length,
                                      (index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.back();
                                          Get.to(() => OtherUserProfile(
                                                alreadyFriend: homeController
                                                            .userOfMashList[
                                                                index]
                                                            .usersFriendsListStatus !=
                                                        null ||
                                                    homeController
                                                            .userOfMashList[
                                                                index]
                                                            .usersFriendsListStatus !=
                                                        1,
                                                userId: homeController
                                                    .userOfMashList[index]
                                                    .chatMainUsersId!,
                                                userName: homeController
                                                    .userOfMashList[index]
                                                    .fullName!,
                                              ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 16, right: 16, bottom: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Obx(() => homeController
                                                          .userProfile
                                                          .entries
                                                          .length ==
                                                      0
                                                  ? SizedBox()
                                                  : loadingCircularImage(
                                                      homeController
                                                              .userProfile[
                                                          homeController
                                                              .userOfMashList[
                                                                  index]
                                                              .chatMainUsersId]!,
                                                      25)),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                homeController
                                                    .userOfMashList[index]
                                                    .fullName!,
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        fontSize: 18.sp),
                                              ),
                                              Spacer(),
                                              homeController
                                                              .userOfMashList[
                                                                  index]
                                                              .usersFriendsListStatus ==
                                                          null ||
                                                      homeController
                                                              .userOfMashList[
                                                                  index]
                                                              .usersFriendsListStatus ==
                                                          1
                                                  ? SizedBox()
                                                  : authController.user.value
                                                              .userId ==
                                                          homeController
                                                              .userOfMashList[
                                                                  index]
                                                              .chatMainUsersId
                                                      ? SizedBox()
                                                      : IconButton(
                                                          onPressed: () {
                                                            addFriend(homeController
                                                                .userOfMashList[
                                                                    index]
                                                                .chatMainUsersId!);
                                                          },
                                                          icon: Icon(
                                                              Icons.person_add),
                                                          color:
                                                              AppColors.kOrange,
                                                        )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                            )
                          : SizedBox(),
                      widget.event
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 16, bottom: 16),
                              width: double.infinity,
                              child: MaterialButton(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                onPressed: () {},
                                child: Text(
                                  "Block User",
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white, fontSize: 16),
                                ),
                                color: Colors.red,
                              ),
                            ),
                      // Padding(
                      //   padding: EdgeInsets.all(16.0),
                      //   child: SizedBox(
                      //     width: double.infinity,
                      //     child: MaterialButton(
                      //       padding: EdgeInsets.symmetric(vertical: 10),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(6)),
                      //       onPressed: () {
                      //         leaveChat(widget.messageId);
                      //       },
                      //       child: Text(
                      //         "Leave",
                      //         style: GoogleFonts.sourceSansPro(
                      //             color: Colors.white, fontSize: 16),
                      //       ),
                      //       color: AppColors.kOrange,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ));
              },
              icon: Icon(
                Icons.info_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: Obx(() => chatController.loading.value
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.kOrange,
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: StreamBuilder(
                    stream: databaseRef
                        .child("messages")
                        .child(widget.messageId)
                        .child("msgs")
                        .orderByChild("timestamp")
                        .onValue,
                    builder: (context, AsyncSnapshot<Event> snap) {
                      if (snap.hasData) {
                        DataSnapshot dataValues = snap.data!.snapshot;
                        if (dataValues.value != null) {
                          Map<dynamic, dynamic> values = dataValues.value;
                          print(values);
                          list.clear();
                          values.forEach((key, values) {
                            list.insert(
                                0, messageItemFromJson(jsonEncode(values)));
                          });
                        }
                        return list.length == 0
                            ? SizedBox()
                            : ListView.separated(
                                padding: EdgeInsets.all(16),
                                itemCount: list.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return list[index].userId ==
                                          authController.user.value.userId
                                      ? senderBox(list[index])
                                      : receiverBox(list[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 16,
                                  );
                                },
                              );
                      } else {
                        return loading();
                      }
                    },
                  ),
                )),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          cursorColor: AppColors.kOrange,
                          maxLength: 256,
                          controller: controller,
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          showCursor: true,
                          onChanged: (val) {
                            HapticFeedback.lightImpact();
                          },
                          onSubmitted: (val) {
                            HapticFeedback.mediumImpact();
                            if (widget.event) {
                              if (val.trim().length != 0) {
                                sendMessage(val, widget.messageId);
                              }
                            } else {
                              if (val.trim().length != 0) {
                                sendPersonalMessage(
                                    val, widget.messageId, "msg");
                              }
                            }
                            controller.clear();
                          },
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.kOrange),
                                borderRadius: BorderRadius.circular(40)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.kOrange),
                                borderRadius: BorderRadius.circular(40)),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: true,
                            counterText: "",
                            fillColor: AppColors.lightGrey,
                            hintText: "Type here",
                            hintStyle: GoogleFonts.sourceSansPro(
                                color: AppColors.kOrange),
                            contentPadding: EdgeInsets.only(left: 12),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          if (widget.event) {
                            if (controller.text.trim().length != 0) {
                              sendMessage(controller.text, widget.messageId);
                            }
                          } else {
                            if (controller.text.trim().length != 0) {
                              sendPersonalMessage(
                                  controller.text, widget.messageId, "msg");
                            }
                          }
                          controller.clear();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: AppColors.kOrange,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
    );
  }

  Widget senderBox(MessageItem messageItem) {
    return Padding(
      padding: messageItem.type == "event"
          ? EdgeInsets.only(left: 16)
          : EdgeInsets.only(left: Get.width / 2.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          messageItem.type == "event"
              ? eventShare(messageItem)
              : messageItem.type == "groupon"
                  ? grouponShare(messageItem)
                  : messageItem.type == "airbnb"
                      ? airBnbShare(messageItem)
                      : Flexible(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 16.w,
                                    right: 10.w,
                                    top: 10.h,
                                    bottom: 10.h),
                                child: Text(
                                  messageItem.msg!,
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white, fontSize: 15),
                                ),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.shadowColor,
                                          offset: Offset(0, 4),
                                          blurRadius: 6)
                                    ],
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5.r),
                                        topLeft: Radius.circular(25.r),
                                        bottomLeft: Radius.circular(25.r),
                                        topRight: Radius.circular(25.r)),
                                    color: AppColors.kBlue),
                              ),
                              Text(
                                "${timeAgo(DateTime.fromMillisecondsSinceEpoch(messageItem.timestamp!))}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sourceSansPro(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
          SizedBox(
            width: 5,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.kBlue.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 4)
                  ],
                ),
                child: widget.event
                    ? Obx(() => homeController.userProfile.length == 0
                        ? SizedBox()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: FancyShimmerImage(
                              height: 44.h,
                              width: 44.h,
                              boxDecoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              imageUrl: homeController
                                  .userProfile[messageItem.userId]!,
                              shimmerBaseColor: AppColors.lightOrange,
                              shimmerHighlightColor: AppColors.kOrange,
                              shimmerBackColor: AppColors.lightOrange,
                              boxFit: BoxFit.cover,
                              errorWidget: Container(
                                  color: Colors.white,
                                  child: Image.asset("assets/mash_logo.png")),
                            ),
                          ))
                    : FutureBuilder<String>(
                        future: getProfile(int.parse(
                            authController.user.value.userId.toString())),
                        builder: (context, snap) {
                          return loadingCircularImage(
                              snap.hasData ? snap.data! : "", 15);
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget receiverBox(MessageItem messageItem) {
    String? name;
    homeController.userOfMashList.forEach((element) {
      if (element.chatMainUsersId == messageItem.userId) {
        name = element.fullName!;
      }
    });
    return Padding(
      padding: EdgeInsets.only(right: Get.width / 2.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.lightOrange,
                        offset: Offset(0, 4),
                        blurRadius: 4)
                  ],
                ),
                child: widget.event
                    ? Obx(() => homeController.userProfile.values.length > 0
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: FancyShimmerImage(
                              height: 44.h,
                              width: 44.h,
                              boxDecoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              imageUrl: homeController
                                          .userProfile[messageItem.userId] ==
                                      null
                                  ? ""
                                  : homeController
                                      .userProfile[messageItem.userId]!,
                              shimmerBaseColor: AppColors.lightOrange,
                              shimmerHighlightColor: AppColors.kOrange,
                              shimmerBackColor: AppColors.lightOrange,
                              boxFit: BoxFit.cover,
                              errorWidget: Container(
                                  color: Colors.white,
                                  child: Image.asset("assets/mash_logo.png")),
                            ),
                          )
                        : SizedBox())
                    : FutureBuilder<String>(
                        future: getProfile(int.parse(widget.eventImage)),
                        builder: (context, snap) {
                          return loadingCircularImage(
                              snap.hasData ? snap.data! : "", 15);
                        },
                      ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          messageItem.type == "event"
              ? eventShare(messageItem)
              : messageItem.type == "groupon"
                  ? grouponShare(messageItem)
                  : messageItem.type == "airbnb"
                      ? airBnbShare(messageItem)
                      : Flexible(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 16.w,
                                    right: 10.w,
                                    top: 10.h,
                                    bottom: 10.h),
                                child: Text(
                                  messageItem.msg!,
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white, fontSize: 15),
                                ),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.shadowColor,
                                          offset: Offset(0, 4),
                                          blurRadius: 6)
                                    ],
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5.r),
                                        topLeft: Radius.circular(25.r),
                                        bottomLeft: Radius.circular(25.r),
                                        topRight: Radius.circular(25.r)),
                                    color: AppColors.kBlue),
                              ),
                              Text(
                                "${timeAgo(DateTime.fromMillisecondsSinceEpoch(messageItem.timestamp!))}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sourceSansPro(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
        ],
      ),
    );
  }
}

Widget eventShare(MessageItem messageItem) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FutureBuilder<SingleEventDetail>(
            future: getEventByEventId(messageItem.eventId!),
            builder: (context, eventSnap) {
              if (eventSnap.hasData) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5.r),
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r)),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => SingleDetailScreen(
                          eventDetails: eventSnap.data!.data!.first));
                    },
                    child: Container(
                      height: 200,
                      width: 250,
                      child: Column(
                        children: [
                          Expanded(
                            child: loadingImage(
                              eventSnap.data!.data!.first.eventExtra!.imageUrl!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 10, top: 8, bottom: 10),
                            child: Text(
                              eventSnap.data!.data!.first.eventName!,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                offset: Offset(0, 4),
                                blurRadius: 6)
                          ],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5.r),
                              topLeft: Radius.circular(20.r),
                              bottomLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r)),
                          color: AppColors.kBlue),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kOrange,
                  ),
                );
              }
            }),
        Text(
          "${timeAgo(DateTime.fromMillisecondsSinceEpoch(messageItem.timestamp!))}",
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceSansPro(fontSize: 11),
        ),
      ],
    ),
  );
}

Widget grouponShare(MessageItem messageItem) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FutureBuilder<GrouponSingle>(
            future: getSingleGroupon(int.parse(messageItem.eventId.toString())),
            builder: (context, eventSnap) {
              if (eventSnap.hasData) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5.r),
                      topLeft: Radius.circular(15.r),
                      bottomLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r)),
                  child: InkWell(
                    onTap: () {
                      Get.to(() =>
                          SingleGrouponPage(grouponSingle: eventSnap.data!));
                    },
                    child: Container(
                      height: 200,
                      width: 250,
                      child: Column(
                        children: [
                          Expanded(
                            child: loadingImage(
                                "https://${eventSnap.data!.img!}",
                                BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 10, top: 8, bottom: 10),
                            child: Text(
                              eventSnap.data!.name!,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                offset: Offset(0, 4),
                                blurRadius: 6)
                          ],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5.r),
                              topLeft: Radius.circular(15.r),
                              bottomLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r)),
                          color: Colors.green),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kOrange,
                  ),
                );
              }
            }),
        Text(
          "${timeAgo(DateTime.fromMillisecondsSinceEpoch(messageItem.timestamp!))}",
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceSansPro(fontSize: 11),
        ),
      ],
    ),
  );
}

Widget airBnbShare(MessageItem messageItem) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FutureBuilder<SingleAirBnbData>(
            future: getAirBnb(int.parse(messageItem.eventId.toString())),
            builder: (context, eventSnap) {
              if (eventSnap.hasData) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5.r),
                      topLeft: Radius.circular(15.r),
                      bottomLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r)),
                  child: InkWell(
                    onTap: () {
                      Get.to(() =>
                          SingleAirBnbPage(singleAirBnbData: eventSnap.data!));
                    },
                    child: Container(
                      height: 200,
                      width: 250,
                      child: Column(
                        children: [
                          Expanded(
                            child: loadingImage(
                                "${eventSnap.data!.image!}", BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 10, top: 8, bottom: 10),
                            child: Text(
                              eventSnap.data!.name!,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                offset: Offset(-4, 4),
                                blurRadius: 6)
                          ],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5.r),
                              topLeft: Radius.circular(15.r),
                              bottomLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r)),
                          color: Colors.redAccent),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kOrange,
                  ),
                );
              }
            }),
        Text(
          "${timeAgo(DateTime.fromMillisecondsSinceEpoch(messageItem.timestamp!))}",
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceSansPro(fontSize: 11),
        ),
      ],
    ),
  );
}
