///
//  Generated code. Do not modify.
//  source: lib/protobuf/comic/rank_list_response.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ComicRankListResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComicRankListResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.comic'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errno', $pb.PbFieldType.O3, protoName: 'Errno')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errmsg', protoName: 'Errmsg')
    ..pc<ComicRankListItemResponse>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Data', $pb.PbFieldType.PM, protoName: 'Data', subBuilder: ComicRankListItemResponse.create)
    ..hasRequiredFields = false
  ;

  ComicRankListResponse._() : super();
  factory ComicRankListResponse({
    $core.int? errno,
    $core.String? errmsg,
    $core.Iterable<ComicRankListItemResponse>? data,
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
  factory ComicRankListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComicRankListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComicRankListResponse clone() => ComicRankListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComicRankListResponse copyWith(void Function(ComicRankListResponse) updates) => super.copyWith((message) => updates(message as ComicRankListResponse)) as ComicRankListResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicRankListResponse create() => ComicRankListResponse._();
  ComicRankListResponse createEmptyInstance() => create();
  static $pb.PbList<ComicRankListResponse> createRepeated() => $pb.PbList<ComicRankListResponse>();
  @$core.pragma('dart2js:noInline')
  static ComicRankListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComicRankListResponse>(create);
  static ComicRankListResponse? _defaultInstance;

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
  $core.List<ComicRankListItemResponse> get data => $_getList(2);
}

class ComicRankListItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComicRankListItemResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.comic'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ComicId', $pb.PbFieldType.O3, protoName: 'ComicId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Title', protoName: 'Title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Authors', protoName: 'Authors')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Status', protoName: 'Status')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Cover', protoName: 'Cover')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Types', protoName: 'Types')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdatetime', protoName: 'LastUpdatetime')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdateChapterName', protoName: 'LastUpdateChapterName')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ComicPy', protoName: 'ComicPy')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Num', $pb.PbFieldType.O3, protoName: 'Num')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TagId', $pb.PbFieldType.O3, protoName: 'TagId')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterName', protoName: 'ChapterName')
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterId', $pb.PbFieldType.O3, protoName: 'ChapterId')
    ..hasRequiredFields = false
  ;

  ComicRankListItemResponse._() : super();
  factory ComicRankListItemResponse({
    $core.int? comicId,
    $core.String? title,
    $core.String? authors,
    $core.String? status,
    $core.String? cover,
    $core.String? types,
    $fixnum.Int64? lastUpdatetime,
    $core.String? lastUpdateChapterName,
    $core.String? comicPy,
    $core.int? num,
    $core.int? tagId,
    $core.String? chapterName,
    $core.int? chapterId,
  }) {
    final _result = create();
    if (comicId != null) {
      _result.comicId = comicId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (authors != null) {
      _result.authors = authors;
    }
    if (status != null) {
      _result.status = status;
    }
    if (cover != null) {
      _result.cover = cover;
    }
    if (types != null) {
      _result.types = types;
    }
    if (lastUpdatetime != null) {
      _result.lastUpdatetime = lastUpdatetime;
    }
    if (lastUpdateChapterName != null) {
      _result.lastUpdateChapterName = lastUpdateChapterName;
    }
    if (comicPy != null) {
      _result.comicPy = comicPy;
    }
    if (num != null) {
      _result.num = num;
    }
    if (tagId != null) {
      _result.tagId = tagId;
    }
    if (chapterName != null) {
      _result.chapterName = chapterName;
    }
    if (chapterId != null) {
      _result.chapterId = chapterId;
    }
    return _result;
  }
  factory ComicRankListItemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComicRankListItemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComicRankListItemResponse clone() => ComicRankListItemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComicRankListItemResponse copyWith(void Function(ComicRankListItemResponse) updates) => super.copyWith((message) => updates(message as ComicRankListItemResponse)) as ComicRankListItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicRankListItemResponse create() => ComicRankListItemResponse._();
  ComicRankListItemResponse createEmptyInstance() => create();
  static $pb.PbList<ComicRankListItemResponse> createRepeated() => $pb.PbList<ComicRankListItemResponse>();
  @$core.pragma('dart2js:noInline')
  static ComicRankListItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComicRankListItemResponse>(create);
  static ComicRankListItemResponse? _defaultInstance;

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
  $core.String get authors => $_getSZ(2);
  @$pb.TagNumber(3)
  set authors($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthors() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthors() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get cover => $_getSZ(4);
  @$pb.TagNumber(5)
  set cover($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCover() => $_has(4);
  @$pb.TagNumber(5)
  void clearCover() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get types => $_getSZ(5);
  @$pb.TagNumber(6)
  set types($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTypes() => $_has(5);
  @$pb.TagNumber(6)
  void clearTypes() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get lastUpdatetime => $_getI64(6);
  @$pb.TagNumber(7)
  set lastUpdatetime($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastUpdatetime() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastUpdatetime() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get lastUpdateChapterName => $_getSZ(7);
  @$pb.TagNumber(8)
  set lastUpdateChapterName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastUpdateChapterName() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdateChapterName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get comicPy => $_getSZ(8);
  @$pb.TagNumber(9)
  set comicPy($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasComicPy() => $_has(8);
  @$pb.TagNumber(9)
  void clearComicPy() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get num => $_getIZ(9);
  @$pb.TagNumber(10)
  set num($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNum() => $_has(9);
  @$pb.TagNumber(10)
  void clearNum() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get tagId => $_getIZ(10);
  @$pb.TagNumber(11)
  set tagId($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTagId() => $_has(10);
  @$pb.TagNumber(11)
  void clearTagId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get chapterName => $_getSZ(11);
  @$pb.TagNumber(12)
  set chapterName($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasChapterName() => $_has(11);
  @$pb.TagNumber(12)
  void clearChapterName() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get chapterId => $_getIZ(12);
  @$pb.TagNumber(13)
  set chapterId($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasChapterId() => $_has(12);
  @$pb.TagNumber(13)
  void clearChapterId() => clearField(13);
}

