import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/chat_view/models/single_event_model.dart';
import 'package:mash/screens/home/API/swiped_service.dart';
import 'package:mash/screens/home/controller/home_controller.dart';
import 'package:mash/screens/home/widget/tcard.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleDetailScreen extends StatefulWidget {
  final EventDetails eventDetails;
  const SingleDetailScreen({Key? key, required this.eventDetails})
      : super(key: key);

  @override
  _SingleDetailScreenState createState() => _SingleDetailScreenState();
}

class _SingleDetailScreenState extends State<SingleDetailScreen> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventDetails.eventName!),
        backgroundColor: AppColors.kOrange,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                widget.eventDetails.eventExtra!.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.all(16.w),
                    child: RatingBar.builder(
                      initialRating: double.parse(
                          widget.eventDetails.eventExtra!.rating.toString()),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ignoreGestures: true,
                      itemSize: 25,
                      unratedColor: AppColors.lightOrange,
                      itemPadding: EdgeInsets.zero,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: AppColors.kOrange,
                      ),
                      onRatingUpdate: (rating) {},
                    )),
                Spacer(),
                IconButton(
                  onPressed: () {
                    launch("tel:${widget.eventDetails.eventExtra!.phone}");
                  },
                  icon: Icon(Icons.call),
                  color: AppColors.kOrange,
                ),
                IconButton(
                  onPressed: () {
                    launch(widget.eventDetails.eventExtra!.url!);
                  },
                  icon: Icon(Icons.link),
                  color: AppColors.kOrange,
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                infoTiles(
                    title: "# of swipes today",
                    value: "${widget.eventDetails.totalJoinedPeople}",
                    iconData: Icons.groups_outlined),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: AppColors.lightOrange,
                          onPressed: () {
                            homeController.eventId.value =
                                widget.eventDetails.eventId;
                            swipeEvent(false);
                          },
                          child: Icon(
                            Icons.close,
                            color: AppColors.kOrange,
                            size: 36,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: AppColors.kOrange,
                          onPressed: () {
                            homeController.eventId.value =
                                widget.eventDetails.eventId;
                            swipeEvent(true);
                          },
                          child: Icon(
                            Icons.done_outlined,
                            color: Colors.white,
                            size: 36,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
