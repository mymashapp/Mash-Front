import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mash/API_handler/app_exception.dart';
import 'package:mash/configs/base_url.dart';
import 'package:mash/main.dart';

class ApiBaseHelper {
  static Future<http.Response> get(String url, bool withToken) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(WebApi.baseUrl + url),
          headers: withToken
              ? {"Authorization": "Bearer ${authController.accessToken.value}"}
              : null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  static Future<http.Response> post(
      String url, Map<String, dynamic> body, bool withToken) async {
    final http.Response response;
    try {
      print(jsonEncode(body));
      response = await http.post(Uri.parse(WebApi.baseUrl + url),
          headers: withToken
              ? {
                  'Content-Type': 'application/json',
                  "Authorization": "Bearer ${authController.accessToken.value}"
                }
              : {'Content-Type': 'application/json'},
          body: jsonEncode(body));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  static Future<http.Response> put(
      String url, Map<String, dynamic> body, bool withToken) async {
    final http.Response response;
    try {
      print(jsonEncode(body));
      response = await http.put(Uri.parse(WebApi.baseUrl + url),
          headers: withToken
              ? {
                  'Content-Type': 'application/json',
                  "Authorization": "Bearer ${authController.accessToken.value}"
                }
              : {'Content-Type': 'application/json'},
          body: jsonEncode(body));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
