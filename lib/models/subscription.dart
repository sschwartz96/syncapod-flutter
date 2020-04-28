import 'dart:convert';

import 'package:syncapod/models/podcast.dart';
import 'package:syncapod/models/user.dart';

class Subscription {
  final String id;
  final String userID;
  final Podcast podcast;
  final Episode curEpi;
  final UserEpisode curEpiDetails;
  final List<String> playedIDs;

  Subscription({
    this.id,
    this.userID,
    this.podcast,
    this.curEpi,
    this.curEpiDetails,
    this.playedIDs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userID,
      'podcast': podcast?.toMap(),
      'cur_epi': curEpi?.toMap(),
      'cur_epi_details': curEpiDetails?.toMap(),
      'played_ids': playedIDs,
    };
  }

  static Subscription fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Subscription(
      id: map['_id'],
      userID: map['user_id'],
      podcast: Podcast.fromMap(map['podcast']),
      curEpi: Episode.fromMap(map['cur_epi']),
      curEpiDetails: UserEpisode.fromMap(map['cur_epi_details']),
      playedIDs: map['played_ids'] == null
          ? null
          : List<String>.from(map['played_ids']),
    );
  }

  String toJson() => json.encode(toMap());

  static Subscription fromJson(String source) => fromMap(json.decode(source));
}
