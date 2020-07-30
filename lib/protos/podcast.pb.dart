///
//  Generated code. Do not modify.
//  source: podcast.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'objectID.pb.dart' as $3;
import 'google/protobuf/timestamp.pb.dart' as $4;
import 'user.pb.dart' as $2;

class Image extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Image', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOS(1, 'title')
    ..aOS(2, 'url')
    ..hasRequiredFields = false
  ;

  Image._() : super();
  factory Image() => create();
  factory Image.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Image.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Image clone() => Image()..mergeFromMessage(this);
  Image copyWith(void Function(Image) updates) => super.copyWith((message) => updates(message as Image));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Image create() => Image._();
  Image createEmptyInstance() => create();
  static $pb.PbList<Image> createRepeated() => $pb.PbList<Image>();
  @$core.pragma('dart2js:noInline')
  static Image getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Image>(create);
  static Image _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => clearField(2);
}

class Category extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Category', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOS(1, 'text')
    ..pc<Category>(2, 'category', $pb.PbFieldType.PM, subBuilder: Category.create)
    ..hasRequiredFields = false
  ;

  Category._() : super();
  factory Category() => create();
  factory Category.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Category.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Category clone() => Category()..mergeFromMessage(this);
  Category copyWith(void Function(Category) updates) => super.copyWith((message) => updates(message as Category));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Category create() => Category._();
  Category createEmptyInstance() => create();
  static $pb.PbList<Category> createRepeated() => $pb.PbList<Category>();
  @$core.pragma('dart2js:noInline')
  static Category getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Category>(create);
  static Category _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Category> get category => $_getList(1);
}

