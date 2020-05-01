import 'dart:convert';

import 'package:syncapod/models/podcast.dart';

class User {
  final String id;
  final String email;
  final String username;
  final DateTime dob;
  final List<Podcast> subs;

  User({
    this.id,
    this.email,
    this.username,
    this.dob,
    this.subs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'dob': dob?.toIso8601String(),
      'subs': subs?.map((x) => x?.toMap())?.toList(),
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      dob: DateTime.parse(map['dob']),
      subs: List<Podcast>.from(map['subs']?.map((x) => Podcast.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}

class UserEpisode {
  final String userID;
  final String podcastID;
  final String episodeID;
  final int offset;
  final bool played;
  final DateTime lastSeen;

  UserEpisode({
    this.userID,
    this.podcastID,
    this.episodeID,
    this.offset,
    this.played,
    this.lastSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'podcastID': podcastID,
      'episodeID': episodeID,
      'offset': offset,
      'played': played,
      'lastSeen': lastSeen.toIso8601String(),
    };
  }

  static UserEpisode fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserEpisode(
      userID: map['userID'],
      podcastID: map['podcastID'],
      episodeID: map['episodeID'],
      offset: map['offset'],
      played: map['played'],
      lastSeen:
          map['lastSeen'] == null ? null : DateTime.parse(map['lastSeen']),
    );
  }

  String toJson() => json.encode(toMap());

  static UserEpisode fromJson(String source) => fromMap(json.decode(source));
}
