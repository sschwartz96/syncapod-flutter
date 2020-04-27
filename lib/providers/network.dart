import 'package:http/http.dart' as http;
import 'dart:io';

class Network {
  static Future<http.Response> postJSON(
          String url, String token, dynamic body) async =>
      await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
      );
}
