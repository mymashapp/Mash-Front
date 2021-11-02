// import 'package:firebase_core/firebase_core.dart';

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/chat_view/API/chat_opened.dart';
import 'package:mash/screens/chat_view/API/get_chat_users.dart';
import 'package:mash/screens/chat_view/chat_view.dart';
import 'package:mash/screens/chat_view/controller/chat_controller.dart';
import 'package:mash/screens/chat_view/models/chat_users_model.dart';
import 'package:mash/screens/chat_view/models/direct_chat_model.dart';
import 'package:mash/screens/home/API/get_user_from_chat_id.dart';
import 'package:mash/widgets/shimmer_loader.dart';
import 'package:mash/widgets/spacers.dart';
import 'package:mash/widgets/user_profile.dart';

class ChatUserScreen extends StatefulWidget {
  const ChatUserScreen({Key? key}) : super(key: key);

  @override
  _ChatUserScreenState createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final databaseRef = FirebaseDatabase.instance.reference();
  ScrollController scrollController = ScrollController();
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    chatController.chatUserList.clear();
    chatController.currentPage.value = 1;
    chatController.lastPage.value = false;
    getChatUsers();
    scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.9 * scrollController.position.maxScrollExtent;
        if (scrollController.position.pixels > triggerFetchMoreSize &&
            !chatController.bottomLoader.value) {
          if (!chatController.lastPage.value) {
            chatController.bottomLoader.value = true;
            if (chatController.currentTab.value == 0) {
              getChatUsers();
            } else {
              getPrivateChatUsers();
            }
          }
        }
      });
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: 90,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(2, 2),
                blurRadius: 10)
          ]),
          padding: EdgeInsets.only(top: 50),
          child: TabBar(
              indicatorColor: AppColors.kOrange,
              physics: BouncingScrollPhysics(),
              controller: tabController,
              onTap: (index) {
                chatController.currentTab.value = index;
                HapticFeedback.mediumImpact();
                if (index == 0) {
                  chatController.currentPage.value = 1;
                  chatController.chatUserList.clear();
                  getChatUsers();
                } else {
                  chatController.currentPage.value = 1;
                  chatController.direct.clear();
                  getPrivateChatUsers();
                }
              },
              tabs: [
                Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                      "Mash",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 18,
                        color: AppColors.kOrange,
                      ),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Text("Direct",
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 18, color: AppColors.kOrange),
                        textAlign: TextAlign.center)),
              ]),
        ),
        Expanded(
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                Obx(() => chatController.loading.value &&
                        !chatController.bottomLoader.value
                    ? chatCardLoading()
                    : chatController.chatUserList.length > 0
                        ? ListView.separated(
                            controller: scrollController,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, i) {
                              return y16;
                            },
                            padding: EdgeInsets.all(16),
                            itemCount: chatController.chatUserList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              ChatUsersModel chatUser =
                                  chatController.chatUserList[i];
                              return Column(
                                children: [
                                  ChatCard(chatUsersModel: chatUser),
                                  chatController.bottomLoader.value &&
                                          chatController.chatUserList.length -
                                                  1 ==
                                              i
                                      ? chatCardLoading()
                                      : SizedBox()
                                ],
                              );
                            })
                        : Center(
                            child: Text(
                              "No Chats",
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 20, color: AppColors.kOrange),
                            ),
                          )),
                Obx(() => chatController.loading.value &&
                        !chatController.bottomLoader.value
                    ? chatCardLoading()
                    : chatController.direct.length > 0
                        ? ListView.separated(
                            controller: scrollController,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, i) {
                              return y16;
                            },
                            padding: EdgeInsets.all(16),
                            itemCount: chatController.direct.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              Direct chatUser = chatController.direct[i];
                              return Column(
                                children: [
                                  ChatCard2(chatUsersModel: chatUser),
                                  chatController.bottomLoader.value &&
                                          chatController.chatUserList.length -
                                                  1 ==
                                              i
                                      ? chatCardLoading()
                                      : SizedBox()
                                ],
                              );
                            })
                        : Center(
                            child: Text(
                              "No Chats",
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 20, color: AppColors.kOrange),
                            ),
                          )),
              ]),
        )
      ],
    );
  }

  Widget chatCardLoading() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, i) {
          return y16;
        },
        padding: EdgeInsets.all(16),
        itemCount: 7,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.lightOrange,
                borderRadius: BorderRadius.circular(12.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                shimmerLoadingCard(height: 50, width: 50, radius: 120.r),
                SizedBox(
                  width: 10,
                ),
                shimmerLoadingCard(height: 50, width: 50, radius: 120.r),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    shimmerLoadingCard(height: 15),
                    SizedBox(
                      height: 5,
                    ),
                    shimmerLoadingCard(height: 10)
                  ],
                )),
                SizedBox(
                  width: 5,
                ),
                shimmerLoadingCard(height: 30, width: 70)
              ],
            ),
          );
        });
  }
}

