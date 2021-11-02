import 'package:mash/API_handler/api_base_handler.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';
import 'package:mash/screens/home/API/get_user_location.dart';

updateUserLocation(bool status) async {
  if (!testing) await getUserLocation();
  var response = await ApiBaseHelper.put(
      WebApi.updateUserLocation,
      testing
          ? {
              "cordinates": {"lat": 23.022505, "lon": 72.571365},
              "status": status ? 1 : 0
            }
          : {
              "cordinates": {
                "lat": authController.lat.value,
                "lon": authController.lon.value
              },
              "status": status ? 1 : 0
            },
      true);
  print("LOCATION ::: ${response.statusCode}");
  print("LOCATION ::: ${response.body}");
}
