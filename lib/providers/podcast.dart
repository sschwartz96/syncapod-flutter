import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncapod/models/podcast.dart';
import 'package:syncapod/models/user.dart';

import 'dart:convert' as json;
import 'network.dart';

class PodcastProvider extends ChangeNotifier {
  final String _baseURL = "https://syncapod.com/api/podcast/";

  Future<List<Episode>> getEpisodes(
      String token, String podID, int start, int end) async {
    final url = _baseURL + "episodes/get/" + podID;
    final Map<String, dynamic> resMap = {
      "pod_id": podID,
      "start": start,
      "end": end
    };
    final reqJSON = json.jsonEncode(resMap);
    final response = await NetworkProvider.postJSON(url, token, reqJSON);
    final decoded = utf8.decode(response.bodyBytes);

    return (json.jsonDecode(decoded) as List)
        .map((e) => Episode.fromMap(e))
        .toList();
  }

  Future<UserEpisode> getUserEpisode(
      String token, String epiID, String podID) async {
    final url = _baseURL + "user_episode/get";
    final Map<String, dynamic> resMap = {
      "pod_id": podID,
      "epi_id": epiID,
    };
    final reqJSON = json.jsonEncode(resMap);
    final response = await NetworkProvider.postJSON(url, token, reqJSON);
    final decoded = utf8.decode(response.bodyBytes);
    // if we have errror
    if (decoded.contains('message')) {
      return null;
    }

    return UserEpisode.fromJson(decoded);
  }

  Future<void> updateUserEpisodeOffset(
      String token, String epiID, String podID, int offset) async {
    final url = _baseURL + "user_episode/update";
    final Map<String, dynamic> resMap = {
      "pod_id": podID,
      "epi_id": epiID,
      "offset": offset,
    };
    final reqJSON = json.jsonEncode(resMap);
    final response = await NetworkProvider.postJSON(url, token, reqJSON);
    final decoded = utf8.decode(response.bodyBytes);
    print('$decoded');

    return;
  }

  Future<Episode> getLatestPlayed(String token) {}
}
