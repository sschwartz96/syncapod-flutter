///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'objectID.pb.dart' as $3;
import 'google/protobuf/timestamp.pb.dart' as $4;

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('User', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOM<$3.ObjectID>(1, 'id', subBuilder: $3.ObjectID.create)
    ..aOS(2, 'email')
    ..aOS(3, 'username')
    ..aOS(4, 'password')
    ..aOM<$4.Timestamp>(5, 'DOB', protoName: 'DOB', subBuilder: $4.Timestamp.create)
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User() => create();
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  User clone() => User()..mergeFromMessage(this);
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User _defaultInstance;

  @$pb.TagNumber(1)
  $3.ObjectID get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($3.ObjectID v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
  @$pb.TagNumber(1)
  $3.ObjectID ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get password => $_getSZ(3);
  @$pb.TagNumber(4)
  set password($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPassword() => $_has(3);
  @$pb.TagNumber(4)
  void clearPassword() => clearField(4);

  @$pb.TagNumber(5)
  $4.Timestamp get dOB => $_getN(4);
  @$pb.TagNumber(5)
  set dOB($4.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDOB() => $_has(4);
  @$pb.TagNumber(5)
  void clearDOB() => clearField(5);
  @$pb.TagNumber(5)
  $4.Timestamp ensureDOB() => $_ensure(4);
}

class Subscription extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Subscription', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOM<$3.ObjectID>(1, 'id', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(2, 'userID', protoName: 'userID', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(3, 'podcastID', protoName: 'podcastID', subBuilder: $3.ObjectID.create)
    ..pc<$3.ObjectID>(4, 'completedIDs', $pb.PbFieldType.PM, protoName: 'completedIDs', subBuilder: $3.ObjectID.create)
    ..pc<$3.ObjectID>(5, 'inProgressIDs', $pb.PbFieldType.PM, protoName: 'inProgressIDs', subBuilder: $3.ObjectID.create)
    ..hasRequiredFields = false
  ;

  Subscription._() : super();
  factory Subscription() => create();
  factory Subscription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Subscription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Subscription clone() => Subscription()..mergeFromMessage(this);
  Subscription copyWith(void Function(Subscription) updates) => super.copyWith((message) => updates(message as Subscription));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Subscription create() => Subscription._();
  Subscription createEmptyInstance() => create();
  static $pb.PbList<Subscription> createRepeated() => $pb.PbList<Subscription>();
  @$core.pragma('dart2js:noInline')
  static Subscription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Subscription>(create);
  static Subscription _defaultInstance;

  @$pb.TagNumber(1)
  $3.ObjectID get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($3.ObjectID v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
  @$pb.TagNumber(1)
  $3.ObjectID ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.ObjectID get userID => $_getN(1);
  @$pb.TagNumber(2)
  set userID($3.ObjectID v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);
  @$pb.TagNumber(2)
  $3.ObjectID ensureUserID() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.ObjectID get podcastID => $_getN(2);
  @$pb.TagNumber(3)
  set podcastID($3.ObjectID v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPodcastID() => $_has(2);
  @$pb.TagNumber(3)
  void clearPodcastID() => clearField(3);
  @$pb.TagNumber(3)
  $3.ObjectID ensurePodcastID() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$3.ObjectID> get completedIDs => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$3.ObjectID> get inProgressIDs => $_getList(4);
}

class UserEpisode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserEpisode', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOM<$3.ObjectID>(1, 'id', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(2, 'userID', protoName: 'userID', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(3, 'podcastID', protoName: 'podcastID', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(4, 'episodeID', protoName: 'episodeID', subBuilder: $3.ObjectID.create)
    ..aInt64(5, 'offset')
    ..aOM<$4.Timestamp>(6, 'lastSeen', protoName: 'lastSeen', subBuilder: $4.Timestamp.create)
    ..aOB(7, 'played')
    ..hasRequiredFields = false
  ;

  UserEpisode._() : super();
  factory UserEpisode() => create();
  factory UserEpisode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserEpisode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserEpisode clone() => UserEpisode()..mergeFromMessage(this);
  UserEpisode copyWith(void Function(UserEpisode) updates) => super.copyWith((message) => updates(message as UserEpisode));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserEpisode create() => UserEpisode._();
  UserEpisode createEmptyInstance() => create();
  static $pb.PbList<UserEpisode> createRepeated() => $pb.PbList<UserEpisode>();
  @$core.pragma('dart2js:noInline')
  static UserEpisode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserEpisode>(create);
  static UserEpisode _defaultInstance;

  @$pb.TagNumber(1)
  $3.ObjectID get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($3.ObjectID v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
  @$pb.TagNumber(1)
  $3.ObjectID ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.ObjectID get userID => $_getN(1);
  @$pb.TagNumber(2)
  set userID($3.ObjectID v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);
  @$pb.TagNumber(2)
  $3.ObjectID ensureUserID() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.ObjectID get podcastID => $_getN(2);
  @$pb.TagNumber(3)
  set podcastID($3.ObjectID v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPodcastID() => $_has(2);
  @$pb.TagNumber(3)
  void clearPodcastID() => clearField(3);
  @$pb.TagNumber(3)
  $3.ObjectID ensurePodcastID() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.ObjectID get episodeID => $_getN(3);
  @$pb.TagNumber(4)
  set episodeID($3.ObjectID v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEpisodeID() => $_has(3);
  @$pb.TagNumber(4)
  void clearEpisodeID() => clearField(4);
  @$pb.TagNumber(4)
  $3.ObjectID ensureEpisodeID() => $_ensure(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get offset => $_getI64(4);
  @$pb.TagNumber(5)
  set offset($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOffset() => $_has(4);
  @$pb.TagNumber(5)
  void clearOffset() => clearField(5);

  @$pb.TagNumber(6)
  $4.Timestamp get lastSeen => $_getN(5);
  @$pb.TagNumber(6)
  set lastSeen($4.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastSeen() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastSeen() => clearField(6);
  @$pb.TagNumber(6)
  $4.Timestamp ensureLastSeen() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get played => $_getBF(6);
  @$pb.TagNumber(7)
  set played($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPlayed() => $_has(6);
  @$pb.TagNumber(7)
  void clearPlayed() => clearField(7);
}

class Session extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Session', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOM<$3.ObjectID>(1, 'id', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(2, 'userID', protoName: 'userID', subBuilder: $3.ObjectID.create)
    ..aOS(3, 'sessionKey', protoName: 'sessionKey')
    ..aOM<$4.Timestamp>(4, 'loginTime', protoName: 'loginTime', subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(5, 'lastSeenTime', protoName: 'lastSeenTime', subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(6, 'expires', subBuilder: $4.Timestamp.create)
    ..aOS(7, 'userAgent', protoName: 'userAgent')
    ..hasRequiredFields = false
  ;

  Session._() : super();
  factory Session() => create();
  factory Session.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Session.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Session clone() => Session()..mergeFromMessage(this);
  Session copyWith(void Function(Session) updates) => super.copyWith((message) => updates(message as Session));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Session create() => Session._();
  Session createEmptyInstance() => create();
  static $pb.PbList<Session> createRepeated() => $pb.PbList<Session>();
  @$core.pragma('dart2js:noInline')
  static Session getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Session>(create);
  static Session _defaultInstance;

  @$pb.TagNumber(1)
  $3.ObjectID get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($3.ObjectID v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
  @$pb.TagNumber(1)
  $3.ObjectID ensureId() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.ObjectID get userID => $_getN(1);
  @$pb.TagNumber(2)
  set userID($3.ObjectID v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);
  @$pb.TagNumber(2)
  $3.ObjectID ensureUserID() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get sessionKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set sessionKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSessionKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearSessionKey() => clearField(3);

  @$pb.TagNumber(4)
  $4.Timestamp get loginTime => $_getN(3);
  @$pb.TagNumber(4)
  set loginTime($4.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLoginTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearLoginTime() => clearField(4);
  @$pb.TagNumber(4)
  $4.Timestamp ensureLoginTime() => $_ensure(3);

  @$pb.TagNumber(5)
  $4.Timestamp get lastSeenTime => $_getN(4);
  @$pb.TagNumber(5)
  set lastSeenTime($4.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastSeenTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastSeenTime() => clearField(5);
  @$pb.TagNumber(5)
  $4.Timestamp ensureLastSeenTime() => $_ensure(4);

  @$pb.TagNumber(6)
  $4.Timestamp get expires => $_getN(5);
  @$pb.TagNumber(6)
  set expires($4.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasExpires() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpires() => clearField(6);
  @$pb.TagNumber(6)
  $4.Timestamp ensureExpires() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get userAgent => $_getSZ(6);
  @$pb.TagNumber(7)
  set userAgent($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUserAgent() => $_has(6);
  @$pb.TagNumber(7)
  void clearUserAgent() => clearField(7);
}

