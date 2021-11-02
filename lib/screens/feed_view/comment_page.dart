import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/auth/API/get_profile_picture.dart';
import 'package:mash/screens/feed_view/models/post_model.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/loading_circular_image.dart';
import 'package:mash/widgets/time_ago.dart';

import 'API/add_comment.dart';
import 'API/comment_on_private_pic.dart';

class CommentPage extends StatefulWidget {
  final Iterable<Comment> comments;
  final String postId;
  final bool private;

  const CommentPage(
      {Key? key,
      required this.comments,
      required this.postId,
      required this.private})
      : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> list = <Comment>[];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kOrange,
          title: Text("Comments"),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: widget.private
                    ? databaseRef
                        .child("friends_sharing")
                        .child(widget.postId.toString())
                        .child("comments")
                        .orderByChild("timestamp")
                        .onValue
                    : databaseRef
                        .child("global_sharing")
                        .child(widget.postId)
                        .child("comments")
                        .orderByChild("timestamp")
                        .onValue,
                builder: (context, AsyncSnapshot<Event> snap) {
                  print(snap.data!.snapshot.value);
                  if (snap.hasData) {
                    DataSnapshot dataValues = snap.data!.snapshot;
                    if (dataValues.value != null) {
                      Map<dynamic, dynamic> values = dataValues.value;
                      list.clear();
                      values.forEach((key, values) {
                        list.insert(0,
                            Comment.fromJson(jsonDecode(jsonEncode(values))));
                      });
                    }
                    return ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.shadowColor,
                                        offset: Offset(2, 2),
                                        blurRadius: 10)
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<String>(
                                    future: getProfile(
                                        int.parse(list[index].userId!)),
                                    builder: (context, snap) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(2, 2),
                                                  blurRadius: 6)
                                            ]),
                                        child: loadingCircularImage(
                                            snap.hasData ? snap.data! : "", 20),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list[index].userName!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        list[index].text!,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  )),
                                  Text(
                                    timeAgo(DateTime.fromMillisecondsSinceEpoch(
                                        list[index].timestamp! * 1000)),
                                    style:
                                        TextStyle(color: Colors.blueGrey[300]),
                                  ),
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: list.length);
                  } else {
                    return loading();
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      cursorColor: AppColors.kOrange,
                      maxLength: 256,
                      controller: controller,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      showCursor: true,
                      onChanged: (val) {
                        HapticFeedback.lightImpact();
                      },
                      onSubmitted: (val) {
                        HapticFeedback.mediumImpact();
                        if (widget.private) {
                          if (controller.text.length > 0) {
                            addCommentOnPrivatePic(
                                    controller.text, widget.postId)
                                .then((value) => controller.clear());
                          } else {
                            addComment(val, widget.postId)
                                .then((value) => controller.clear());
                          }
                        }
                      },
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.kOrange),
                            borderRadius: BorderRadius.circular(40)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.kOrange),
                            borderRadius: BorderRadius.circular(40)),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: true,
                        counterText: "",
                        fillColor: AppColors.lightGrey,
                        hintText: "Add comment here...",
                        hintStyle: TextStyle(color: AppColors.kOrange),
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

                      if (controller.text.length > 0) {
                        if (widget.private) {
                          addCommentOnPrivatePic(controller.text, widget.postId)
                              .then((value) => controller.clear());
                        } else {
                          addComment(controller.text, widget.postId)
                              .then((value) => controller.clear());
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        ));
  }
}
