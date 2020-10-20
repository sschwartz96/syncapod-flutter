///
//  Generated code. Do not modify.
//  source: podcast.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'podcast.pb.dart' as $1;
import 'user.pb.dart' as $2;
export 'podcast.pb.dart';

class PodClient extends $grpc.Client {
  static final _$getPodcast = $grpc.ClientMethod<$1.Request, $1.Podcast>(
      '/protos.Pod/GetPodcast',
      ($1.Request value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Podcast.fromBuffer(value));
  static final _$getEpisodes = $grpc.ClientMethod<$1.Request, $1.Episodes>(
      '/protos.Pod/GetEpisodes',
      ($1.Request value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Episodes.fromBuffer(value));
  static final _$getUserEpisode =
      $grpc.ClientMethod<$1.Request, $2.UserEpisode>(
          '/protos.Pod/GetUserEpisode',
          ($1.Request value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UserEpisode.fromBuffer(value));
  static final _$updateUserEpisode =
      $grpc.ClientMethod<$1.UserEpisodeReq, $1.Response>(
          '/protos.Pod/UpdateUserEpisode',
          ($1.UserEpisodeReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Response.fromBuffer(value));
  static final _$getSubscriptions =
      $grpc.ClientMethod<$1.Request, $1.Subscriptions>(
          '/protos.Pod/GetSubscriptions',
          ($1.Request value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Subscriptions.fromBuffer(value));
  static final _$getUserLastPlayed =
      $grpc.ClientMethod<$1.Request, $1.LastPlayedRes>(
          '/protos.Pod/GetUserLastPlayed',
          ($1.Request value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.LastPlayedRes.fromBuffer(value));

  PodClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$1.Podcast> getPodcast($1.Request request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getPodcast, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.Episodes> getEpisodes($1.Request request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getEpisodes, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$2.UserEpisode> getUserEpisode($1.Request request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getUserEpisode, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.Response> updateUserEpisode($1.UserEpisodeReq request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$updateUserEpisode, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.Subscriptions> getSubscriptions($1.Request request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getSubscriptions, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$1.LastPlayedRes> getUserLastPlayed($1.Request request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getUserLastPlayed, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class PodServiceBase extends $grpc.Service {
  $core.String get $name => 'protos.Pod';

  PodServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.Request, $1.Podcast>(
        'GetPodcast',
        getPodcast_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Request.fromBuffer(value),
        ($1.Podcast value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Request, $1.Episodes>(
        'GetEpisodes',
        getEpisodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Request.fromBuffer(value),
        ($1.Episodes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Request, $2.UserEpisode>(
        'GetUserEpisode',
        getUserEpisode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Request.fromBuffer(value),
        ($2.UserEpisode value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UserEpisodeReq, $1.Response>(
        'UpdateUserEpisode',
        updateUserEpisode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UserEpisodeReq.fromBuffer(value),
        ($1.Response value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Request, $1.Subscriptions>(
        'GetSubscriptions',
        getSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Request.fromBuffer(value),
        ($1.Subscriptions value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Request, $1.LastPlayedRes>(
        'GetUserLastPlayed',
        getUserLastPlayed_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Request.fromBuffer(value),
        ($1.LastPlayedRes value) => value.writeToBuffer()));
  }

  $async.Future<$1.Podcast> getPodcast_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Request> request) async {
    return getPodcast(call, await request);
  }

  $async.Future<$1.Episodes> getEpisodes_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Request> request) async {
    return getEpisodes(call, await request);
  }

  $async.Future<$2.UserEpisode> getUserEpisode_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Request> request) async {
    return getUserEpisode(call, await request);
  }

  $async.Future<$1.Response> updateUserEpisode_Pre(
      $grpc.ServiceCall call, $async.Future<$1.UserEpisodeReq> request) async {
    return updateUserEpisode(call, await request);
  }

  $async.Future<$1.Subscriptions> getSubscriptions_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Request> request) async {
    return getSubscriptions(call, await request);
  }

  $async.Future<$1.LastPlayedRes> getUserLastPlayed_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Request> request) async {
    return getUserLastPlayed(call, await request);
  }

  $async.Future<$1.Podcast> getPodcast(
      $grpc.ServiceCall call, $1.Request request);
  $async.Future<$1.Episodes> getEpisodes(
      $grpc.ServiceCall call, $1.Request request);
  $async.Future<$2.UserEpisode> getUserEpisode(
      $grpc.ServiceCall call, $1.Request request);
  $async.Future<$1.Response> updateUserEpisode(
      $grpc.ServiceCall call, $1.UserEpisodeReq request);
  $async.Future<$1.Subscriptions> getSubscriptions(
      $grpc.ServiceCall call, $1.Request request);
  $async.Future<$1.LastPlayedRes> getUserLastPlayed(
      $grpc.ServiceCall call, $1.Request request);
}
