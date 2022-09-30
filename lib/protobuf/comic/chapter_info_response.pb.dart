///
//  Generated code. Do not modify.
//  source: chapter_info_response.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ComicChapterInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComicChapterInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.comic'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errno', $pb.PbFieldType.O3, protoName: 'Errno')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errmsg', protoName: 'Errmsg')
    ..aOM<ComicChapterInfoDetailResponse>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Data', protoName: 'Data', subBuilder: ComicChapterInfoDetailResponse.create)
    ..hasRequiredFields = false
  ;

  ComicChapterInfoResponse._() : super();
  factory ComicChapterInfoResponse({
    $core.int? errno,
    $core.String? errmsg,
    ComicChapterInfoDetailResponse? data,
  }) {
    final _result = create();
    if (errno != null) {
      _result.errno = errno;
    }
    if (errmsg != null) {
      _result.errmsg = errmsg;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory ComicChapterInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComicChapterInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComicChapterInfoResponse clone() => ComicChapterInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComicChapterInfoResponse copyWith(void Function(ComicChapterInfoResponse) updates) => super.copyWith((message) => updates(message as ComicChapterInfoResponse)) as ComicChapterInfoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicChapterInfoResponse create() => ComicChapterInfoResponse._();
  ComicChapterInfoResponse createEmptyInstance() => create();
  static $pb.PbList<ComicChapterInfoResponse> createRepeated() => $pb.PbList<ComicChapterInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static ComicChapterInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComicChapterInfoResponse>(create);
  static ComicChapterInfoResponse? _defaultInstance;

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
  ComicChapterInfoDetailResponse get data => $_getN(2);
  @$pb.TagNumber(3)
  set data(ComicChapterInfoDetailResponse v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
  @$pb.TagNumber(3)
  ComicChapterInfoDetailResponse ensureData() => $_ensure(2);
}

class ComicChapterInfoDetailResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComicChapterInfoDetailResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.comic'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterId', $pb.PbFieldType.O3, protoName: 'ChapterId')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ComicId', protoName: 'ComicId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Title', protoName: 'Title')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterOrder', $pb.PbFieldType.O3, protoName: 'ChapterOrder')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Direction', $pb.PbFieldType.O3, protoName: 'Direction')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PageUrl', protoName: 'PageUrl')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Picnum', $pb.PbFieldType.O3, protoName: 'Picnum')
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PageUrlHd', protoName: 'PageUrlHd')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'CommentCount', $pb.PbFieldType.O3, protoName: 'CommentCount')
    ..hasRequiredFields = false
  ;

  ComicChapterInfoDetailResponse._() : super();
  factory ComicChapterInfoDetailResponse({
    $core.int? chapterId,
    $fixnum.Int64? comicId,
    $core.String? title,
    $core.int? chapterOrder,
    $core.int? direction,
    $core.Iterable<$core.String>? pageUrl,
    $core.int? picnum,
    $core.Iterable<$core.String>? pageUrlHd,
    $core.int? commentCount,
  }) {
    final _result = create();
    if (chapterId != null) {
      _result.chapterId = chapterId;
    }
    if (comicId != null) {
      _result.comicId = comicId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (chapterOrder != null) {
      _result.chapterOrder = chapterOrder;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (pageUrl != null) {
      _result.pageUrl.addAll(pageUrl);
    }
    if (picnum != null) {
      _result.picnum = picnum;
    }
    if (pageUrlHd != null) {
      _result.pageUrlHd.addAll(pageUrlHd);
    }
    if (commentCount != null) {
      _result.commentCount = commentCount;
    }
    return _result;
  }
  factory ComicChapterInfoDetailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComicChapterInfoDetailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComicChapterInfoDetailResponse clone() => ComicChapterInfoDetailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComicChapterInfoDetailResponse copyWith(void Function(ComicChapterInfoDetailResponse) updates) => super.copyWith((message) => updates(message as ComicChapterInfoDetailResponse)) as ComicChapterInfoDetailResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicChapterInfoDetailResponse create() => ComicChapterInfoDetailResponse._();
  ComicChapterInfoDetailResponse createEmptyInstance() => create();
  static $pb.PbList<ComicChapterInfoDetailResponse> createRepeated() => $pb.PbList<ComicChapterInfoDetailResponse>();
  @$core.pragma('dart2js:noInline')
  static ComicChapterInfoDetailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComicChapterInfoDetailResponse>(create);
  static ComicChapterInfoDetailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get chapterId => $_getIZ(0);
  @$pb.TagNumber(1)
  set chapterId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChapterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChapterId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get comicId => $_getI64(1);
  @$pb.TagNumber(2)
  set comicId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasComicId() => $_has(1);
  @$pb.TagNumber(2)
  void clearComicId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get chapterOrder => $_getIZ(3);
  @$pb.TagNumber(4)
  set chapterOrder($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChapterOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearChapterOrder() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get direction => $_getIZ(4);
  @$pb.TagNumber(5)
  set direction($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDirection() => $_has(4);
  @$pb.TagNumber(5)
  void clearDirection() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get pageUrl => $_getList(5);

  @$pb.TagNumber(7)
  $core.int get picnum => $_getIZ(6);
  @$pb.TagNumber(7)
  set picnum($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPicnum() => $_has(6);
  @$pb.TagNumber(7)
  void clearPicnum() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get pageUrlHd => $_getList(7);

  @$pb.TagNumber(9)
  $core.int get commentCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set commentCount($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCommentCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearCommentCount() => clearField(9);
}

