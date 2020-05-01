import 'package:flutter/material.dart';
import 'package:syncapod/models/podcast.dart';

import 'dart:convert' as json;
import 'network.dart';

class PodcastProvider extends ChangeNotifier {
  final String _baseURL = "https://syncapod.com/api/podcast/";

  // Future<List<Podcast>> getSubscriptions(String token) async {
  //   final url = _baseURL + "subscriptions/get";
  //   final response = await NetworkProvider.postJSON(url, token, '');
  //   print(response.body);
  //   return (json.jsonDecode(response.body) as List)
  //       .map((e) => Podcast.fromMap(e))
  //       .toList();
  // }

  Future<List<Episode>> getEpisodes(String token, String podID) async {
    final url = _baseURL + "episodes/get/" + podID;
    final response = await NetworkProvider.postJSON(url, token, '');
    return (json.jsonDecode(response.body) as List)
        .map((e) => Episode.fromMap(e))
        .toList();
  }
}
