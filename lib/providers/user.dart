import 'package:syncapod/protos/user.pb.dart';
import 'package:syncapod/protos/google/protobuf/timestamp.pb.dart';

class UserProvider {
  User _user;

  String getUsername() => _user == null ? '' : _user.username;
  String getUserEmail() => _user == null ? '' : _user.email;
  Timestamp getUserDOB() => _user == null ? '' : _user.dOB;

  void setUser(User user) => this._user = user;
}
