import 'package:flutter/material.dart';
import 'package:mash/configs/app_colors.dart';

class MashPointFAQ extends StatefulWidget {
  const MashPointFAQ({Key? key}) : super(key: key);

  @override
  _MashPointFAQState createState() => _MashPointFAQState();
}

class _MashPointFAQState extends State<MashPointFAQ> {
  List<Map<String, String>> faq = [
    {
      "title": "Mash Meetup Happens",
      "points": "10",
      "crt": 'All Parties hit "Yes" to Did Mashup Happen Question'
    },
    {"title": "5 meetups in a calendar month", "points": "100", "crt": ''},
    {"title": "10 meetups in a calendar month", "points": "200", "crt": ''},
    {
      "title": "Upload photo",
      "points": "5",
      "crt": 'Upload photo on Mash platform'
    },
    {
      "title": "Refer a friend",
      "points": "5",
      "crt": 'Referred friend downloads app'
    },
    {
      "title": "Refer 5 friends",
      "points": "40",
      "crt": 'Referred 5 friends download app with counter'
    },
    {
      "title": "Refer 10 friends",
      "points": "100",
      "crt": 'Referred 10 friends download app with counter'
    },
    {
      "title": "Create your own Event",
      "points": "5",
      "crt": 'Mash on "Create your own Event"'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Mash Points FAQ"),
        backgroundColor: AppColors.kOrange,
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(4, 4),
                          blurRadius: 6)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          faq[index]["title"]!,
                          style: TextStyle(
                              color: AppColors.kOrange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              faq[index]["points"]!,
                              style: TextStyle(
                                  color: AppColors.kOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Text(
                              "Points",
                              style: TextStyle(
                                  color: AppColors.kBlue, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                    faq[index]["crt"]!.length > 0
                        ? Text(faq[index]["crt"]!)
                        : SizedBox(),
                  ],
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: faq.length),
    );
  }
}