class Podcast extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Podcast', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOM<$3.ObjectID>(1, 'id', subBuilder: $3.ObjectID.create)
    ..aOS(2, 'title')
    ..aOS(3, 'author')
    ..aOS(4, 'type')
    ..aOS(5, 'subtitle')
    ..aOS(6, 'link')
    ..aOM<Image>(7, 'image', subBuilder: Image.create)
    ..aOS(8, 'explicit')
    ..aOS(9, 'language')
    ..pPS(10, 'Keywords', protoName: 'Keywords')
    ..pc<Category>(11, 'category', $pb.PbFieldType.PM, subBuilder: Category.create)
    ..aOM<$4.Timestamp>(12, 'pubDate', protoName: 'pubDate', subBuilder: $4.Timestamp.create)
    ..aOM<$4.Timestamp>(13, 'lastBuildDate', protoName: 'lastBuildDate', subBuilder: $4.Timestamp.create)
    ..aOS(14, 'rss')
    ..hasRequiredFields = false
  ;

  Podcast._() : super();
  factory Podcast() => create();
  factory Podcast.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Podcast.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Podcast clone() => Podcast()..mergeFromMessage(this);
  Podcast copyWith(void Function(Podcast) updates) => super.copyWith((message) => updates(message as Podcast));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Podcast create() => Podcast._();
  Podcast createEmptyInstance() => create();
  static $pb.PbList<Podcast> createRepeated() => $pb.PbList<Podcast>();
  @$core.pragma('dart2js:noInline')
  static Podcast getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Podcast>(create);
  static Podcast _defaultInstance;

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
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get subtitle => $_getSZ(4);
  @$pb.TagNumber(5)
  set subtitle($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSubtitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubtitle() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get link => $_getSZ(5);
  @$pb.TagNumber(6)
  set link($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLink() => $_has(5);
  @$pb.TagNumber(6)
  void clearLink() => clearField(6);

  @$pb.TagNumber(7)
  Image get image => $_getN(6);
  @$pb.TagNumber(7)
  set image(Image v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasImage() => $_has(6);
  @$pb.TagNumber(7)
  void clearImage() => clearField(7);
  @$pb.TagNumber(7)
  Image ensureImage() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get explicit => $_getSZ(7);
  @$pb.TagNumber(8)
  set explicit($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasExplicit() => $_has(7);
  @$pb.TagNumber(8)
  void clearExplicit() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get language => $_getSZ(8);
  @$pb.TagNumber(9)
  set language($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasLanguage() => $_has(8);
  @$pb.TagNumber(9)
  void clearLanguage() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.String> get keywords => $_getList(9);

  @$pb.TagNumber(11)
  $core.List<Category> get category => $_getList(10);

  @$pb.TagNumber(12)
  $4.Timestamp get pubDate => $_getN(11);
  @$pb.TagNumber(12)
  set pubDate($4.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasPubDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearPubDate() => clearField(12);
  @$pb.TagNumber(12)
  $4.Timestamp ensurePubDate() => $_ensure(11);

  @$pb.TagNumber(13)
  $4.Timestamp get lastBuildDate => $_getN(12);
  @$pb.TagNumber(13)
  set lastBuildDate($4.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasLastBuildDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearLastBuildDate() => clearField(13);
  @$pb.TagNumber(13)
  $4.Timestamp ensureLastBuildDate() => $_ensure(12);

  @$pb.TagNumber(14)
  $core.String get rss => $_getSZ(13);
  @$pb.TagNumber(14)
  set rss($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRss() => $_has(13);
  @$pb.TagNumber(14)
  void clearRss() => clearField(14);
}

class Episode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Episode', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOM<$3.ObjectID>(1, 'id', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(2, 'podcastID', protoName: 'podcastID', subBuilder: $3.ObjectID.create)
    ..aOS(3, 'title')
    ..aOS(4, 'author')
    ..aOS(5, 'type')
    ..aOM<Image>(6, 'image', subBuilder: Image.create)
    ..aOM<$4.Timestamp>(7, 'pubDate', protoName: 'pubDate', subBuilder: $4.Timestamp.create)
    ..aOS(8, 'description')
    ..aOS(9, 'summary')
    ..a<$core.int>(10, 'season', $pb.PbFieldType.O3)
    ..a<$core.int>(11, 'episode', $pb.PbFieldType.O3)
    ..pc<Category>(12, 'category', $pb.PbFieldType.PM, subBuilder: Category.create)
    ..aOS(13, 'explicit')
    ..aOS(14, 'MP3URL', protoName: 'MP3URL')
    ..aInt64(15, 'durationMillis', protoName: 'durationMillis')
    ..aOS(16, 'subtitle')
    ..hasRequiredFields = false
  ;

  Episode._() : super();
  factory Episode() => create();
  factory Episode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Episode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Episode clone() => Episode()..mergeFromMessage(this);
  Episode copyWith(void Function(Episode) updates) => super.copyWith((message) => updates(message as Episode));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Episode create() => Episode._();
  Episode createEmptyInstance() => create();
  static $pb.PbList<Episode> createRepeated() => $pb.PbList<Episode>();
  @$core.pragma('dart2js:noInline')
  static Episode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Episode>(create);
  static Episode _defaultInstance;

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
  $3.ObjectID get podcastID => $_getN(1);
  @$pb.TagNumber(2)
  set podcastID($3.ObjectID v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPodcastID() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcastID() => clearField(2);
  @$pb.TagNumber(2)
  $3.ObjectID ensurePodcastID() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get author => $_getSZ(3);
  @$pb.TagNumber(4)
  set author($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAuthor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthor() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get type => $_getSZ(4);
  @$pb.TagNumber(5)
  set type($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => clearField(5);

  @$pb.TagNumber(6)
  Image get image => $_getN(5);
  @$pb.TagNumber(6)
  set image(Image v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasImage() => $_has(5);
  @$pb.TagNumber(6)
  void clearImage() => clearField(6);
  @$pb.TagNumber(6)
  Image ensureImage() => $_ensure(5);

  @$pb.TagNumber(7)
  $4.Timestamp get pubDate => $_getN(6);
  @$pb.TagNumber(7)
  set pubDate($4.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPubDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearPubDate() => clearField(7);
  @$pb.TagNumber(7)
  $4.Timestamp ensurePubDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get summary => $_getSZ(8);
  @$pb.TagNumber(9)
  set summary($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSummary() => $_has(8);
  @$pb.TagNumber(9)
  void clearSummary() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get season => $_getIZ(9);
  @$pb.TagNumber(10)
  set season($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSeason() => $_has(9);
  @$pb.TagNumber(10)
  void clearSeason() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get episode => $_getIZ(10);
  @$pb.TagNumber(11)
  set episode($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasEpisode() => $_has(10);
  @$pb.TagNumber(11)
  void clearEpisode() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<Category> get category => $_getList(11);

  @$pb.TagNumber(13)
  $core.String get explicit => $_getSZ(12);
  @$pb.TagNumber(13)
  set explicit($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasExplicit() => $_has(12);
  @$pb.TagNumber(13)
  void clearExplicit() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get mP3URL => $_getSZ(13);
  @$pb.TagNumber(14)
  set mP3URL($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasMP3URL() => $_has(13);
  @$pb.TagNumber(14)
  void clearMP3URL() => clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get durationMillis => $_getI64(14);
  @$pb.TagNumber(15)
  set durationMillis($fixnum.Int64 v) { $_setInt64(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasDurationMillis() => $_has(14);
  @$pb.TagNumber(15)
  void clearDurationMillis() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get subtitle => $_getSZ(15);
  @$pb.TagNumber(16)
  set subtitle($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasSubtitle() => $_has(15);
  @$pb.TagNumber(16)
  void clearSubtitle() => clearField(16);
}

class Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Request', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOS(1, 'token')
    ..aOM<$3.ObjectID>(2, 'podcastID', protoName: 'podcastID', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(3, 'episodeID', protoName: 'episodeID', subBuilder: $3.ObjectID.create)
    ..a<$core.int>(4, 'start', $pb.PbFieldType.O3)
    ..a<$core.int>(5, 'end', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Request._() : super();
  factory Request() => create();
  factory Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Request clone() => Request()..mergeFromMessage(this);
  Request copyWith(void Function(Request) updates) => super.copyWith((message) => updates(message as Request));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Request create() => Request._();
  Request createEmptyInstance() => create();
  static $pb.PbList<Request> createRepeated() => $pb.PbList<Request>();
  @$core.pragma('dart2js:noInline')
  static Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Request>(create);
  static Request _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $3.ObjectID get podcastID => $_getN(1);
  @$pb.TagNumber(2)
  set podcastID($3.ObjectID v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPodcastID() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcastID() => clearField(2);
  @$pb.TagNumber(2)
  $3.ObjectID ensurePodcastID() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.ObjectID get episodeID => $_getN(2);
  @$pb.TagNumber(3)
  set episodeID($3.ObjectID v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEpisodeID() => $_has(2);
  @$pb.TagNumber(3)
  void clearEpisodeID() => clearField(3);
  @$pb.TagNumber(3)
  $3.ObjectID ensureEpisodeID() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get start => $_getIZ(3);
  @$pb.TagNumber(4)
  set start($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStart() => $_has(3);
  @$pb.TagNumber(4)
  void clearStart() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get end => $_getIZ(4);
  @$pb.TagNumber(5)
  set end($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnd() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnd() => clearField(5);
}

class UserEpisodeReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UserEpisodeReq', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOS(1, 'token')
    ..aOM<$3.ObjectID>(2, 'podcastID', protoName: 'podcastID', subBuilder: $3.ObjectID.create)
    ..aOM<$3.ObjectID>(3, 'episodeID', protoName: 'episodeID', subBuilder: $3.ObjectID.create)
    ..aInt64(4, 'offset')
    ..aOM<$4.Timestamp>(5, 'lastSeen', protoName: 'lastSeen', subBuilder: $4.Timestamp.create)
    ..aOB(6, 'played')
    ..hasRequiredFields = false
  ;

  UserEpisodeReq._() : super();
  factory UserEpisodeReq() => create();
  factory UserEpisodeReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserEpisodeReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UserEpisodeReq clone() => UserEpisodeReq()..mergeFromMessage(this);
  UserEpisodeReq copyWith(void Function(UserEpisodeReq) updates) => super.copyWith((message) => updates(message as UserEpisodeReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserEpisodeReq create() => UserEpisodeReq._();
  UserEpisodeReq createEmptyInstance() => create();
  static $pb.PbList<UserEpisodeReq> createRepeated() => $pb.PbList<UserEpisodeReq>();
  @$core.pragma('dart2js:noInline')
  static UserEpisodeReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserEpisodeReq>(create);
  static UserEpisodeReq _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $3.ObjectID get podcastID => $_getN(1);
  @$pb.TagNumber(2)
  set podcastID($3.ObjectID v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPodcastID() => $_has(1);
  @$pb.TagNumber(2)
  void clearPodcastID() => clearField(2);
  @$pb.TagNumber(2)
  $3.ObjectID ensurePodcastID() => $_ensure(1);

  @$pb.TagNumber(3)
  $3.ObjectID get episodeID => $_getN(2);
  @$pb.TagNumber(3)
  set episodeID($3.ObjectID v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEpisodeID() => $_has(2);
  @$pb.TagNumber(3)
  void clearEpisodeID() => clearField(3);
  @$pb.TagNumber(3)
  $3.ObjectID ensureEpisodeID() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get offset => $_getI64(3);
  @$pb.TagNumber(4)
  set offset($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => clearField(4);

  @$pb.TagNumber(5)
  $4.Timestamp get lastSeen => $_getN(4);
  @$pb.TagNumber(5)
  set lastSeen($4.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastSeen() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastSeen() => clearField(5);
  @$pb.TagNumber(5)
  $4.Timestamp ensureLastSeen() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.bool get played => $_getBF(5);
  @$pb.TagNumber(6)
  set played($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPlayed() => $_has(5);
  @$pb.TagNumber(6)
  void clearPlayed() => clearField(6);
}

class Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Response', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'message')
    ..hasRequiredFields = false
  ;

  Response._() : super();
  factory Response() => create();
  factory Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Response clone() => Response()..mergeFromMessage(this);
  Response copyWith(void Function(Response) updates) => super.copyWith((message) => updates(message as Response));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  Response createEmptyInstance() => create();
  static $pb.PbList<Response> createRepeated() => $pb.PbList<Response>();
  @$core.pragma('dart2js:noInline')
  static Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Response>(create);
  static Response _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class LastPlayedRes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LastPlayedRes', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOM<Podcast>(1, 'podcast', subBuilder: Podcast.create)
    ..aOM<Episode>(2, 'episode', subBuilder: Episode.create)
    ..aInt64(3, 'millis')
    ..hasRequiredFields = false
  ;

  LastPlayedRes._() : super();
  factory LastPlayedRes() => create();
  factory LastPlayedRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LastPlayedRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LastPlayedRes clone() => LastPlayedRes()..mergeFromMessage(this);
  LastPlayedRes copyWith(void Function(LastPlayedRes) updates) => super.copyWith((message) => updates(message as LastPlayedRes));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LastPlayedRes create() => LastPlayedRes._();
  LastPlayedRes createEmptyInstance() => create();
  static $pb.PbList<LastPlayedRes> createRepeated() => $pb.PbList<LastPlayedRes>();
  @$core.pragma('dart2js:noInline')
  static LastPlayedRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LastPlayedRes>(create);
  static LastPlayedRes _defaultInstance;

  @$pb.TagNumber(1)
  Podcast get podcast => $_getN(0);
  @$pb.TagNumber(1)
  set podcast(Podcast v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPodcast() => $_has(0);
  @$pb.TagNumber(1)
  void clearPodcast() => clearField(1);
  @$pb.TagNumber(1)
  Podcast ensurePodcast() => $_ensure(0);

  @$pb.TagNumber(2)
  Episode get episode => $_getN(1);
  @$pb.TagNumber(2)
  set episode(Episode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEpisode() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpisode() => clearField(2);
  @$pb.TagNumber(2)
  Episode ensureEpisode() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get millis => $_getI64(2);
  @$pb.TagNumber(3)
  set millis($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMillis() => $_has(2);
  @$pb.TagNumber(3)
  void clearMillis() => clearField(3);
}

class Subscriptions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Subscriptions', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..pc<$2.Subscription>(1, 'subscriptions', $pb.PbFieldType.PM, subBuilder: $2.Subscription.create)
    ..hasRequiredFields = false
  ;

  Subscriptions._() : super();
  factory Subscriptions() => create();
  factory Subscriptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Subscriptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Subscriptions clone() => Subscriptions()..mergeFromMessage(this);
  Subscriptions copyWith(void Function(Subscriptions) updates) => super.copyWith((message) => updates(message as Subscriptions));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Subscriptions create() => Subscriptions._();
  Subscriptions createEmptyInstance() => create();
  static $pb.PbList<Subscriptions> createRepeated() => $pb.PbList<Subscriptions>();
  @$core.pragma('dart2js:noInline')
  static Subscriptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Subscriptions>(create);
  static Subscriptions _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$2.Subscription> get subscriptions => $_getList(0);
}

class Episodes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Episodes', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..pc<Episode>(1, 'episodes', $pb.PbFieldType.PM, subBuilder: Episode.create)
    ..hasRequiredFields = false
  ;

  Episodes._() : super();
  factory Episodes() => create();
  factory Episodes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Episodes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Episodes clone() => Episodes()..mergeFromMessage(this);
  Episodes copyWith(void Function(Episodes) updates) => super.copyWith((message) => updates(message as Episodes));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Episodes create() => Episodes._();
  Episodes createEmptyInstance() => create();
  static $pb.PbList<Episodes> createRepeated() => $pb.PbList<Episodes>();
  @$core.pragma('dart2js:noInline')
  static Episodes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Episodes>(create);
  static Episodes _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Episode> get episodes => $_getList(0);
}

