///
//  Generated code. Do not modify.
//  source: novel.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class NovelChapterDetailProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NovelChapterDetailProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapterId',
        protoName: 'chapterId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapterName',
        protoName: 'chapterName')
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapterOrder',
        $pb.PbFieldType.O3,
        protoName: 'chapterOrder')
    ..hasRequiredFields = false;

  NovelChapterDetailProto._() : super();
  factory NovelChapterDetailProto({
    $fixnum.Int64? chapterId,
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
  factory NovelChapterDetailProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NovelChapterDetailProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NovelChapterDetailProto clone() =>
      NovelChapterDetailProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NovelChapterDetailProto copyWith(
          void Function(NovelChapterDetailProto) updates) =>
      super.copyWith((message) => updates(message as NovelChapterDetailProto))
          as NovelChapterDetailProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelChapterDetailProto create() => NovelChapterDetailProto._();
  NovelChapterDetailProto createEmptyInstance() => create();
  static $pb.PbList<NovelChapterDetailProto> createRepeated() =>
      $pb.PbList<NovelChapterDetailProto>();
  @$core.pragma('dart2js:noInline')
  static NovelChapterDetailProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NovelChapterDetailProto>(create);
  static NovelChapterDetailProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chapterId => $_getI64(0);
  @$pb.TagNumber(1)
  set chapterId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasChapterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChapterId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get chapterName => $_getSZ(1);
  @$pb.TagNumber(2)
  set chapterName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasChapterName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChapterName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get chapterOrder => $_getIZ(2);
  @$pb.TagNumber(3)
  set chapterOrder($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasChapterOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearChapterOrder() => clearField(3);
}

class NovelVolumeProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NovelVolumeProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'volumeId')
    ..aInt64(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lnovelId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'volumeName')
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'volumeOrder',
        $pb.PbFieldType.O3)
    ..aInt64(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'addtime')
    ..a<$core.int>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'sumChapters',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  NovelVolumeProto._() : super();
  factory NovelVolumeProto({
    $fixnum.Int64? volumeId,
    $fixnum.Int64? lnovelId,
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
  factory NovelVolumeProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NovelVolumeProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NovelVolumeProto clone() => NovelVolumeProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NovelVolumeProto copyWith(void Function(NovelVolumeProto) updates) =>
      super.copyWith((message) => updates(message as NovelVolumeProto))
          as NovelVolumeProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelVolumeProto create() => NovelVolumeProto._();
  NovelVolumeProto createEmptyInstance() => create();
  static $pb.PbList<NovelVolumeProto> createRepeated() =>
      $pb.PbList<NovelVolumeProto>();
  @$core.pragma('dart2js:noInline')
  static NovelVolumeProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NovelVolumeProto>(create);
  static NovelVolumeProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get volumeId => $_getI64(0);
  @$pb.TagNumber(1)
  set volumeId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasVolumeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVolumeId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get lnovelId => $_getI64(1);
  @$pb.TagNumber(2)
  set lnovelId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLnovelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLnovelId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get volumeName => $_getSZ(2);
  @$pb.TagNumber(3)
  set volumeName($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasVolumeName() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolumeName() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get volumeOrder => $_getIZ(3);
  @$pb.TagNumber(4)
  set volumeOrder($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasVolumeOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearVolumeOrder() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get addtime => $_getI64(4);
  @$pb.TagNumber(5)
  set addtime($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAddtime() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddtime() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get sumChapters => $_getIZ(5);
  @$pb.TagNumber(6)
  set sumChapters($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSumChapters() => $_has(5);
  @$pb.TagNumber(6)
  void clearSumChapters() => clearField(6);
}

class NovelChapterResponseProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NovelChapterResponseProto',
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'errno',
        $pb.PbFieldType.O3)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'errmsg')
    ..pc<NovelVolumeDetailProto>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        $pb.PbFieldType.PM,
        subBuilder: NovelVolumeDetailProto.create)
    ..hasRequiredFields = false;

  NovelChapterResponseProto._() : super();
  factory NovelChapterResponseProto({
    $core.int? errno,
    $core.String? errmsg,
    $core.Iterable<NovelVolumeDetailProto>? data,
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
  factory NovelChapterResponseProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NovelChapterResponseProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NovelChapterResponseProto clone() =>
      NovelChapterResponseProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NovelChapterResponseProto copyWith(
          void Function(NovelChapterResponseProto) updates) =>
      super.copyWith((message) => updates(message as NovelChapterResponseProto))
          as NovelChapterResponseProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelChapterResponseProto create() => NovelChapterResponseProto._();
  NovelChapterResponseProto createEmptyInstance() => create();
  static $pb.PbList<NovelChapterResponseProto> createRepeated() =>
      $pb.PbList<NovelChapterResponseProto>();
  @$core.pragma('dart2js:noInline')
  static NovelChapterResponseProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NovelChapterResponseProto>(create);
  static NovelChapterResponseProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get errno => $_getIZ(0);
  @$pb.TagNumber(1)
  set errno($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasErrno() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrno() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errmsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set errmsg($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasErrmsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrmsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<NovelVolumeDetailProto> get data => $_getList(2);
}

class NovelVolumeDetailProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NovelVolumeDetailProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'volumeId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'volumeName')
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'volumeOrder',
        $pb.PbFieldType.O3)
    ..pc<NovelChapterDetailProto>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapters',
        $pb.PbFieldType.PM,
        subBuilder: NovelChapterDetailProto.create)
    ..hasRequiredFields = false;

  NovelVolumeDetailProto._() : super();
  factory NovelVolumeDetailProto({
    $fixnum.Int64? volumeId,
    $core.String? volumeName,
    $core.int? volumeOrder,
    $core.Iterable<NovelChapterDetailProto>? chapters,
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
  factory NovelVolumeDetailProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NovelVolumeDetailProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NovelVolumeDetailProto clone() =>
      NovelVolumeDetailProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NovelVolumeDetailProto copyWith(
          void Function(NovelVolumeDetailProto) updates) =>
      super.copyWith((message) => updates(message as NovelVolumeDetailProto))
          as NovelVolumeDetailProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelVolumeDetailProto create() => NovelVolumeDetailProto._();
  NovelVolumeDetailProto createEmptyInstance() => create();
  static $pb.PbList<NovelVolumeDetailProto> createRepeated() =>
      $pb.PbList<NovelVolumeDetailProto>();
  @$core.pragma('dart2js:noInline')
  static NovelVolumeDetailProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NovelVolumeDetailProto>(create);
  static NovelVolumeDetailProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get volumeId => $_getI64(0);
  @$pb.TagNumber(1)
  set volumeId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasVolumeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVolumeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get volumeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set volumeName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVolumeName() => $_has(1);
  @$pb.TagNumber(2)
  void clearVolumeName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get volumeOrder => $_getIZ(2);
  @$pb.TagNumber(3)
  set volumeOrder($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasVolumeOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolumeOrder() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<NovelChapterDetailProto> get chapters => $_getList(3);
}

class NovelDetailProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NovelDetailProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'novelId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'zone')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'status')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateVolumeName')
    ..aOS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateChapterName')
    ..aInt64(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateVolumeId')
    ..aInt64(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateChapterId')
    ..aInt64(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateTime')
    ..aOS(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'cover')
    ..aInt64(
        11,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'hotHits')
    ..aOS(
        12,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'introduction')
    ..pPS(
        13,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'types')
    ..aOS(
        14,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'authors')
    ..aOS(
        15,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'firstLetter')
    ..aInt64(
        16,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'subscribeNum')
    ..aInt64(
        17,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'redisUpdateTime')
    ..pc<NovelVolumeProto>(
        18,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'volume',
        $pb.PbFieldType.PM,
        subBuilder: NovelVolumeProto.create)
    ..hasRequiredFields = false;

  NovelDetailProto._() : super();
  factory NovelDetailProto({
    $fixnum.Int64? novelId,
    $core.String? name,
    $core.String? zone,
    $core.String? status,
    $core.String? lastUpdateVolumeName,
    $core.String? lastUpdateChapterName,
    $fixnum.Int64? lastUpdateVolumeId,
    $fixnum.Int64? lastUpdateChapterId,
    $fixnum.Int64? lastUpdateTime,
    $core.String? cover,
    $fixnum.Int64? hotHits,
    $core.String? introduction,
    $core.Iterable<$core.String>? types,
    $core.String? authors,
    $core.String? firstLetter,
    $fixnum.Int64? subscribeNum,
    $fixnum.Int64? redisUpdateTime,
    $core.Iterable<NovelVolumeProto>? volume,
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
  factory NovelDetailProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NovelDetailProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NovelDetailProto clone() => NovelDetailProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NovelDetailProto copyWith(void Function(NovelDetailProto) updates) =>
      super.copyWith((message) => updates(message as NovelDetailProto))
          as NovelDetailProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelDetailProto create() => NovelDetailProto._();
  NovelDetailProto createEmptyInstance() => create();
  static $pb.PbList<NovelDetailProto> createRepeated() =>
      $pb.PbList<NovelDetailProto>();
  @$core.pragma('dart2js:noInline')
  static NovelDetailProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NovelDetailProto>(create);
  static NovelDetailProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get novelId => $_getI64(0);
  @$pb.TagNumber(1)
  set novelId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNovelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNovelId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get zone => $_getSZ(2);
  @$pb.TagNumber(3)
  set zone($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasZone() => $_has(2);
  @$pb.TagNumber(3)
  void clearZone() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get lastUpdateVolumeName => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastUpdateVolumeName($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasLastUpdateVolumeName() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdateVolumeName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastUpdateChapterName => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastUpdateChapterName($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasLastUpdateChapterName() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastUpdateChapterName() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get lastUpdateVolumeId => $_getI64(6);
  @$pb.TagNumber(7)
  set lastUpdateVolumeId($fixnum.Int64 v) {
    $_setInt64(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasLastUpdateVolumeId() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastUpdateVolumeId() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get lastUpdateChapterId => $_getI64(7);
  @$pb.TagNumber(8)
  set lastUpdateChapterId($fixnum.Int64 v) {
    $_setInt64(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasLastUpdateChapterId() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdateChapterId() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get lastUpdateTime => $_getI64(8);
  @$pb.TagNumber(9)
  set lastUpdateTime($fixnum.Int64 v) {
    $_setInt64(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasLastUpdateTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastUpdateTime() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get cover => $_getSZ(9);
  @$pb.TagNumber(10)
  set cover($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasCover() => $_has(9);
  @$pb.TagNumber(10)
  void clearCover() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get hotHits => $_getI64(10);
  @$pb.TagNumber(11)
  set hotHits($fixnum.Int64 v) {
    $_setInt64(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasHotHits() => $_has(10);
  @$pb.TagNumber(11)
  void clearHotHits() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get introduction => $_getSZ(11);
  @$pb.TagNumber(12)
  set introduction($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasIntroduction() => $_has(11);
  @$pb.TagNumber(12)
  void clearIntroduction() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<$core.String> get types => $_getList(12);

  @$pb.TagNumber(14)
  $core.String get authors => $_getSZ(13);
  @$pb.TagNumber(14)
  set authors($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasAuthors() => $_has(13);
  @$pb.TagNumber(14)
  void clearAuthors() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get firstLetter => $_getSZ(14);
  @$pb.TagNumber(15)
  set firstLetter($core.String v) {
    $_setString(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasFirstLetter() => $_has(14);
  @$pb.TagNumber(15)
  void clearFirstLetter() => clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get subscribeNum => $_getI64(15);
  @$pb.TagNumber(16)
  set subscribeNum($fixnum.Int64 v) {
    $_setInt64(15, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasSubscribeNum() => $_has(15);
  @$pb.TagNumber(16)
  void clearSubscribeNum() => clearField(16);

  @$pb.TagNumber(17)
  $fixnum.Int64 get redisUpdateTime => $_getI64(16);
  @$pb.TagNumber(17)
  set redisUpdateTime($fixnum.Int64 v) {
    $_setInt64(16, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasRedisUpdateTime() => $_has(16);
  @$pb.TagNumber(17)
  void clearRedisUpdateTime() => clearField(17);

  @$pb.TagNumber(18)
  $core.List<NovelVolumeProto> get volume => $_getList(17);
}

class NovelDetailResponseProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NovelDetailResponseProto',
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'errno',
        $pb.PbFieldType.O3)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'errmsg')
    ..aOM<NovelDetailProto>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        subBuilder: NovelDetailProto.create)
    ..hasRequiredFields = false;

  NovelDetailResponseProto._() : super();
  factory NovelDetailResponseProto({
    $core.int? errno,
    $core.String? errmsg,
    NovelDetailProto? data,
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
  factory NovelDetailResponseProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NovelDetailResponseProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NovelDetailResponseProto clone() =>
      NovelDetailResponseProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NovelDetailResponseProto copyWith(
          void Function(NovelDetailResponseProto) updates) =>
      super.copyWith((message) => updates(message as NovelDetailResponseProto))
          as NovelDetailResponseProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NovelDetailResponseProto create() => NovelDetailResponseProto._();
  NovelDetailResponseProto createEmptyInstance() => create();
  static $pb.PbList<NovelDetailResponseProto> createRepeated() =>
      $pb.PbList<NovelDetailResponseProto>();
  @$core.pragma('dart2js:noInline')
  static NovelDetailResponseProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NovelDetailResponseProto>(create);
  static NovelDetailResponseProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get errno => $_getIZ(0);
  @$pb.TagNumber(1)
  set errno($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasErrno() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrno() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errmsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set errmsg($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasErrmsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrmsg() => clearField(2);

  @$pb.TagNumber(3)
  NovelDetailProto get data => $_getN(2);
  @$pb.TagNumber(3)
  set data(NovelDetailProto v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
  @$pb.TagNumber(3)
  NovelDetailProto ensureData() => $_ensure(2);
}
