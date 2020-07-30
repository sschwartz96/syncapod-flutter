///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $2;

class AuthReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AuthReq', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOS(1, 'username')
    ..aOS(2, 'password')
    ..aOS(3, 'sessionKey', protoName: 'sessionKey')
    ..aOS(4, 'userAgent', protoName: 'userAgent')
    ..aOB(5, 'stayLoggedIn', protoName: 'stayLoggedIn')
    ..hasRequiredFields = false
  ;

  AuthReq._() : super();
  factory AuthReq() => create();
  factory AuthReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AuthReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AuthReq clone() => AuthReq()..mergeFromMessage(this);
  AuthReq copyWith(void Function(AuthReq) updates) => super.copyWith((message) => updates(message as AuthReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AuthReq create() => AuthReq._();
  AuthReq createEmptyInstance() => create();
  static $pb.PbList<AuthReq> createRepeated() => $pb.PbList<AuthReq>();
  @$core.pragma('dart2js:noInline')
  static AuthReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuthReq>(create);
  static AuthReq _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sessionKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set sessionKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSessionKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearSessionKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userAgent => $_getSZ(3);
  @$pb.TagNumber(4)
  set userAgent($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserAgent() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserAgent() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get stayLoggedIn => $_getBF(4);
  @$pb.TagNumber(5)
  set stayLoggedIn($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStayLoggedIn() => $_has(4);
  @$pb.TagNumber(5)
  void clearStayLoggedIn() => clearField(5);
}

class AuthRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AuthRes', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'sessionKey', protoName: 'sessionKey')
    ..aOM<$2.User>(15, 'user', subBuilder: $2.User.create)
    ..hasRequiredFields = false
  ;

  AuthRes._() : super();
  factory AuthRes() => create();
  factory AuthRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AuthRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AuthRes clone() => AuthRes()..mergeFromMessage(this);
  AuthRes copyWith(void Function(AuthRes) updates) => super.copyWith((message) => updates(message as AuthRes));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AuthRes create() => AuthRes._();
  AuthRes createEmptyInstance() => create();
  static $pb.PbList<AuthRes> createRepeated() => $pb.PbList<AuthRes>();
  @$core.pragma('dart2js:noInline')
  static AuthRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuthRes>(create);
  static AuthRes _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionKey() => clearField(2);

  @$pb.TagNumber(15)
  $2.User get user => $_getN(2);
  @$pb.TagNumber(15)
  set user($2.User v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(15)
  void clearUser() => clearField(15);
  @$pb.TagNumber(15)
  $2.User ensureUser() => $_ensure(2);
}

