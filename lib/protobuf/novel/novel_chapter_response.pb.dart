///
//  Generated code. Do not modify.
//  source: lib/protobuf/novel/novel_chapter_response.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class NovelChapterResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NovelChapterResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.novel'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errno', $pb.PbFieldType.O3, protoName: 'Errno')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errmsg', protoName: 'Errmsg')
    ..pc<NovelChapterVolumeResponse>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Data', $pb.PbFieldType.PM, protoName: 'Data', subBuilder: NovelChapterVolumeResponse.create)
    ..hasRequiredFields = false
  ;

  NovelChapterResponse._() : super();
  factory NovelChapterResponse({
    $core.int? errno,
    $core.String? errmsg,
    $core.Iterable<NovelChapterVolumeResponse>? data,
  }) {
    final _result = create();
    if (errno != null) {
      _result.errno = errno;
    }
    if (errmsg != null) {
      _result.errmsg = errmsg;
    }
    if (data != null) {
      _result.data.addAll(data);
    }
    return _result;
  }
  factory NovelChapterResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NovelChapterResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NovelChapterResponse clone() => NovelChapterResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NovelChapterResponse copyWith(void Function(NovelChapterResponse) updates) => super.copyWith((message) => updates(message as NovelChapterResponse)) as NovelChapterResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelChapterResponse create() => NovelChapterResponse._();
  NovelChapterResponse createEmptyInstance() => create();
  static $pb.PbList<NovelChapterResponse> createRepeated() => $pb.PbList<NovelChapterResponse>();
  @$core.pragma('dart2js:noInline')
  static NovelChapterResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NovelChapterResponse>(create);
  static NovelChapterResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get errno => $_getIZ(0);
  @$pb.TagNumber(1)
  set errno($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasErrno() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrno() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errmsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set errmsg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrmsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrmsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<NovelChapterVolumeResponse> get data => $_getList(2);
}

class NovelChapterVolumeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NovelChapterVolumeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.novel'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'VolumeId', $pb.PbFieldType.O3, protoName: 'VolumeId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'VolumeName', protoName: 'VolumeName')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'VolumeOrder', $pb.PbFieldType.O3, protoName: 'VolumeOrder')
    ..pc<NovelChapterItemResponse>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Chapters', $pb.PbFieldType.PM, protoName: 'Chapters', subBuilder: NovelChapterItemResponse.create)
    ..hasRequiredFields = false
  ;

  NovelChapterVolumeResponse._() : super();
  factory NovelChapterVolumeResponse({
    $core.int? volumeId,
    $core.String? volumeName,
    $core.int? volumeOrder,
    $core.Iterable<NovelChapterItemResponse>? chapters,
  }) {
    final _result = create();
    if (volumeId != null) {
      _result.volumeId = volumeId;
    }
    if (volumeName != null) {
      _result.volumeName = volumeName;
    }
    if (volumeOrder != null) {
      _result.volumeOrder = volumeOrder;
    }
    if (chapters != null) {
      _result.chapters.addAll(chapters);
    }
    return _result;
  }
  factory NovelChapterVolumeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NovelChapterVolumeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NovelChapterVolumeResponse clone() => NovelChapterVolumeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NovelChapterVolumeResponse copyWith(void Function(NovelChapterVolumeResponse) updates) => super.copyWith((message) => updates(message as NovelChapterVolumeResponse)) as NovelChapterVolumeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelChapterVolumeResponse create() => NovelChapterVolumeResponse._();
  NovelChapterVolumeResponse createEmptyInstance() => create();
  static $pb.PbList<NovelChapterVolumeResponse> createRepeated() => $pb.PbList<NovelChapterVolumeResponse>();
  @$core.pragma('dart2js:noInline')
  static NovelChapterVolumeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NovelChapterVolumeResponse>(create);
  static NovelChapterVolumeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get volumeId => $_getIZ(0);
  @$pb.TagNumber(1)
  set volumeId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVolumeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVolumeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get volumeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set volumeName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVolumeName() => $_has(1);
  @$pb.TagNumber(2)
  void clearVolumeName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get volumeOrder => $_getIZ(2);
  @$pb.TagNumber(3)
  set volumeOrder($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVolumeOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolumeOrder() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<NovelChapterItemResponse> get chapters => $_getList(3);
}

class NovelChapterItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NovelChapterItemResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.novel'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterId', $pb.PbFieldType.O3, protoName: 'ChapterId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterName', protoName: 'ChapterName')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterOrder', $pb.PbFieldType.O3, protoName: 'ChapterOrder')
    ..hasRequiredFields = false
  ;

  NovelChapterItemResponse._() : super();
  factory NovelChapterItemResponse({
    $core.int? chapterId,
    $core.String? chapterName,
    $core.int? chapterOrder,
  }) {
    final _result = create();
    if (chapterId != null) {
      _result.chapterId = chapterId;
    }
    if (chapterName != null) {
      _result.chapterName = chapterName;
    }
    if (chapterOrder != null) {
      _result.chapterOrder = chapterOrder;
    }
    return _result;
  }
  factory NovelChapterItemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NovelChapterItemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NovelChapterItemResponse clone() => NovelChapterItemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NovelChapterItemResponse copyWith(void Function(NovelChapterItemResponse) updates) => super.copyWith((message) => updates(message as NovelChapterItemResponse)) as NovelChapterItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelChapterItemResponse create() => NovelChapterItemResponse._();
  NovelChapterItemResponse createEmptyInstance() => create();
  static $pb.PbList<NovelChapterItemResponse> createRepeated() => $pb.PbList<NovelChapterItemResponse>();
  @$core.pragma('dart2js:noInline')
  static NovelChapterItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NovelChapterItemResponse>(create);
  static NovelChapterItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get chapterId => $_getIZ(0);
  @$pb.TagNumber(1)
  set chapterId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChapterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChapterId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get chapterName => $_getSZ(1);
  @$pb.TagNumber(2)
  set chapterName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChapterName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChapterName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get chapterOrder => $_getIZ(2);
  @$pb.TagNumber(3)
  set chapterOrder($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChapterOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearChapterOrder() => clearField(3);
}

