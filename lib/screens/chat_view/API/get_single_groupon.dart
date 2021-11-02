import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/screens/chat_view/models/single_groupon_model.dart';

Future<GrouponSingle> getSingleGroupon(int id) async {
  var response =
      await ApiBaseHelper.get(WebApi.getGroupon + "?groupon_id=$id", true);

  print("ID");
  print(response.statusCode);
  print(response.body);

  GrouponSingle grouponSingle =
      singleGrouponFromJson(response.body).data!.first;

  return grouponSingle;
}
