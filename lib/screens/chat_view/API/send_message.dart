import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';

sendMessage(String text, String chatId) async {
  var response = await ApiBaseHelper.post(
      WebApi.sendMessage,
      {
        "text": text,
        "chat_id": chatId,
        "type": "msg",
      },
      true);
  print(response.statusCode);
  print(response.body);
}
