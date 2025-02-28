import 'dart:convert';

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

  Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(uri);
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        final decodedMessage = json.decode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedMessage,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
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

  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      _logRequest(url, headers, body);
      Response response = await post(
        uri,
        body: json.encode(body),
        headers: headers,
      );
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        final decodedMessage = json.decode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedMessage,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
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
