///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'auth.pb.dart' as $0;
export 'auth.pb.dart';

class AuthClient extends $grpc.Client {
  static final _$authenticate = $grpc.ClientMethod<$0.AuthReq, $0.AuthRes>(
      '/protos.Auth/Authenticate',
      ($0.AuthReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AuthRes.fromBuffer(value));
  static final _$authorize = $grpc.ClientMethod<$0.AuthReq, $0.AuthRes>(
      '/protos.Auth/Authorize',
      ($0.AuthReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AuthRes.fromBuffer(value));
  static final _$logout = $grpc.ClientMethod<$0.AuthReq, $0.AuthRes>(
      '/protos.Auth/Logout',
      ($0.AuthReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AuthRes.fromBuffer(value));

  AuthClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.AuthRes> authenticate($0.AuthReq request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$authenticate, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.AuthRes> authorize($0.AuthReq request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$authorize, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.AuthRes> logout($0.AuthReq request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$logout, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'protos.Auth';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AuthReq, $0.AuthRes>(
        'Authenticate',
        authenticate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AuthReq.fromBuffer(value),
        ($0.AuthRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AuthReq, $0.AuthRes>(
        'Authorize',
        authorize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AuthReq.fromBuffer(value),
        ($0.AuthRes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AuthReq, $0.AuthRes>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AuthReq.fromBuffer(value),
        ($0.AuthRes value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthRes> authenticate_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AuthReq> request) async {
    return authenticate(call, await request);
  }

  $async.Future<$0.AuthRes> authorize_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AuthReq> request) async {
    return authorize(call, await request);
  }

  $async.Future<$0.AuthRes> logout_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AuthReq> request) async {
    return logout(call, await request);
  }

  $async.Future<$0.AuthRes> authenticate(
      $grpc.ServiceCall call, $0.AuthReq request);
  $async.Future<$0.AuthRes> authorize(
      $grpc.ServiceCall call, $0.AuthReq request);
  $async.Future<$0.AuthRes> logout($grpc.ServiceCall call, $0.AuthReq request);
}
