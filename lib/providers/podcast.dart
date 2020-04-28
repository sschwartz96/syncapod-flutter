import 'package:flutter/material.dart';
import 'package:syncapod/models/subscription.dart';

import 'dart:convert' as json;
import 'network.dart';

class PodcastProvider extends ChangeNotifier {
  final String _baseURL = "https://syncapod.com/api/podcast/";

  Future<List<Subscription>> getSubscriptions(String token) async {
    final url = _baseURL + "subscriptions/get";
    final response = await NetworkProvider.postJSON(url, token, '');
    var subs = (json.jsonDecode(response.body) as List)
        .map((e) => Subscription.fromMap(e))
        .toList();

    return subs;
  }
}
