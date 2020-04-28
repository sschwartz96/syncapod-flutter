import 'dart:convert' as json;
import 'package:flutter/material.dart';
import 'network.dart';
import 'storage.dart';

class Auth extends ChangeNotifier {
  static const _baseURL = "https://syncapod.com/api/auth/";
  bool wrongPassword = false;

  Future<bool> isAuthorized(Storage storage) async {
    // get access token
    final token = await storage.read(Storage.key_access_token);
    final username = await storage.read(Storage.key_username);
    if (token == null) {
      print('no token');
      return false;
    }
    // send off to server and return value
    final url = _baseURL + 'authorize/';
    final reqBody = json.jsonEncode({"token": token});
    final response = await Network.postJSON(url, token, reqBody);
    final resBody = json.jsonDecode(response.body);

    if (resBody['valid'] && resBody['user']['username'] == username) {
      return true;
    }

    return false;
  }

  Future<bool> authenticate(
      Storage storage, String username, String password) async {
    final url = _baseURL + 'authenticate/';
    final map = {"email": username, "password": password, "expires": false};
    final reqBody = json.jsonEncode(map);
    final response = await Network.postJSON(url, '', reqBody);
    final resBody = json.jsonDecode(response.body);

    if (resBody['authenticated'] == true) {
      storage.insert(Storage.key_access_token, resBody['access_token']);
      storage.insert(Storage.key_username, resBody['user']['username']);
      storage.insert(Storage.key_email, resBody['user']['email']);
      wrongPassword = false;
      notifyListeners();
      return true;
    }

    wrongPassword = true;
    notifyListeners();
    return false;
  }

  void logout(Storage storage) async {
    final token = await storage.read(Storage.key_access_token);
    final url = _baseURL + "logout/";
    print("sending token $token off to delete");
    final response = await Network.postJSON(url, token, '');
    print("logout response: ${response.body}");

    await storage.delete(Storage.key_access_token);
    storage.delete(Storage.key_username);
    storage.delete(Storage.key_email);
    notifyListeners();
  }
}
