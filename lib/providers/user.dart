import 'package:syncapod/models/podcast.dart';
import 'package:syncapod/models/user.dart';

class UserProvider {
  User _user;

  String getUsername() => _user == null ? '' : _user.username;
  String getUserEmail() => _user == null ? '' : _user.email;
  List<Podcast> getUserSubs() => _user == null ? '' : _user.subs;
  void setUser(User user) => this._user = user;
}
