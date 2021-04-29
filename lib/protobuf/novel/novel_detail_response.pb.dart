///
//  Generated code. Do not modify.
//  source: lib/protobuf/novel/novel_detail_response.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class NovelDetailResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NovelDetailResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.novel'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errno', $pb.PbFieldType.O3, protoName: 'Errno')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Errmsg', protoName: 'Errmsg')
    ..aOM<NovelDetailInfoResponse>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Data', protoName: 'Data', subBuilder: NovelDetailInfoResponse.create)
    ..hasRequiredFields = false
  ;

  NovelDetailResponse._() : super();
  factory NovelDetailResponse({
    $core.int? errno,
    $core.String? errmsg,
    NovelDetailInfoResponse? data,
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
  factory NovelDetailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NovelDetailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NovelDetailResponse clone() => NovelDetailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NovelDetailResponse copyWith(void Function(NovelDetailResponse) updates) => super.copyWith((message) => updates(message as NovelDetailResponse)) as NovelDetailResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelDetailResponse create() => NovelDetailResponse._();
  NovelDetailResponse createEmptyInstance() => create();
  static $pb.PbList<NovelDetailResponse> createRepeated() => $pb.PbList<NovelDetailResponse>();
  @$core.pragma('dart2js:noInline')
  static NovelDetailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NovelDetailResponse>(create);
  static NovelDetailResponse? _defaultInstance;

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
  NovelDetailInfoResponse get data => $_getN(2);
  @$pb.TagNumber(3)
  set data(NovelDetailInfoResponse v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
  @$pb.TagNumber(3)
  NovelDetailInfoResponse ensureData() => $_ensure(2);
}

class NovelDetailInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NovelDetailInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.novel'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'NovelId', $pb.PbFieldType.O3, protoName: 'NovelId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Name', protoName: 'Name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Zone', protoName: 'Zone')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Status', protoName: 'Status')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdateVolumeName', protoName: 'LastUpdateVolumeName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdateChapterName', protoName: 'LastUpdateChapterName')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdateVolumeId', $pb.PbFieldType.O3, protoName: 'LastUpdateVolumeId')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdateChapterId', $pb.PbFieldType.O3, protoName: 'LastUpdateChapterId')
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastUpdateTime', protoName: 'LastUpdateTime')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Cover', protoName: 'Cover')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'HotHits', $pb.PbFieldType.O3, protoName: 'HotHits')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Introduction', protoName: 'Introduction')
    ..pPS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Types', protoName: 'Types')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Authors', protoName: 'Authors')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FirstLetter', protoName: 'FirstLetter')
    ..a<$core.int>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SubscribeNum', $pb.PbFieldType.O3, protoName: 'SubscribeNum')
    ..aInt64(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RedisUpdateTime', protoName: 'RedisUpdateTime')
    ..pc<NovelDetailInfoVolumeResponse>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Volume', $pb.PbFieldType.PM, protoName: 'Volume', subBuilder: NovelDetailInfoVolumeResponse.create)
    ..hasRequiredFields = false
  ;

  NovelDetailInfoResponse._() : super();
  factory NovelDetailInfoResponse({
    $core.int? novelId,
    $core.String? name,
    $core.String? zone,
    $core.String? status,
    $core.String? lastUpdateVolumeName,
    $core.String? lastUpdateChapterName,
    $core.int? lastUpdateVolumeId,
    $core.int? lastUpdateChapterId,
    $fixnum.Int64? lastUpdateTime,
    $core.String? cover,
    $core.int? hotHits,
    $core.String? introduction,
    $core.Iterable<$core.String>? types,
    $core.String? authors,
    $core.String? firstLetter,
    $core.int? subscribeNum,
    $fixnum.Int64? redisUpdateTime,
    $core.Iterable<NovelDetailInfoVolumeResponse>? volume,
  }) {
    final _result = create();
    if (novelId != null) {
      _result.novelId = novelId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (zone != null) {
      _result.zone = zone;
    }
    if (status != null) {
      _result.status = status;
    }
    if (lastUpdateVolumeName != null) {
      _result.lastUpdateVolumeName = lastUpdateVolumeName;
    }
    if (lastUpdateChapterName != null) {
      _result.lastUpdateChapterName = lastUpdateChapterName;
    }
    if (lastUpdateVolumeId != null) {
      _result.lastUpdateVolumeId = lastUpdateVolumeId;
    }
    if (lastUpdateChapterId != null) {
      _result.lastUpdateChapterId = lastUpdateChapterId;
    }
    if (lastUpdateTime != null) {
      _result.lastUpdateTime = lastUpdateTime;
    }
    if (cover != null) {
      _result.cover = cover;
    }
    if (hotHits != null) {
      _result.hotHits = hotHits;
    }
    if (introduction != null) {
      _result.introduction = introduction;
    }
    if (types != null) {
      _result.types.addAll(types);
    }
    if (authors != null) {
      _result.authors = authors;
    }
    if (firstLetter != null) {
      _result.firstLetter = firstLetter;
    }
    if (subscribeNum != null) {
      _result.subscribeNum = subscribeNum;
    }
    if (redisUpdateTime != null) {
      _result.redisUpdateTime = redisUpdateTime;
    }
    if (volume != null) {
      _result.volume.addAll(volume);
    }
    return _result;
  }
  factory NovelDetailInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NovelDetailInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NovelDetailInfoResponse clone() => NovelDetailInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NovelDetailInfoResponse copyWith(void Function(NovelDetailInfoResponse) updates) => super.copyWith((message) => updates(message as NovelDetailInfoResponse)) as NovelDetailInfoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelDetailInfoResponse create() => NovelDetailInfoResponse._();
  NovelDetailInfoResponse createEmptyInstance() => create();
  static $pb.PbList<NovelDetailInfoResponse> createRepeated() => $pb.PbList<NovelDetailInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static NovelDetailInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NovelDetailInfoResponse>(create);
  static NovelDetailInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get novelId => $_getIZ(0);
  @$pb.TagNumber(1)
  set novelId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNovelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNovelId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get zone => $_getSZ(2);
  @$pb.TagNumber(3)
  set zone($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasZone() => $_has(2);
  @$pb.TagNumber(3)
  void clearZone() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get lastUpdateVolumeName => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastUpdateVolumeName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastUpdateVolumeName() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdateVolumeName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastUpdateChapterName => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastUpdateChapterName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastUpdateChapterName() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastUpdateChapterName() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get lastUpdateVolumeId => $_getIZ(6);
  @$pb.TagNumber(7)
  set lastUpdateVolumeId($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastUpdateVolumeId() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastUpdateVolumeId() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get lastUpdateChapterId => $_getIZ(7);
  @$pb.TagNumber(8)
  set lastUpdateChapterId($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastUpdateChapterId() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdateChapterId() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get lastUpdateTime => $_getI64(8);
  @$pb.TagNumber(9)
  set lastUpdateTime($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasLastUpdateTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastUpdateTime() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get cover => $_getSZ(9);
  @$pb.TagNumber(10)
  set cover($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCover() => $_has(9);
  @$pb.TagNumber(10)
  void clearCover() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get hotHits => $_getIZ(10);
  @$pb.TagNumber(11)
  set hotHits($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasHotHits() => $_has(10);
  @$pb.TagNumber(11)
  void clearHotHits() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get introduction => $_getSZ(11);
  @$pb.TagNumber(12)
  set introduction($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIntroduction() => $_has(11);
  @$pb.TagNumber(12)
  void clearIntroduction() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<$core.String> get types => $_getList(12);

  @$pb.TagNumber(14)
  $core.String get authors => $_getSZ(13);
  @$pb.TagNumber(14)
  set authors($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasAuthors() => $_has(13);
  @$pb.TagNumber(14)
  void clearAuthors() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get firstLetter => $_getSZ(14);
  @$pb.TagNumber(15)
  set firstLetter($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasFirstLetter() => $_has(14);
  @$pb.TagNumber(15)
  void clearFirstLetter() => clearField(15);

  @$pb.TagNumber(16)
  $core.int get subscribeNum => $_getIZ(15);
  @$pb.TagNumber(16)
  set subscribeNum($core.int v) { $_setSignedInt32(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasSubscribeNum() => $_has(15);
  @$pb.TagNumber(16)
  void clearSubscribeNum() => clearField(16);

  @$pb.TagNumber(17)
  $fixnum.Int64 get redisUpdateTime => $_getI64(16);
  @$pb.TagNumber(17)
  set redisUpdateTime($fixnum.Int64 v) { $_setInt64(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasRedisUpdateTime() => $_has(16);
  @$pb.TagNumber(17)
  void clearRedisUpdateTime() => clearField(17);

  @$pb.TagNumber(18)
  $core.List<NovelDetailInfoVolumeResponse> get volume => $_getList(17);
}

class NovelDetailInfoVolumeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NovelDetailInfoVolumeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'dmzj.novel'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'VolumeId', $pb.PbFieldType.O3, protoName: 'VolumeId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LnovelId', $pb.PbFieldType.O3, protoName: 'LnovelId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'VolumeName', protoName: 'VolumeName')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'VolumeOrder', $pb.PbFieldType.O3, protoName: 'VolumeOrder')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Addtime', protoName: 'Addtime')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SumChapters', $pb.PbFieldType.O3, protoName: 'SumChapters')
    ..hasRequiredFields = false
  ;

  NovelDetailInfoVolumeResponse._() : super();
  factory NovelDetailInfoVolumeResponse({
    $core.int? volumeId,
    $core.int? lnovelId,
    $core.String? volumeName,
    $core.int? volumeOrder,
    $fixnum.Int64? addtime,
    $core.int? sumChapters,
  }) {
    final _result = create();
    if (volumeId != null) {
      _result.volumeId = volumeId;
    }
    if (lnovelId != null) {
      _result.lnovelId = lnovelId;
    }
    if (volumeName != null) {
      _result.volumeName = volumeName;
    }
    if (volumeOrder != null) {
      _result.volumeOrder = volumeOrder;
    }
    if (addtime != null) {
      _result.addtime = addtime;
    }
    if (sumChapters != null) {
      _result.sumChapters = sumChapters;
    }
    return _result;
  }
  factory NovelDetailInfoVolumeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NovelDetailInfoVolumeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NovelDetailInfoVolumeResponse clone() => NovelDetailInfoVolumeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NovelDetailInfoVolumeResponse copyWith(void Function(NovelDetailInfoVolumeResponse) updates) => super.copyWith((message) => updates(message as NovelDetailInfoVolumeResponse)) as NovelDetailInfoVolumeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelDetailInfoVolumeResponse create() => NovelDetailInfoVolumeResponse._();
  NovelDetailInfoVolumeResponse createEmptyInstance() => create();
  static $pb.PbList<NovelDetailInfoVolumeResponse> createRepeated() => $pb.PbList<NovelDetailInfoVolumeResponse>();
  @$core.pragma('dart2js:noInline')
  static NovelDetailInfoVolumeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NovelDetailInfoVolumeResponse>(create);
  static NovelDetailInfoVolumeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get volumeId => $_getIZ(0);
  @$pb.TagNumber(1)
  set volumeId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVolumeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVolumeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get lnovelId => $_getIZ(1);
  @$pb.TagNumber(2)
  set lnovelId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLnovelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLnovelId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get volumeName => $_getSZ(2);
  @$pb.TagNumber(3)
  set volumeName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVolumeName() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolumeName() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get volumeOrder => $_getIZ(3);
  @$pb.TagNumber(4)
  set volumeOrder($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVolumeOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearVolumeOrder() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get addtime => $_getI64(4);
  @$pb.TagNumber(5)
  set addtime($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAddtime() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddtime() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get sumChapters => $_getIZ(5);
  @$pb.TagNumber(6)
  set sumChapters($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSumChapters() => $_has(5);
  @$pb.TagNumber(6)
  void clearSumChapters() => clearField(6);
}

