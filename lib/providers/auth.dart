import 'dart:convert' as json;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncapod/models/user.dart';
import 'network.dart';
import 'storage.dart';

class AuthProvider extends ChangeNotifier {
  static const _baseURL = "https://syncapod.com/api/auth/";

  Future<User> isAuthorized(StorageProvider storage) async {
    // get access token
    final token = await storage.read(StorageProvider.key_access_token);
    final username = await storage.read(StorageProvider.key_username);
    if (token == null) {
      print('no token');
      return null;
    }
    // send off to server and return value
    final url = _baseURL + 'authorize/';
    final reqBody = json.jsonEncode({"token": token});
    final response = await NetworkProvider.postJSON(url, token, reqBody);

    final resBody = json.jsonDecode(utf8.decode(response.bodyBytes));

    if (!resBody['valid'] || resBody['user']['username'] != username) {
      print('this should never happen, token doesn\'t match saved username');
      return null;
    }

    return User.fromMap(resBody['user']);
  }

  Future<bool> authenticate(
      StorageProvider storage, String username, String password) async {
    final url = _baseURL + 'authenticate/';
    final map = {"email": username, "password": password, "expires": false};
    final reqBody = json.jsonEncode(map);
    final response = await NetworkProvider.postJSON(url, '', reqBody);
    final resBody = json.jsonDecode(response.body);

    if (resBody['authenticated'] == true) {
      storage.insert(StorageProvider.key_access_token, resBody['access_token']);
      storage.insert(StorageProvider.key_username, resBody['user']['username']);
      storage.insert(StorageProvider.key_email, resBody['user']['email']);
      notifyListeners();
      return true;
    }

//    notifyListeners();
    return false;
  }

  void logout(StorageProvider storage) async {
    final token = await storage.read(StorageProvider.key_access_token);
    final url = _baseURL + "logout/";
    print("sending token $token off to delete");
    final response = await NetworkProvider.postJSON(url, token, '');
    print("logout response: ${response.body}");

    await storage.delete(StorageProvider.key_access_token);
    storage.delete(StorageProvider.key_username);
    storage.delete(StorageProvider.key_email);
    notifyListeners();
  }
}
