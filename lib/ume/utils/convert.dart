import 'dart:convert';

import 'package:dio/dio.dart';

String convertToCurl(RequestOptions options) {
  // Base URL
  String url = options.baseUrl;

  // Path
  if (options.path.isNotEmpty) {
    url += options.path;
  }

  // Query parameters
  if (options.queryParameters.isNotEmpty) {
    url += '?${Uri(queryParameters: options.queryParameters).query}';
  }

  // Headers
  String headers = '';
  if (options.headers.isNotEmpty) {
    options.headers.forEach((key, value) {
      headers += '-H "$key: $value" ';
    });
  }

  // Request method
  String method = options.method.toUpperCase();

  // Request body
  String body = '';
  if (options.data != null) {
    if (options.data is FormData) {
      FormData formData = options.data as FormData;
      formData.fields.forEach((field) {
        body += '-F "${field.key}=${field.value}" ';
      });
    } else {
      String jsonData = jsonEncode(options.data);
      body = '-d \'$jsonData\'';
    }
  }

  // Combine all parts into a curl command
  String curlCommand = 'curl -X $method $headers $body $url';

  return curlCommand;
}

String convertToAesDecode(Response response){
  String aesDecode = '${response.requestOptions.baseUrl}${response.requestOptions.path}\n${response.toString()}';
  return aesDecode;
}


String convertToError(DioException err) {
  String error = '';
  String? data = err.response?.data.toString();
  error = '${err.requestOptions.baseUrl}${err.requestOptions.path}\n$data';
  return error;
}