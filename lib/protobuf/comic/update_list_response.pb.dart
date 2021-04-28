///
//  Generated code. Do not modify.
//  source: lib/protobuf/comic/update_list_response.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ComicUpdateListResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComicUpdateListResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.comic'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errno', $pb.PbFieldType.O3, protoName: 'Errno')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errmsg', protoName: 'Errmsg')
    ..pc<ComicUpdateListItemResponse>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Data', $pb.PbFieldType.PM, protoName: 'Data', subBuilder: ComicUpdateListItemResponse.create)
    ..hasRequiredFields = false
  ;

  ComicUpdateListResponse._() : super();
  factory ComicUpdateListResponse({
    $core.int? errno,
    $core.String? errmsg,
    $core.Iterable<ComicUpdateListItemResponse>? data,
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
  factory ComicUpdateListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComicUpdateListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComicUpdateListResponse clone() => ComicUpdateListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComicUpdateListResponse copyWith(void Function(ComicUpdateListResponse) updates) => super.copyWith((message) => updates(message as ComicUpdateListResponse)) as ComicUpdateListResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicUpdateListResponse create() => ComicUpdateListResponse._();
  ComicUpdateListResponse createEmptyInstance() => create();
  static $pb.PbList<ComicUpdateListResponse> createRepeated() => $pb.PbList<ComicUpdateListResponse>();
  @$core.pragma('dart2js:noInline')
  static ComicUpdateListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComicUpdateListResponse>(create);
  static ComicUpdateListResponse? _defaultInstance;

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
  $core.List<ComicUpdateListItemResponse> get data => $_getList(2);
}

class ComicUpdateListItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComicUpdateListItemResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.comic'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ComicId', $pb.PbFieldType.O3, protoName: 'ComicId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Title', protoName: 'Title')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Islong', protoName: 'Islong')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Authors', protoName: 'Authors')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Types', protoName: 'Types')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Cover', protoName: 'Cover')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Status', protoName: 'Status')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdateChapterName', protoName: 'LastUpdateChapterName')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdateChapterId', $pb.PbFieldType.O3, protoName: 'LastUpdateChapterId')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdatetime', protoName: 'LastUpdatetime')
    ..hasRequiredFields = false
  ;

  ComicUpdateListItemResponse._() : super();
  factory ComicUpdateListItemResponse({
    $core.int? comicId,
    $core.String? title,
    $core.bool? islong,
    $core.String? authors,
    $core.String? types,
    $core.String? cover,
    $core.String? status,
    $core.String? lastUpdateChapterName,
    $core.int? lastUpdateChapterId,
    $fixnum.Int64? lastUpdatetime,
  }) {
    final _result = create();
    if (comicId != null) {
      _result.comicId = comicId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (islong != null) {
      _result.islong = islong;
    }
    if (authors != null) {
      _result.authors = authors;
    }
    if (types != null) {
      _result.types = types;
    }
    if (cover != null) {
      _result.cover = cover;
    }
    if (status != null) {
      _result.status = status;
    }
    if (lastUpdateChapterName != null) {
      _result.lastUpdateChapterName = lastUpdateChapterName;
    }
    if (lastUpdateChapterId != null) {
      _result.lastUpdateChapterId = lastUpdateChapterId;
    }
    if (lastUpdatetime != null) {
      _result.lastUpdatetime = lastUpdatetime;
    }
    return _result;
  }
  factory ComicUpdateListItemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComicUpdateListItemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComicUpdateListItemResponse clone() => ComicUpdateListItemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComicUpdateListItemResponse copyWith(void Function(ComicUpdateListItemResponse) updates) => super.copyWith((message) => updates(message as ComicUpdateListItemResponse)) as ComicUpdateListItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicUpdateListItemResponse create() => ComicUpdateListItemResponse._();
  ComicUpdateListItemResponse createEmptyInstance() => create();
  static $pb.PbList<ComicUpdateListItemResponse> createRepeated() => $pb.PbList<ComicUpdateListItemResponse>();
  @$core.pragma('dart2js:noInline')
  static ComicUpdateListItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComicUpdateListItemResponse>(create);
  static ComicUpdateListItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get comicId => $_getIZ(0);
  @$pb.TagNumber(1)
  set comicId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasComicId() => $_has(0);
  @$pb.TagNumber(1)
  void clearComicId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get islong => $_getBF(2);
  @$pb.TagNumber(3)
  set islong($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIslong() => $_has(2);
  @$pb.TagNumber(3)
  void clearIslong() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get authors => $_getSZ(3);
  @$pb.TagNumber(4)
  set authors($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAuthors() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthors() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get types => $_getSZ(4);
  @$pb.TagNumber(5)
  set types($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTypes() => $_has(4);
  @$pb.TagNumber(5)
  void clearTypes() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get cover => $_getSZ(5);
  @$pb.TagNumber(6)
  set cover($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCover() => $_has(5);
  @$pb.TagNumber(6)
  void clearCover() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get lastUpdateChapterName => $_getSZ(7);
  @$pb.TagNumber(8)
  set lastUpdateChapterName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastUpdateChapterName() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdateChapterName() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get lastUpdateChapterId => $_getIZ(8);
  @$pb.TagNumber(9)
  set lastUpdateChapterId($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasLastUpdateChapterId() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastUpdateChapterId() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get lastUpdatetime => $_getI64(9);
  @$pb.TagNumber(10)
  set lastUpdatetime($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLastUpdatetime() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastUpdatetime() => clearField(10);
}

