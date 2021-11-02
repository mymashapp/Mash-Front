import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/screens/chat_view/models/single_event_model.dart';

Future<SingleEventDetail> getEventByEventId(int eventId) async {
  var response;
  try {
    response = await ApiBaseHelper.get(
        "event?limit=1&event_id=$eventId&ignore_user_specific=true&ignore_swipes=true",
        true);
    print(response.statusCode);
    print(response.body);
    SingleEventDetail singleEventDetail =
        singleEventDetailFromJson(response.body);
  } catch (e) {
    print(e.toString());
  } finally {
    return singleEventDetailFromJson(response.body);
  }
}
