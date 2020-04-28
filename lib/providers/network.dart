import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Network {
  static Future<http.Response> postJSON(
      String url, String token, dynamic body) async {
    var encodedToken = '';
    if (token != '') {
      encodedToken = 'Basic ' + base64Encode(utf8.encode('$token:'));
    }
    return await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": 'application/json',
        HttpHeaders.authorizationHeader: encodedToken,
      },
    );
  }
}
