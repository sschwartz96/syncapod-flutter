import 'package:flutter/material.dart';
import 'package:fixnum/fixnum.dart';

import 'package:syncapod/protos/podcast.pb.dart';
import 'package:syncapod/protos/podcast.pbgrpc.dart';
import 'package:syncapod/protos/user.pb.dart';
import 'package:syncapod/protos/objectID.pb.dart';
import 'package:syncapod/grpc_client.dart' as grpcClient;

class PodcastProvider extends ChangeNotifier {
  PodClient _podClient;

  PodcastProvider(String token) {
    _podClient = grpcClient.createPodClient(token);
  }

  void setToken(String token) {
    _podClient = grpcClient.createPodClient(token);
  }

  Future<Episodes> getEpisodes(
      String token, ObjectID podID, int start, int end) {
    final req = Request()
      ..podcastID = podID
      ..start = Int64(start)
      ..end = Int64(end);
    return _podClient.getEpisodes(req);
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

  Future<UserEpisode> getUserEpisode(String epiID, String podID) async {
    final req = Request()
      ..episodeID = (ObjectID()..hex = epiID)
      ..podcastID = (ObjectID()..hex = podID);

    return _podClient.getUserEpisode(req);
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
      String epiID, String podID, int offset, bool played) async {
    final userEpiReq = UserEpisodeReq()
      ..episodeID = (ObjectID()..hex = epiID)
      ..podcastID = (ObjectID()..hex = podID)
      ..offset = Int64(offset)
      ..played = played;

    return _podClient.updateUserEpisode(userEpiReq);
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
    return _podClient.getUserLastPlayed(Request());
  }
  // Future<LatestPlayed> getLatestPlayed(String token) async {
  //   final url = _baseURL + 'episodes/latest';
  //   final response = await NetworkProvider.postJSON(url, token, '');
  //   final decoded = utf8.decode(response.bodyBytes);
  //   return LatestPlayed.fromJson(decoded);
  // }

  Future<Subscriptions> getSubs() async {
    return _podClient.getSubscriptions(Request());
  }

  Future<Podcast> getPodcast(ObjectID podID) async {
    return _podClient.getPodcast(Request()..podcastID = podID);
  }
  // Future<List<Podcast>> getSubs(String token) async {

  // }

}
