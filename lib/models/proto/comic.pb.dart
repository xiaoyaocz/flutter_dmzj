///
//  Generated code. Do not modify.
//  source: comic.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ComicChapterDetailProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicChapterDetailProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapterId',
        protoName: 'chapterId')
    ..aInt64(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'comicId',
        protoName: 'comicId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapterOrder',
        $pb.PbFieldType.O3,
        protoName: 'chapterOrder')
    ..a<$core.int>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'direction',
        $pb.PbFieldType.O3)
    ..pPS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageUrl',
        protoName: 'pageUrl')
    ..a<$core.int>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'picnum',
        $pb.PbFieldType.O3)
    ..pPS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageUrlHD',
        protoName: 'pageUrlHD')
    ..a<$core.int>(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'commentCount',
        $pb.PbFieldType.O3,
        protoName: 'commentCount')
    ..hasRequiredFields = false;

  ComicChapterDetailProto._() : super();
  factory ComicChapterDetailProto({
    $fixnum.Int64? chapterId,
    $fixnum.Int64? comicId,
    $core.String? title,
    $core.int? chapterOrder,
    $core.int? direction,
    $core.Iterable<$core.String>? pageUrl,
    $core.int? picnum,
    $core.Iterable<$core.String>? pageUrlHD,
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
    if (pageUrlHD != null) {
      _result.pageUrlHD.addAll(pageUrlHD);
    }
    if (commentCount != null) {
      _result.commentCount = commentCount;
    }
    return _result;
  }
  factory ComicChapterDetailProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicChapterDetailProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicChapterDetailProto clone() =>
      ComicChapterDetailProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicChapterDetailProto copyWith(
          void Function(ComicChapterDetailProto) updates) =>
      super.copyWith((message) => updates(message as ComicChapterDetailProto))
          as ComicChapterDetailProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicChapterDetailProto create() => ComicChapterDetailProto._();
  ComicChapterDetailProto createEmptyInstance() => create();
  static $pb.PbList<ComicChapterDetailProto> createRepeated() =>
      $pb.PbList<ComicChapterDetailProto>();
  @$core.pragma('dart2js:noInline')
  static ComicChapterDetailProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicChapterDetailProto>(create);
  static ComicChapterDetailProto? _defaultInstance;

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
  $fixnum.Int64 get comicId => $_getI64(1);
  @$pb.TagNumber(2)
  set comicId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasComicId() => $_has(1);
  @$pb.TagNumber(2)
  void clearComicId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get chapterOrder => $_getIZ(3);
  @$pb.TagNumber(4)
  set chapterOrder($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasChapterOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearChapterOrder() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get direction => $_getIZ(4);
  @$pb.TagNumber(5)
  set direction($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDirection() => $_has(4);
  @$pb.TagNumber(5)
  void clearDirection() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get pageUrl => $_getList(5);

  @$pb.TagNumber(7)
  $core.int get picnum => $_getIZ(6);
  @$pb.TagNumber(7)
  set picnum($core.int v) {
    $_setSignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasPicnum() => $_has(6);
  @$pb.TagNumber(7)
  void clearPicnum() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get pageUrlHD => $_getList(7);

  @$pb.TagNumber(9)
  $core.int get commentCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set commentCount($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasCommentCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearCommentCount() => clearField(9);
}

class ComicChapterInfoProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicChapterInfoProto',
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
            : 'chapterTitle',
        protoName: 'chapterTitle')
    ..aInt64(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'updateTime',
        protoName: 'updateTime')
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fileSize',
        $pb.PbFieldType.O3,
        protoName: 'fileSize')
    ..a<$core.int>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapterOrder',
        $pb.PbFieldType.O3,
        protoName: 'chapterOrder')
    ..a<$core.int>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isFee',
        $pb.PbFieldType.O3,
        protoName: 'isFee')
    ..hasRequiredFields = false;

  ComicChapterInfoProto._() : super();
  factory ComicChapterInfoProto({
    $fixnum.Int64? chapterId,
    $core.String? chapterTitle,
    $fixnum.Int64? updateTime,
    $core.int? fileSize,
    $core.int? chapterOrder,
    $core.int? isFee,
  }) {
    final _result = create();
    if (chapterId != null) {
      _result.chapterId = chapterId;
    }
    if (chapterTitle != null) {
      _result.chapterTitle = chapterTitle;
    }
    if (updateTime != null) {
      _result.updateTime = updateTime;
    }
    if (fileSize != null) {
      _result.fileSize = fileSize;
    }
    if (chapterOrder != null) {
      _result.chapterOrder = chapterOrder;
    }
    if (isFee != null) {
      _result.isFee = isFee;
    }
    return _result;
  }
  factory ComicChapterInfoProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicChapterInfoProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicChapterInfoProto clone() =>
      ComicChapterInfoProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicChapterInfoProto copyWith(
          void Function(ComicChapterInfoProto) updates) =>
      super.copyWith((message) => updates(message as ComicChapterInfoProto))
          as ComicChapterInfoProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicChapterInfoProto create() => ComicChapterInfoProto._();
  ComicChapterInfoProto createEmptyInstance() => create();
  static $pb.PbList<ComicChapterInfoProto> createRepeated() =>
      $pb.PbList<ComicChapterInfoProto>();
  @$core.pragma('dart2js:noInline')
  static ComicChapterInfoProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicChapterInfoProto>(create);
  static ComicChapterInfoProto? _defaultInstance;

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
  $core.String get chapterTitle => $_getSZ(1);
  @$pb.TagNumber(2)
  set chapterTitle($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasChapterTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearChapterTitle() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get updateTime => $_getI64(2);
  @$pb.TagNumber(3)
  set updateTime($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUpdateTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateTime() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get fileSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set fileSize($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFileSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearFileSize() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get chapterOrder => $_getIZ(4);
  @$pb.TagNumber(5)
  set chapterOrder($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasChapterOrder() => $_has(4);
  @$pb.TagNumber(5)
  void clearChapterOrder() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get isFee => $_getIZ(5);
  @$pb.TagNumber(6)
  set isFee($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasIsFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsFee() => clearField(6);
}

class ComicChapterResponseProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicChapterResponseProto',
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
    ..aOM<ComicChapterDetailProto>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        subBuilder: ComicChapterDetailProto.create)
    ..hasRequiredFields = false;

  ComicChapterResponseProto._() : super();
  factory ComicChapterResponseProto({
    $core.int? errno,
    $core.String? errmsg,
    ComicChapterDetailProto? data,
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
  factory ComicChapterResponseProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicChapterResponseProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicChapterResponseProto clone() =>
      ComicChapterResponseProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicChapterResponseProto copyWith(
          void Function(ComicChapterResponseProto) updates) =>
      super.copyWith((message) => updates(message as ComicChapterResponseProto))
          as ComicChapterResponseProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicChapterResponseProto create() => ComicChapterResponseProto._();
  ComicChapterResponseProto createEmptyInstance() => create();
  static $pb.PbList<ComicChapterResponseProto> createRepeated() =>
      $pb.PbList<ComicChapterResponseProto>();
  @$core.pragma('dart2js:noInline')
  static ComicChapterResponseProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicChapterResponseProto>(create);
  static ComicChapterResponseProto? _defaultInstance;

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
  ComicChapterDetailProto get data => $_getN(2);
  @$pb.TagNumber(3)
  set data(ComicChapterDetailProto v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
  @$pb.TagNumber(3)
  ComicChapterDetailProto ensureData() => $_ensure(2);
}

class ComicChapterListProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicChapterListProto',
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..pc<ComicChapterInfoProto>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        $pb.PbFieldType.PM,
        subBuilder: ComicChapterInfoProto.create)
    ..hasRequiredFields = false;

  ComicChapterListProto._() : super();
  factory ComicChapterListProto({
    $core.String? title,
    $core.Iterable<ComicChapterInfoProto>? data,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (data != null) {
      _result.data.addAll(data);
    }
    return _result;
  }
  factory ComicChapterListProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicChapterListProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicChapterListProto clone() =>
      ComicChapterListProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicChapterListProto copyWith(
          void Function(ComicChapterListProto) updates) =>
      super.copyWith((message) => updates(message as ComicChapterListProto))
          as ComicChapterListProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicChapterListProto create() => ComicChapterListProto._();
  ComicChapterListProto createEmptyInstance() => create();
  static $pb.PbList<ComicChapterListProto> createRepeated() =>
      $pb.PbList<ComicChapterListProto>();
  @$core.pragma('dart2js:noInline')
  static ComicChapterListProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicChapterListProto>(create);
  static ComicChapterListProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<ComicChapterInfoProto> get data => $_getList(1);
}

class ComicDetailResponseProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicDetailResponseProto',
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
    ..aOM<ComicDetailProto>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        subBuilder: ComicDetailProto.create)
    ..hasRequiredFields = false;

  ComicDetailResponseProto._() : super();
  factory ComicDetailResponseProto({
    $core.int? errno,
    $core.String? errmsg,
    ComicDetailProto? data,
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
  factory ComicDetailResponseProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicDetailResponseProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicDetailResponseProto clone() =>
      ComicDetailResponseProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicDetailResponseProto copyWith(
          void Function(ComicDetailResponseProto) updates) =>
      super.copyWith((message) => updates(message as ComicDetailResponseProto))
          as ComicDetailResponseProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicDetailResponseProto create() => ComicDetailResponseProto._();
  ComicDetailResponseProto createEmptyInstance() => create();
  static $pb.PbList<ComicDetailResponseProto> createRepeated() =>
      $pb.PbList<ComicDetailResponseProto>();
  @$core.pragma('dart2js:noInline')
  static ComicDetailResponseProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicDetailResponseProto>(create);
  static ComicDetailResponseProto? _defaultInstance;

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
  ComicDetailProto get data => $_getN(2);
  @$pb.TagNumber(3)
  set data(ComicDetailProto v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
  @$pb.TagNumber(3)
  ComicDetailProto ensureData() => $_ensure(2);
}

class ComicDetailProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicDetailProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'id')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'direction',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'islong',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isDmzj',
        $pb.PbFieldType.O3,
        protoName: 'isDmzj')
    ..aOS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'cover')
    ..aOS(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..aInt64(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdatetime',
        protoName: 'lastUpdatetime')
    ..aOS(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateChapterName',
        protoName: 'lastUpdateChapterName')
    ..a<$core.int>(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'copyright',
        $pb.PbFieldType.O3)
    ..aOS(
        11,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'firstLetter',
        protoName: 'firstLetter')
    ..aOS(
        12,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'comicPy',
        protoName: 'comicPy')
    ..a<$core.int>(
        13,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'hidden',
        $pb.PbFieldType.O3)
    ..aInt64(
        14,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'hotNum',
        protoName: 'hotNum')
    ..aInt64(
        15,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'hitNum',
        protoName: 'hitNum')
    ..aInt64(
        16,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'uid')
    ..a<$core.int>(
        17,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isLock',
        $pb.PbFieldType.O3,
        protoName: 'isLock')
    ..a<$core.int>(
        18,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateChapterId',
        $pb.PbFieldType.O3,
        protoName: 'lastUpdateChapterId')
    ..pc<ComicTagProto>(
        19,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'types',
        $pb.PbFieldType.PM,
        subBuilder: ComicTagProto.create)
    ..pc<ComicTagProto>(
        20,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'status',
        $pb.PbFieldType.PM,
        subBuilder: ComicTagProto.create)
    ..pc<ComicTagProto>(
        21,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'authors',
        $pb.PbFieldType.PM,
        subBuilder: ComicTagProto.create)
    ..aInt64(
        22,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'subscribeNum',
        protoName: 'subscribeNum')
    ..pc<ComicChapterListProto>(
        23,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapters',
        $pb.PbFieldType.PM,
        subBuilder: ComicChapterListProto.create)
    ..a<$core.int>(
        24,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isNeedLogin',
        $pb.PbFieldType.O3,
        protoName: 'isNeedLogin')
    ..pc<ComicDetailUrlLinkProto>(
        25,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'urlLinks',
        $pb.PbFieldType.PM,
        protoName: 'urlLinks',
        subBuilder: ComicDetailUrlLinkProto.create)
    ..a<$core.int>(
        26,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isHideChapter',
        $pb.PbFieldType.O3,
        protoName: 'isHideChapter')
    ..pc<ComicDetailUrlLinkProto>(
        27,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'dhUrlLinks',
        $pb.PbFieldType.PM,
        protoName: 'dhUrlLinks',
        subBuilder: ComicDetailUrlLinkProto.create)
    ..aOS(
        28,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'cornerMark',
        protoName: 'cornerMark')
    ..a<$core.int>(
        29,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isFee',
        $pb.PbFieldType.O3,
        protoName: 'isFee')
    ..hasRequiredFields = false;

  ComicDetailProto._() : super();
  factory ComicDetailProto({
    $fixnum.Int64? id,
    $core.String? title,
    $core.int? direction,
    $core.int? islong,
    $core.int? isDmzj,
    $core.String? cover,
    $core.String? description,
    $fixnum.Int64? lastUpdatetime,
    $core.String? lastUpdateChapterName,
    $core.int? copyright,
    $core.String? firstLetter,
    $core.String? comicPy,
    $core.int? hidden,
    $fixnum.Int64? hotNum,
    $fixnum.Int64? hitNum,
    $fixnum.Int64? uid,
    $core.int? isLock,
    $core.int? lastUpdateChapterId,
    $core.Iterable<ComicTagProto>? types,
    $core.Iterable<ComicTagProto>? status,
    $core.Iterable<ComicTagProto>? authors,
    $fixnum.Int64? subscribeNum,
    $core.Iterable<ComicChapterListProto>? chapters,
    $core.int? isNeedLogin,
    $core.Iterable<ComicDetailUrlLinkProto>? urlLinks,
    $core.int? isHideChapter,
    $core.Iterable<ComicDetailUrlLinkProto>? dhUrlLinks,
    $core.String? cornerMark,
    $core.int? isFee,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (title != null) {
      _result.title = title;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (islong != null) {
      _result.islong = islong;
    }
    if (isDmzj != null) {
      _result.isDmzj = isDmzj;
    }
    if (cover != null) {
      _result.cover = cover;
    }
    if (description != null) {
      _result.description = description;
    }
    if (lastUpdatetime != null) {
      _result.lastUpdatetime = lastUpdatetime;
    }
    if (lastUpdateChapterName != null) {
      _result.lastUpdateChapterName = lastUpdateChapterName;
    }
    if (copyright != null) {
      _result.copyright = copyright;
    }
    if (firstLetter != null) {
      _result.firstLetter = firstLetter;
    }
    if (comicPy != null) {
      _result.comicPy = comicPy;
    }
    if (hidden != null) {
      _result.hidden = hidden;
    }
    if (hotNum != null) {
      _result.hotNum = hotNum;
    }
    if (hitNum != null) {
      _result.hitNum = hitNum;
    }
    if (uid != null) {
      _result.uid = uid;
    }
    if (isLock != null) {
      _result.isLock = isLock;
    }
    if (lastUpdateChapterId != null) {
      _result.lastUpdateChapterId = lastUpdateChapterId;
    }
    if (types != null) {
      _result.types.addAll(types);
    }
    if (status != null) {
      _result.status.addAll(status);
    }
    if (authors != null) {
      _result.authors.addAll(authors);
    }
    if (subscribeNum != null) {
      _result.subscribeNum = subscribeNum;
    }
    if (chapters != null) {
      _result.chapters.addAll(chapters);
    }
    if (isNeedLogin != null) {
      _result.isNeedLogin = isNeedLogin;
    }
    if (urlLinks != null) {
      _result.urlLinks.addAll(urlLinks);
    }
    if (isHideChapter != null) {
      _result.isHideChapter = isHideChapter;
    }
    if (dhUrlLinks != null) {
      _result.dhUrlLinks.addAll(dhUrlLinks);
    }
    if (cornerMark != null) {
      _result.cornerMark = cornerMark;
    }
    if (isFee != null) {
      _result.isFee = isFee;
    }
    return _result;
  }
  factory ComicDetailProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicDetailProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicDetailProto clone() => ComicDetailProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicDetailProto copyWith(void Function(ComicDetailProto) updates) =>
      super.copyWith((message) => updates(message as ComicDetailProto))
          as ComicDetailProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicDetailProto create() => ComicDetailProto._();
  ComicDetailProto createEmptyInstance() => create();
  static $pb.PbList<ComicDetailProto> createRepeated() =>
      $pb.PbList<ComicDetailProto>();
  @$core.pragma('dart2js:noInline')
  static ComicDetailProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicDetailProto>(create);
  static ComicDetailProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get direction => $_getIZ(2);
  @$pb.TagNumber(3)
  set direction($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get islong => $_getIZ(3);
  @$pb.TagNumber(4)
  set islong($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIslong() => $_has(3);
  @$pb.TagNumber(4)
  void clearIslong() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get isDmzj => $_getIZ(4);
  @$pb.TagNumber(5)
  set isDmzj($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasIsDmzj() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsDmzj() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get cover => $_getSZ(5);
  @$pb.TagNumber(6)
  set cover($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCover() => $_has(5);
  @$pb.TagNumber(6)
  void clearCover() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(7)
  set description($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescription() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get lastUpdatetime => $_getI64(7);
  @$pb.TagNumber(8)
  set lastUpdatetime($fixnum.Int64 v) {
    $_setInt64(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasLastUpdatetime() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdatetime() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get lastUpdateChapterName => $_getSZ(8);
  @$pb.TagNumber(9)
  set lastUpdateChapterName($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasLastUpdateChapterName() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastUpdateChapterName() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get copyright => $_getIZ(9);
  @$pb.TagNumber(10)
  set copyright($core.int v) {
    $_setSignedInt32(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasCopyright() => $_has(9);
  @$pb.TagNumber(10)
  void clearCopyright() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get firstLetter => $_getSZ(10);
  @$pb.TagNumber(11)
  set firstLetter($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasFirstLetter() => $_has(10);
  @$pb.TagNumber(11)
  void clearFirstLetter() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get comicPy => $_getSZ(11);
  @$pb.TagNumber(12)
  set comicPy($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasComicPy() => $_has(11);
  @$pb.TagNumber(12)
  void clearComicPy() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get hidden => $_getIZ(12);
  @$pb.TagNumber(13)
  set hidden($core.int v) {
    $_setSignedInt32(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasHidden() => $_has(12);
  @$pb.TagNumber(13)
  void clearHidden() => clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get hotNum => $_getI64(13);
  @$pb.TagNumber(14)
  set hotNum($fixnum.Int64 v) {
    $_setInt64(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasHotNum() => $_has(13);
  @$pb.TagNumber(14)
  void clearHotNum() => clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get hitNum => $_getI64(14);
  @$pb.TagNumber(15)
  set hitNum($fixnum.Int64 v) {
    $_setInt64(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasHitNum() => $_has(14);
  @$pb.TagNumber(15)
  void clearHitNum() => clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get uid => $_getI64(15);
  @$pb.TagNumber(16)
  set uid($fixnum.Int64 v) {
    $_setInt64(15, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasUid() => $_has(15);
  @$pb.TagNumber(16)
  void clearUid() => clearField(16);

  @$pb.TagNumber(17)
  $core.int get isLock => $_getIZ(16);
  @$pb.TagNumber(17)
  set isLock($core.int v) {
    $_setSignedInt32(16, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasIsLock() => $_has(16);
  @$pb.TagNumber(17)
  void clearIsLock() => clearField(17);

  @$pb.TagNumber(18)
  $core.int get lastUpdateChapterId => $_getIZ(17);
  @$pb.TagNumber(18)
  set lastUpdateChapterId($core.int v) {
    $_setSignedInt32(17, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasLastUpdateChapterId() => $_has(17);
  @$pb.TagNumber(18)
  void clearLastUpdateChapterId() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<ComicTagProto> get types => $_getList(18);

  @$pb.TagNumber(20)
  $core.List<ComicTagProto> get status => $_getList(19);

  @$pb.TagNumber(21)
  $core.List<ComicTagProto> get authors => $_getList(20);

  @$pb.TagNumber(22)
  $fixnum.Int64 get subscribeNum => $_getI64(21);
  @$pb.TagNumber(22)
  set subscribeNum($fixnum.Int64 v) {
    $_setInt64(21, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasSubscribeNum() => $_has(21);
  @$pb.TagNumber(22)
  void clearSubscribeNum() => clearField(22);

  @$pb.TagNumber(23)
  $core.List<ComicChapterListProto> get chapters => $_getList(22);

  @$pb.TagNumber(24)
  $core.int get isNeedLogin => $_getIZ(23);
  @$pb.TagNumber(24)
  set isNeedLogin($core.int v) {
    $_setSignedInt32(23, v);
  }

  @$pb.TagNumber(24)
  $core.bool hasIsNeedLogin() => $_has(23);
  @$pb.TagNumber(24)
  void clearIsNeedLogin() => clearField(24);

  @$pb.TagNumber(25)
  $core.List<ComicDetailUrlLinkProto> get urlLinks => $_getList(24);

  @$pb.TagNumber(26)
  $core.int get isHideChapter => $_getIZ(25);
  @$pb.TagNumber(26)
  set isHideChapter($core.int v) {
    $_setSignedInt32(25, v);
  }

  @$pb.TagNumber(26)
  $core.bool hasIsHideChapter() => $_has(25);
  @$pb.TagNumber(26)
  void clearIsHideChapter() => clearField(26);

  @$pb.TagNumber(27)
  $core.List<ComicDetailUrlLinkProto> get dhUrlLinks => $_getList(26);

  @$pb.TagNumber(28)
  $core.String get cornerMark => $_getSZ(27);
  @$pb.TagNumber(28)
  set cornerMark($core.String v) {
    $_setString(27, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasCornerMark() => $_has(27);
  @$pb.TagNumber(28)
  void clearCornerMark() => clearField(28);

  @$pb.TagNumber(29)
  $core.int get isFee => $_getIZ(28);
  @$pb.TagNumber(29)
  set isFee($core.int v) {
    $_setSignedInt32(28, v);
  }

  @$pb.TagNumber(29)
  $core.bool hasIsFee() => $_has(28);
  @$pb.TagNumber(29)
  void clearIsFee() => clearField(29);
}

class ComicTagProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicTagProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'tagId',
        protoName: 'tagId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'tagName',
        protoName: 'tagName')
    ..hasRequiredFields = false;

  ComicTagProto._() : super();
  factory ComicTagProto({
    $fixnum.Int64? tagId,
    $core.String? tagName,
  }) {
    final _result = create();
    if (tagId != null) {
      _result.tagId = tagId;
    }
    if (tagName != null) {
      _result.tagName = tagName;
    }
    return _result;
  }
  factory ComicTagProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicTagProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicTagProto clone() => ComicTagProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicTagProto copyWith(void Function(ComicTagProto) updates) =>
      super.copyWith((message) => updates(message as ComicTagProto))
          as ComicTagProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicTagProto create() => ComicTagProto._();
  ComicTagProto createEmptyInstance() => create();
  static $pb.PbList<ComicTagProto> createRepeated() =>
      $pb.PbList<ComicTagProto>();
  @$core.pragma('dart2js:noInline')
  static ComicTagProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicTagProto>(create);
  static ComicTagProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get tagId => $_getI64(0);
  @$pb.TagNumber(1)
  set tagId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTagId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTagId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tagName => $_getSZ(1);
  @$pb.TagNumber(2)
  set tagName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTagName() => $_has(1);
  @$pb.TagNumber(2)
  void clearTagName() => clearField(2);
}

class ComicDetailUrlLinkProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicDetailUrlLinkProto',
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..pc<ComicDetailUrlProto>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'list',
        $pb.PbFieldType.PM,
        subBuilder: ComicDetailUrlProto.create)
    ..hasRequiredFields = false;

  ComicDetailUrlLinkProto._() : super();
  factory ComicDetailUrlLinkProto({
    $core.String? title,
    $core.Iterable<ComicDetailUrlProto>? list,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (list != null) {
      _result.list.addAll(list);
    }
    return _result;
  }
  factory ComicDetailUrlLinkProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicDetailUrlLinkProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicDetailUrlLinkProto clone() =>
      ComicDetailUrlLinkProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicDetailUrlLinkProto copyWith(
          void Function(ComicDetailUrlLinkProto) updates) =>
      super.copyWith((message) => updates(message as ComicDetailUrlLinkProto))
          as ComicDetailUrlLinkProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicDetailUrlLinkProto create() => ComicDetailUrlLinkProto._();
  ComicDetailUrlLinkProto createEmptyInstance() => create();
  static $pb.PbList<ComicDetailUrlLinkProto> createRepeated() =>
      $pb.PbList<ComicDetailUrlLinkProto>();
  @$core.pragma('dart2js:noInline')
  static ComicDetailUrlLinkProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicDetailUrlLinkProto>(create);
  static ComicDetailUrlLinkProto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<ComicDetailUrlProto> get list => $_getList(1);
}

class ComicDetailUrlProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicDetailUrlProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'id')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'url')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'icon')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'packageName',
        protoName: 'packageName')
    ..aOS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'dUrl',
        protoName: 'dUrl')
    ..a<$core.int>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'btype',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  ComicDetailUrlProto._() : super();
  factory ComicDetailUrlProto({
    $fixnum.Int64? id,
    $core.String? title,
    $core.String? url,
    $core.String? icon,
    $core.String? packageName,
    $core.String? dUrl,
    $core.int? btype,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (title != null) {
      _result.title = title;
    }
    if (url != null) {
      _result.url = url;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (packageName != null) {
      _result.packageName = packageName;
    }
    if (dUrl != null) {
      _result.dUrl = dUrl;
    }
    if (btype != null) {
      _result.btype = btype;
    }
    return _result;
  }
  factory ComicDetailUrlProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicDetailUrlProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicDetailUrlProto clone() => ComicDetailUrlProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicDetailUrlProto copyWith(void Function(ComicDetailUrlProto) updates) =>
      super.copyWith((message) => updates(message as ComicDetailUrlProto))
          as ComicDetailUrlProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicDetailUrlProto create() => ComicDetailUrlProto._();
  ComicDetailUrlProto createEmptyInstance() => create();
  static $pb.PbList<ComicDetailUrlProto> createRepeated() =>
      $pb.PbList<ComicDetailUrlProto>();
  @$core.pragma('dart2js:noInline')
  static ComicDetailUrlProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicDetailUrlProto>(create);
  static ComicDetailUrlProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get packageName => $_getSZ(4);
  @$pb.TagNumber(5)
  set packageName($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPackageName() => $_has(4);
  @$pb.TagNumber(5)
  void clearPackageName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set dUrl($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearDUrl() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get btype => $_getIZ(6);
  @$pb.TagNumber(7)
  set btype($core.int v) {
    $_setSignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasBtype() => $_has(6);
  @$pb.TagNumber(7)
  void clearBtype() => clearField(7);
}

class ComicRankListResponseProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicRankListResponseProto',
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
    ..pc<ComicRankListInfoProto>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        $pb.PbFieldType.PM,
        subBuilder: ComicRankListInfoProto.create)
    ..hasRequiredFields = false;

  ComicRankListResponseProto._() : super();
  factory ComicRankListResponseProto({
    $core.int? errno,
    $core.String? errmsg,
    $core.Iterable<ComicRankListInfoProto>? data,
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
  factory ComicRankListResponseProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicRankListResponseProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicRankListResponseProto clone() =>
      ComicRankListResponseProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicRankListResponseProto copyWith(
          void Function(ComicRankListResponseProto) updates) =>
      super.copyWith(
              (message) => updates(message as ComicRankListResponseProto))
          as ComicRankListResponseProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicRankListResponseProto create() => ComicRankListResponseProto._();
  ComicRankListResponseProto createEmptyInstance() => create();
  static $pb.PbList<ComicRankListResponseProto> createRepeated() =>
      $pb.PbList<ComicRankListResponseProto>();
  @$core.pragma('dart2js:noInline')
  static ComicRankListResponseProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicRankListResponseProto>(create);
  static ComicRankListResponseProto? _defaultInstance;

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
  $core.List<ComicRankListInfoProto> get data => $_getList(2);
}

class ComicRankListInfoProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicRankListInfoProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'comicId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'authors')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'status')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'cover')
    ..aOS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'types')
    ..aInt64(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdatetime')
    ..aOS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateChapterName')
    ..aOS(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'comicPy')
    ..aInt64(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'num')
    ..a<$core.int>(
        11,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'tagId',
        $pb.PbFieldType.O3)
    ..aOS(
        12,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapterName')
    ..aInt64(
        13,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapterId')
    ..hasRequiredFields = false;

  ComicRankListInfoProto._() : super();
  factory ComicRankListInfoProto({
    $fixnum.Int64? comicId,
    $core.String? title,
    $core.String? authors,
    $core.String? status,
    $core.String? cover,
    $core.String? types,
    $fixnum.Int64? lastUpdatetime,
    $core.String? lastUpdateChapterName,
    $core.String? comicPy,
    $fixnum.Int64? num,
    $core.int? tagId,
    $core.String? chapterName,
    $fixnum.Int64? chapterId,
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
  factory ComicRankListInfoProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicRankListInfoProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicRankListInfoProto clone() =>
      ComicRankListInfoProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicRankListInfoProto copyWith(
          void Function(ComicRankListInfoProto) updates) =>
      super.copyWith((message) => updates(message as ComicRankListInfoProto))
          as ComicRankListInfoProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicRankListInfoProto create() => ComicRankListInfoProto._();
  ComicRankListInfoProto createEmptyInstance() => create();
  static $pb.PbList<ComicRankListInfoProto> createRepeated() =>
      $pb.PbList<ComicRankListInfoProto>();
  @$core.pragma('dart2js:noInline')
  static ComicRankListInfoProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicRankListInfoProto>(create);
  static ComicRankListInfoProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get comicId => $_getI64(0);
  @$pb.TagNumber(1)
  set comicId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasComicId() => $_has(0);
  @$pb.TagNumber(1)
  void clearComicId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get authors => $_getSZ(2);
  @$pb.TagNumber(3)
  set authors($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAuthors() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthors() => clearField(3);

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
  $core.String get cover => $_getSZ(4);
  @$pb.TagNumber(5)
  set cover($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasCover() => $_has(4);
  @$pb.TagNumber(5)
  void clearCover() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get types => $_getSZ(5);
  @$pb.TagNumber(6)
  set types($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasTypes() => $_has(5);
  @$pb.TagNumber(6)
  void clearTypes() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get lastUpdatetime => $_getI64(6);
  @$pb.TagNumber(7)
  set lastUpdatetime($fixnum.Int64 v) {
    $_setInt64(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasLastUpdatetime() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastUpdatetime() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get lastUpdateChapterName => $_getSZ(7);
  @$pb.TagNumber(8)
  set lastUpdateChapterName($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasLastUpdateChapterName() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdateChapterName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get comicPy => $_getSZ(8);
  @$pb.TagNumber(9)
  set comicPy($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasComicPy() => $_has(8);
  @$pb.TagNumber(9)
  void clearComicPy() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get num => $_getI64(9);
  @$pb.TagNumber(10)
  set num($fixnum.Int64 v) {
    $_setInt64(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasNum() => $_has(9);
  @$pb.TagNumber(10)
  void clearNum() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get tagId => $_getIZ(10);
  @$pb.TagNumber(11)
  set tagId($core.int v) {
    $_setSignedInt32(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasTagId() => $_has(10);
  @$pb.TagNumber(11)
  void clearTagId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get chapterName => $_getSZ(11);
  @$pb.TagNumber(12)
  set chapterName($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasChapterName() => $_has(11);
  @$pb.TagNumber(12)
  void clearChapterName() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get chapterId => $_getI64(12);
  @$pb.TagNumber(13)
  set chapterId($fixnum.Int64 v) {
    $_setInt64(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasChapterId() => $_has(12);
  @$pb.TagNumber(13)
  void clearChapterId() => clearField(13);
}

class RankTypeFilterResponseProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'RankTypeFilterResponseProto',
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
    ..pc<ComicTagProto>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        $pb.PbFieldType.PM,
        subBuilder: ComicTagProto.create)
    ..hasRequiredFields = false;

  RankTypeFilterResponseProto._() : super();
  factory RankTypeFilterResponseProto({
    $core.int? errno,
    $core.String? errmsg,
    $core.Iterable<ComicTagProto>? data,
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
  factory RankTypeFilterResponseProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RankTypeFilterResponseProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RankTypeFilterResponseProto clone() =>
      RankTypeFilterResponseProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RankTypeFilterResponseProto copyWith(
          void Function(RankTypeFilterResponseProto) updates) =>
      super.copyWith(
              (message) => updates(message as RankTypeFilterResponseProto))
          as RankTypeFilterResponseProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RankTypeFilterResponseProto create() =>
      RankTypeFilterResponseProto._();
  RankTypeFilterResponseProto createEmptyInstance() => create();
  static $pb.PbList<RankTypeFilterResponseProto> createRepeated() =>
      $pb.PbList<RankTypeFilterResponseProto>();
  @$core.pragma('dart2js:noInline')
  static RankTypeFilterResponseProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RankTypeFilterResponseProto>(create);
  static RankTypeFilterResponseProto? _defaultInstance;

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
  $core.List<ComicTagProto> get data => $_getList(2);
}

class ComicUpdateListResponseProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicUpdateListResponseProto',
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
    ..pc<ComicUpdateListInfoProto>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        $pb.PbFieldType.PM,
        subBuilder: ComicUpdateListInfoProto.create)
    ..hasRequiredFields = false;

  ComicUpdateListResponseProto._() : super();
  factory ComicUpdateListResponseProto({
    $core.int? errno,
    $core.String? errmsg,
    $core.Iterable<ComicUpdateListInfoProto>? data,
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
  factory ComicUpdateListResponseProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicUpdateListResponseProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicUpdateListResponseProto clone() =>
      ComicUpdateListResponseProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicUpdateListResponseProto copyWith(
          void Function(ComicUpdateListResponseProto) updates) =>
      super.copyWith(
              (message) => updates(message as ComicUpdateListResponseProto))
          as ComicUpdateListResponseProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicUpdateListResponseProto create() =>
      ComicUpdateListResponseProto._();
  ComicUpdateListResponseProto createEmptyInstance() => create();
  static $pb.PbList<ComicUpdateListResponseProto> createRepeated() =>
      $pb.PbList<ComicUpdateListResponseProto>();
  @$core.pragma('dart2js:noInline')
  static ComicUpdateListResponseProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicUpdateListResponseProto>(create);
  static ComicUpdateListResponseProto? _defaultInstance;

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
  $core.List<ComicUpdateListInfoProto> get data => $_getList(2);
}

class ComicUpdateListInfoProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ComicUpdateListInfoProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'comicId',
        protoName: 'comicId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'islong',
        $pb.PbFieldType.O3)
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'authors')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'types')
    ..aOS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'cover')
    ..aOS(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'status')
    ..aOS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateChapterName',
        protoName: 'lastUpdateChapterName')
    ..aInt64(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdateChapterId',
        protoName: 'lastUpdateChapterId')
    ..aInt64(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lastUpdatetime',
        protoName: 'lastUpdatetime')
    ..hasRequiredFields = false;

  ComicUpdateListInfoProto._() : super();
  factory ComicUpdateListInfoProto({
    $fixnum.Int64? comicId,
    $core.String? title,
    $core.int? islong,
    $core.String? authors,
    $core.String? types,
    $core.String? cover,
    $core.String? status,
    $core.String? lastUpdateChapterName,
    $fixnum.Int64? lastUpdateChapterId,
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
  factory ComicUpdateListInfoProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ComicUpdateListInfoProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ComicUpdateListInfoProto clone() =>
      ComicUpdateListInfoProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ComicUpdateListInfoProto copyWith(
          void Function(ComicUpdateListInfoProto) updates) =>
      super.copyWith((message) => updates(message as ComicUpdateListInfoProto))
          as ComicUpdateListInfoProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComicUpdateListInfoProto create() => ComicUpdateListInfoProto._();
  ComicUpdateListInfoProto createEmptyInstance() => create();
  static $pb.PbList<ComicUpdateListInfoProto> createRepeated() =>
      $pb.PbList<ComicUpdateListInfoProto>();
  @$core.pragma('dart2js:noInline')
  static ComicUpdateListInfoProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComicUpdateListInfoProto>(create);
  static ComicUpdateListInfoProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get comicId => $_getI64(0);
  @$pb.TagNumber(1)
  set comicId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasComicId() => $_has(0);
  @$pb.TagNumber(1)
  void clearComicId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get islong => $_getIZ(2);
  @$pb.TagNumber(3)
  set islong($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIslong() => $_has(2);
  @$pb.TagNumber(3)
  void clearIslong() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get authors => $_getSZ(3);
  @$pb.TagNumber(4)
  set authors($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAuthors() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthors() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get types => $_getSZ(4);
  @$pb.TagNumber(5)
  set types($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTypes() => $_has(4);
  @$pb.TagNumber(5)
  void clearTypes() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get cover => $_getSZ(5);
  @$pb.TagNumber(6)
  set cover($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCover() => $_has(5);
  @$pb.TagNumber(6)
  void clearCover() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get lastUpdateChapterName => $_getSZ(7);
  @$pb.TagNumber(8)
  set lastUpdateChapterName($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasLastUpdateChapterName() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdateChapterName() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get lastUpdateChapterId => $_getI64(8);
  @$pb.TagNumber(9)
  set lastUpdateChapterId($fixnum.Int64 v) {
    $_setInt64(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasLastUpdateChapterId() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastUpdateChapterId() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get lastUpdatetime => $_getI64(9);
  @$pb.TagNumber(10)
  set lastUpdatetime($fixnum.Int64 v) {
    $_setInt64(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasLastUpdatetime() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastUpdatetime() => clearField(10);
}
