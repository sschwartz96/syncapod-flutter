///
//  Generated code. Do not modify.
//  source: objectID.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ObjectID extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ObjectID', package: const $pb.PackageName('protos'), createEmptyInstance: create)
    ..aOS(1, 'hex')
    ..hasRequiredFields = false
  ;

  ObjectID._() : super();
  factory ObjectID() => create();
  factory ObjectID.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ObjectID.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ObjectID clone() => ObjectID()..mergeFromMessage(this);
  ObjectID copyWith(void Function(ObjectID) updates) => super.copyWith((message) => updates(message as ObjectID));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ObjectID create() => ObjectID._();
  ObjectID createEmptyInstance() => create();
  static $pb.PbList<ObjectID> createRepeated() => $pb.PbList<ObjectID>();
  @$core.pragma('dart2js:noInline')
  static ObjectID getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ObjectID>(create);
  static ObjectID _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hex => $_getSZ(0);
  @$pb.TagNumber(1)
  set hex($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHex() => $_has(0);
  @$pb.TagNumber(1)
  void clearHex() => clearField(1);
}

