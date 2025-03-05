import 'dart:convert';

import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final bool isSuccess;
  final dynamic responseData;
  final int statusCode;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = "Something went wrong",
  });
}

class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest(String url, {bool isAuth = false}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      if (isAuth) {
        var token = await SharedPreferenceHelper.getToken();
        headers['token'] = token.toString();
      }
      Response response = await get(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);
      final decodedMessage = json.decode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedMessage,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedMessage['msg'],
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "Network error: $e",
      );
    }
  }

  Future<NetworkResponse> postRequest(String url, Map<String, dynamic> body,
      {bool isAuth = false}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      var token = await SharedPreferenceHelper.getToken();
      headers['token'] = token.toString();
      _logRequest(url, headers, body);
      Response response = await post(
        uri,
        body: json.encode(body),
        headers: headers,
      );
      _logResponse(url, response.statusCode, response.headers, response.body);
      final decodedMessage = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedMessage,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedMessage['msg'],
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "Network error: $e",
      );
    }
  }

  void _logRequest(
    String url, [
    Map<String, String>? header,
    Map<String, dynamic>? body,
  ]) {
    _logger.i(
        'Request URL => $url\nHeaders => ${header ?? 'No headers'}\nBody => ${body ?? 'No body'}');
  }

  void _logResponse(
      String url, int statusCode, Map<String, String>? header, String? body,
      [String? errorMessage]) {
    if (errorMessage != null) {
      _logger.e('Request URL => $url\nError => $errorMessage');
    } else {
      _logger.i(
          'Request URL => $url\nStatus Code => $statusCode\nHeaders => ${header ?? 'No headers'}\nBody => ${body ?? 'No body'}');
    }
  }
}
