import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/chat_view/models/air_bnb_model.dart';

Future<SingleAirBnbData> getAirBnb(int id) async {
  var response = await ApiBaseHelper.get(WebApi.getAirBnb + "?ab_id=$id", true);

  print("ID");
  print(response.statusCode);
  print(response.body);

  SingleAirBnbData airBnbData = singleAirBnbFromJson(response.body).data!.first;

  return airBnbData;
}
