import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/screens/chat_view/models/air_bnb_model.dart';
import 'package:mash/screens/home/widget/tcard.dart';
import 'package:mash/widgets/loading_circular_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleAirBnbPage extends StatefulWidget {
  final SingleAirBnbData singleAirBnbData;
  const SingleAirBnbPage({Key? key, required this.singleAirBnbData})
      : super(key: key);

  @override
  _SingleAirBnbPageState createState() => _SingleAirBnbPageState();
}

class _SingleAirBnbPageState extends State<SingleAirBnbPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kOrange,
        title: Text(widget.singleAirBnbData.name!),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: loadingImage(
                  "https://${widget.singleAirBnbData.image}", BoxFit.cover),
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: RatingBar.builder(
                      initialRating: double.parse(
                          widget.singleAirBnbData.rating.toString()),
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
                widget.singleAirBnbData.act!,
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
                            launch(widget.singleAirBnbData.link!);
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
