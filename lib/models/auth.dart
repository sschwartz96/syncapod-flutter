import 'package:flutter/material.dart';
import 'storage.dart';

class Auth extends ChangeNotifier {
  Future<bool> isAuthorized(Storage storage) async {
    // get access token
    final token = await storage.getAccessToken();
    if (token == null) {
      print('no token');
      return false;
    }
    print('we have token: $token, waiting 1 sec');
    // send off to server and return value
    // TODO: add networking
    // simple mock
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  Future<bool> authenticate(
      Storage storage, String username, String password) async {
    // TODO: add networking
    storage.insertAccessToken('testToken');
    notifyListeners();
    return true;
  }

  void logout(Storage storage) async {
    // TODO: add remove token from online database
    print('loggin out');
    storage.removeAccessToken();
    notifyListeners();
  }
}
