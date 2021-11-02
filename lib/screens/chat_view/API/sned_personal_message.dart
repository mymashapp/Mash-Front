import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/widgets/error_snackbar.dart';

sendPersonalMessage(String text, String chatId, String type) async {
  var response = await ApiBaseHelper.post(
      WebApi.sendPersonalMessage,
      type == "event"
          ? {
              "event_id": int.parse(text),
              "chat_id": chatId,
              "type": type,
              "text": ""
            }
          : type == "groupon"
              ? {"event_id": text, "chat_id": chatId, "type": type, "text": ""}
              : type == "airbnb"
                  ? {
                      "event_id": text,
                      "chat_id": chatId,
                      "type": type,
                      "text": ""
                    }
                  : {
                      "text": text,
                      "chat_id": chatId,
                      "type": type,
                    },
      true);
  print("PERSONAL ::: ${response.statusCode}");
  print("PERSONAL ::: ${response.body}");
  if (response.statusCode == 201) {
    if (type == "event") {
      appSnackBar("Event Shared Successfully",
          "You can see the event in chat of your friend");
    } else if (type == "groupon") {
      appSnackBar("Coupon Shared Successfully",
          "You can see the event in chat of your friend");
    }
  }
}
