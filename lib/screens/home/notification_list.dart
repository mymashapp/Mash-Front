import 'package:flutter/material.dart';
import 'package:mash/configs/app_colors.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kOrange,
        title: Text("Notifications"),
      ),
      body: Center(
        child: Text("No Notifications"),
      ),
    );
  }
}
