import 'package:mash/screens/home/model/air_bnb_model.dart';
import 'package:mash/screens/home/model/all_event_model.dart';
import 'package:mash/screens/home/model/groupon_model.dart';

class MixEventModel {
  Event? event;
  AirBnb? airBnb;
  Groupon? groupon;
  String type;
  MixEventModel(
      {this.event, this.airBnb, required this.type, required this.groupon});
}
