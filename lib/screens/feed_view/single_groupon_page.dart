import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/chat_view/models/single_groupon_model.dart';
import 'package:mash/screens/home/widget/tcard.dart';
import 'package:mash/widgets/loading_circular_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleGrouponPage extends StatefulWidget {
  final GrouponSingle grouponSingle;
  const SingleGrouponPage({Key? key, required this.grouponSingle})
      : super(key: key);

  @override
  _SingleGrouponPageState createState() => _SingleGrouponPageState();
}

class _SingleGrouponPageState extends State<SingleGrouponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kOrange,
        title: Text(widget.grouponSingle.name!),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: loadingImage(
                  "https://${widget.grouponSingle.img}", BoxFit.cover),
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: RatingBar.builder(
                      initialRating:
                          double.parse(widget.grouponSingle.rating.toString()),
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

                // IconButton(
                //   onPressed: () {
                //     launch("tel:${widget.eventDetails.eventExtra!.phone}");
                //   },
                //   icon: Icon(Icons.call),
                //   color: AppColors.kOrange,
                // ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.grouponSingle.st!,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                infoTiles(
                    title: "# of swipes today",
                    value: "${0}",
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
                          color: AppColors.kOrange,
                          onPressed: () {
                            launch(widget.grouponSingle.link!);
                          },
                          child: Text(
                            "Redeem",
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