class ChatCard extends StatefulWidget {
  final ChatUsersModel chatUsersModel;
  const ChatCard({Key? key, required this.chatUsersModel}) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(2, 2),
                blurRadius: 8)
          ],
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.lightOrange),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.kOrange.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            chatOpenedService(widget.chatUsersModel.chatMainId!);
            getUsersFromChatId(widget.chatUsersModel.chatMainId!);
            Get.to(() => ChatView(
                  messageId: widget.chatUsersModel.chatMainId!,
                  eventName: widget.chatUsersModel.eventExtra!.name!,
                  event: true,
                  eventImage: widget.chatUsersModel.eventExtra!.imageUrl!,
                ));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
                future: databaseRef
                    .child("messages")
                    .child(widget.chatUsersModel.chatMainId!)
                    .child("msgs")
                    .orderByChild("timestamp")
                    .once(),
                builder: (context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    DataSnapshot data = snap.data;
                    Map<String, dynamic>? dataMap =
                        jsonDecode(jsonEncode(data.value));
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.chatUsersModel.eventExtra!.imageUrl!),
                          radius: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.chatUsersModel.eventExtra!.name!,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 18,
                                  color: AppColors.kOrange,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              dataMap != null
                                  ? Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(dataMap.values.last["text"]),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        dataMap != null
                            ? dataMap.values.last["user_id"] !=
                                    authController.user.value.userId
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.kBlue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 5),
                                    child: Text(
                                      "Your Move",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white),
                                    ),
                                  )
                                : SizedBox()
                            : SizedBox()
                      ],
                    );
                  } else {
                    return singleLoader();
                  }
                }),
          ),
        ),
      ),
    );
  }
}

Widget singleLoader() {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: AppColors.lightOrange,
        borderRadius: BorderRadius.circular(12.r)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        shimmerLoadingCard(height: 50, width: 50, radius: 120.r),
        SizedBox(
          width: 10,
        ),
        shimmerLoadingCard(height: 50, width: 50, radius: 120.r),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            shimmerLoadingCard(height: 15),
            SizedBox(
              height: 5,
            ),
            shimmerLoadingCard(height: 10)
          ],
        )),
        SizedBox(
          width: 5,
        ),
        shimmerLoadingCard(height: 30, width: 70)
      ],
    ),
  );
}

class ChatCard2 extends StatefulWidget {
  final Direct chatUsersModel;
  const ChatCard2({Key? key, required this.chatUsersModel}) : super(key: key);

  @override
  _ChatCard2State createState() => _ChatCard2State();
}

class _ChatCard2State extends State<ChatCard2> {
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor,
                offset: Offset(2, 2),
                blurRadius: 8)
          ],
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.lightOrange),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.kOrange.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            chatOpenedService(widget.chatUsersModel.usersFriendsListChatId!);
            print(widget.chatUsersModel.usersFriendsListUserId.toString());
            Get.to(() => ChatView(
                  messageId: widget.chatUsersModel.usersFriendsListChatId!,
                  eventName: widget.chatUsersModel.fullName!,
                  event: false,
                  eventImage:
                      widget.chatUsersModel.usersFriendsListFriendId.toString(),
                ));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
                future: databaseRef
                    .child("messages")
                    .child(widget.chatUsersModel.usersFriendsListChatId!)
                    .child("msgs")
                    .orderByChild("timestamp")
                    .once(),
                builder: (context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    DataSnapshot data = snap.data;
                    Map<String, dynamic>? dataMap =
                        jsonDecode(jsonEncode(data.value));
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        userProfile(
                            widget.chatUsersModel.usersFriendsListFriendId
                                .toString(),
                            25),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.chatUsersModel.fullName!,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 18,
                                  color: AppColors.kOrange,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              dataMap == null
                                  ? SizedBox()
                                  : Text(dataMap.values.last["type"] == "event"
                                      ? "Shared an event"
                                      : dataMap.values.last["type"] ==
                                                  "groupon" ||
                                              dataMap.values.last["type"] ==
                                                  "airbnb"
                                          ? "Shared on coupon"
                                          : dataMap.values.last["text"])
                            ],
                          ),
                        ),
                        dataMap != null
                            ? dataMap.values.last["user_id"] !=
                                    authController.user.value.userId
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.kBlue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 5),
                                    child: Text(
                                      "Your Move",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white),
                                    ),
                                  )
                                : SizedBox()
                            : SizedBox()
                      ],
                    );
                  } else {
                    return singleLoader();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
