import 'package:http/http.dart' as http;
import 'dart:convert';

String processResponse(http.Response res) {
  switch (res.statusCode) {
    case 201:
      final response = jsonDecode(res.body);
      if (response["body"] == "success") {
        return "success";
      } else {
        return 'error';
      }
    case 202:
      return "duplicado";

    case 203:
      final response = jsonDecode(res.body);
      if (response["body"] == "success") {
        return "success";
      } else {
        return "error";
      }
    case 209:
      final response = jsonDecode(res.body);
      if (response["body"] == "success") {
        return "success";
      } else {
        return "error";
      }
    case 404:
    throw Exception("Error : HTTP ${res.statusCode}");
    default:
      throw Exception("Error : HTTP ${res.statusCode}");
  }
}
