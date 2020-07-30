import 'package:flutter/material.dart';
import 'package:fixnum/fixnum.dart';

import 'package:syncapod/protos/podcast.pb.dart';
import 'package:syncapod/protos/user.pb.dart';
import 'package:syncapod/protos/objectID.pb.dart';
import 'package:syncapod/grpc_client.dart' as grpcClient;

class PodcastProvider extends ChangeNotifier {
  // final String _baseURL = "https://syncapod.com/api/podcast/";

  Future<Episodes> getEpisodes(
      String token, ObjectID podID, int start, int end) {
    final req = Request()
      ..token = token
      ..podcastID = podID
      ..start = start
      ..end = end;
    return grpcClient.podClient.getEpisodes(req);
  }

  // Future<List<Episode>> getEpisodes(
  //     String token, String podID, int start, int end) async {
  //   final url = _baseURL + "episodes/get/" + podID;
  //   final Map<String, dynamic> resMap = {
  //     "pod_id": podID,
  //     "start": start,
  //     "end": end
  //   };
  //   final reqJSON = json.jsonEncode(resMap);
  //   final response = await NetworkProvider.postJSON(url, token, reqJSON);
  //   final decoded = utf8.decode(response.bodyBytes);

  //   return (json.jsonDecode(decoded) as List)
  //       .map((e) => Episode.fromMap(e))
  //       .toList();
  // }

  Future<UserEpisode> getUserEpisode(
      String token, String epiID, String podID) async {
    final req = Request()
      ..token = token
      ..episodeID = (ObjectID()..hex = epiID)
      ..podcastID = (ObjectID()..hex = podID);

    return grpcClient.podClient.getUserEpisode(req);
  }
  // Future<UserEpisode> getUserEpisode(
  //     String token, String epiID, String podID) async {
  //   final url = _baseURL + "user_episode/get";
  //   final Map<String, dynamic> resMap = {
  //     "pod_id": podID,
  //     "epi_id": epiID,
  //   };
  //   final reqJSON = json.jsonEncode(resMap);
  //   final response = await NetworkProvider.postJSON(url, token, reqJSON);
  //   final decoded = utf8.decode(response.bodyBytes);
  //   // if we have errror
  //   if (decoded.contains('message')) {
  //     return null;
  //   }

  //   return UserEpisode.fromJson(decoded);
  // }

  Future<void> updateUserEpisodeOffset(
      String token, String epiID, String podID, int offset, bool played) async {
    final userEpiReq = UserEpisodeReq()
      ..token = token
      ..episodeID = (ObjectID()..hex = epiID)
      ..podcastID = (ObjectID()..hex = podID)
      ..offset = Int64(offset)
      ..played = played;

    return grpcClient.podClient.updateUserEpisode(userEpiReq);
  }

  // Future<void> updateUserEpisodeOffset(
  //     String token, String epiID, String podID, int offset) async {
  //   final url = _baseURL + "user_episode/update";
  //   final Map<String, dynamic> resMap = {
  //     "pod_id": podID,
  //     "epi_id": epiID,
  //     "offset": offset,
  //   };
  //   final reqJSON = json.jsonEncode(resMap);
  //   // final response = await NetworkProvider.postJSON(url, token, reqJSON);
  //   await NetworkProvider.postJSON(url, token, reqJSON);
  //   // final decoded = utf8.decode(response.bodyBytes);
  // }

  Future<LastPlayedRes> getLatestPlayed(String token) async {
    final req = Request()..token = token;
    return grpcClient.podClient.getUserLastPlayed(req);
  }
  // Future<LatestPlayed> getLatestPlayed(String token) async {
  //   final url = _baseURL + 'episodes/latest';
  //   final response = await NetworkProvider.postJSON(url, token, '');
  //   final decoded = utf8.decode(response.bodyBytes);
  //   return LatestPlayed.fromJson(decoded);
  // }

  Future<Subscriptions> getSubs(String token) async {
    final req = Request()..token = token;
    return grpcClient.podClient.getSubscriptions(req);
  }
  // Future<List<Podcast>> getSubs(String token) async {

  // }

}
