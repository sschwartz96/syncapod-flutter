import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:syncapod/protos/auth.pb.dart';
import 'package:syncapod/grpc_client.dart' as grpcClient;
import 'package:syncapod/protos/auth.pbgrpc.dart';
import 'storage.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _authClient = grpcClient.createAuthClient();
  }
  AuthClient _authClient;

  Future<AuthRes> authorize(StorageProvider storage) async {
    // get access token
    final token = await storage.read(StorageProvider.key_access_token);
    final username = await storage.read(StorageProvider.key_username);
    if (token == null) {
      print('no token');
      return null;
    }

    // create our request
    final authReq = AuthReq()
      ..username = username
      ..sessionKey = token;

    // send off to server and return value
    return _authClient.authorize(authReq);
  }

  Future<bool> authenticate(
      StorageProvider storage, String username, String password) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final request = AuthReq()
      ..username = username
      ..password = password
      ..userAgent = "flutterApp.v:" + packageInfo.version;

    final res = await _authClient.authenticate(request);

    // succesfully logged in
    if (res.user != null && res.sessionKey.length > 0) {
      storage.insert(StorageProvider.key_email, res.user.email);
      storage.insert(StorageProvider.key_username, res.user.username);
      storage.insert(StorageProvider.key_access_token, res.sessionKey);
      // to send update to consumer and to show the home page
      notifyListeners();
    }
    return res.success;
  }

  void logout(StorageProvider storage) async {
    final token = await storage.read(StorageProvider.key_access_token);

    _authClient.logout(AuthReq()..sessionKey = token).catchError((obj) {
      print("could not logout: $obj");
    });

    await storage.delete(StorageProvider.key_access_token);
    storage.delete(StorageProvider.key_username);
    storage.delete(StorageProvider.key_email);
    notifyListeners();
  }
}
