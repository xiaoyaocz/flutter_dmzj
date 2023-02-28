///
//  Generated code. Do not modify.
//  source: news.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class NewsListResponseProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NewsListResponseProto',
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
    ..pc<NewsListInfoProto>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        $pb.PbFieldType.PM,
        subBuilder: NewsListInfoProto.create)
    ..hasRequiredFields = false;

  NewsListResponseProto._() : super();
  factory NewsListResponseProto({
    $core.int? errno,
    $core.String? errmsg,
    $core.Iterable<NewsListInfoProto>? data,
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
  factory NewsListResponseProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NewsListResponseProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NewsListResponseProto clone() =>
      NewsListResponseProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NewsListResponseProto copyWith(
          void Function(NewsListResponseProto) updates) =>
      super.copyWith((message) => updates(message as NewsListResponseProto))
          as NewsListResponseProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NewsListResponseProto create() => NewsListResponseProto._();
  NewsListResponseProto createEmptyInstance() => create();
  static $pb.PbList<NewsListResponseProto> createRepeated() =>
      $pb.PbList<NewsListResponseProto>();
  @$core.pragma('dart2js:noInline')
  static NewsListResponseProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NewsListResponseProto>(create);
  static NewsListResponseProto? _defaultInstance;

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
  $core.List<NewsListInfoProto> get data => $_getList(2);
}

class NewsListInfoProto extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'NewsListInfoProto',
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'articleId',
        protoName: 'articleId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fromName',
        protoName: 'fromName')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fromUrl',
        protoName: 'fromUrl')
    ..aInt64(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'createTime',
        protoName: 'createTime')
    ..a<$core.int>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isForeign',
        $pb.PbFieldType.O3,
        protoName: 'isForeign')
    ..aOS(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'foreignUrl',
        protoName: 'foreignUrl')
    ..aOS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'intro')
    ..aInt64(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'authorId',
        protoName: 'authorId')
    ..a<$core.int>(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'status',
        $pb.PbFieldType.O3)
    ..aOS(
        11,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'rowPicUrl',
        protoName: 'rowPicUrl')
    ..aOS(
        12,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'colPicUrl',
        protoName: 'colPicUrl')
    ..a<$core.int>(
        13,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'qchatShow',
        $pb.PbFieldType.O3,
        protoName: 'qchatShow')
    ..aOS(
        14,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageUrl',
        protoName: 'pageUrl')
    ..aInt64(
        15,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'commentAmount',
        protoName: 'commentAmount')
    ..aInt64(
        16,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'authorUid',
        protoName: 'authorUid')
    ..aOS(
        17,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'cover')
    ..aOS(
        18,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'nickname')
    ..aInt64(
        19,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'moodAmount',
        protoName: 'moodAmount')
    ..hasRequiredFields = false;

  NewsListInfoProto._() : super();
  factory NewsListInfoProto({
    $fixnum.Int64? articleId,
    $core.String? title,
    $core.String? fromName,
    $core.String? fromUrl,
    $fixnum.Int64? createTime,
    $core.int? isForeign,
    $core.String? foreignUrl,
    $core.String? intro,
    $fixnum.Int64? authorId,
    $core.int? status,
    $core.String? rowPicUrl,
    $core.String? colPicUrl,
    $core.int? qchatShow,
    $core.String? pageUrl,
    $fixnum.Int64? commentAmount,
    $fixnum.Int64? authorUid,
    $core.String? cover,
    $core.String? nickname,
    $fixnum.Int64? moodAmount,
  }) {
    final _result = create();
    if (articleId != null) {
      _result.articleId = articleId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (fromName != null) {
      _result.fromName = fromName;
    }
    if (fromUrl != null) {
      _result.fromUrl = fromUrl;
    }
    if (createTime != null) {
      _result.createTime = createTime;
    }
    if (isForeign != null) {
      _result.isForeign = isForeign;
    }
    if (foreignUrl != null) {
      _result.foreignUrl = foreignUrl;
    }
    if (intro != null) {
      _result.intro = intro;
    }
    if (authorId != null) {
      _result.authorId = authorId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (rowPicUrl != null) {
      _result.rowPicUrl = rowPicUrl;
    }
    if (colPicUrl != null) {
      _result.colPicUrl = colPicUrl;
    }
    if (qchatShow != null) {
      _result.qchatShow = qchatShow;
    }
    if (pageUrl != null) {
      _result.pageUrl = pageUrl;
    }
    if (commentAmount != null) {
      _result.commentAmount = commentAmount;
    }
    if (authorUid != null) {
      _result.authorUid = authorUid;
    }
    if (cover != null) {
      _result.cover = cover;
    }
    if (nickname != null) {
      _result.nickname = nickname;
    }
    if (moodAmount != null) {
      _result.moodAmount = moodAmount;
    }
    return _result;
  }
  factory NewsListInfoProto.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NewsListInfoProto.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NewsListInfoProto clone() => NewsListInfoProto()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NewsListInfoProto copyWith(void Function(NewsListInfoProto) updates) =>
      super.copyWith((message) => updates(message as NewsListInfoProto))
          as NewsListInfoProto; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NewsListInfoProto create() => NewsListInfoProto._();
  NewsListInfoProto createEmptyInstance() => create();
  static $pb.PbList<NewsListInfoProto> createRepeated() =>
      $pb.PbList<NewsListInfoProto>();
  @$core.pragma('dart2js:noInline')
  static NewsListInfoProto getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NewsListInfoProto>(create);
  static NewsListInfoProto? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get articleId => $_getI64(0);
  @$pb.TagNumber(1)
  set articleId($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasArticleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearArticleId() => clearField(1);

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
  $core.String get fromName => $_getSZ(2);
  @$pb.TagNumber(3)
  set fromName($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFromName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fromUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set fromUrl($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFromUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromUrl() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get createTime => $_getI64(4);
  @$pb.TagNumber(5)
  set createTime($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasCreateTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreateTime() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get isForeign => $_getIZ(5);
  @$pb.TagNumber(6)
  set isForeign($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasIsForeign() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsForeign() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get foreignUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set foreignUrl($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasForeignUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearForeignUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get intro => $_getSZ(7);
  @$pb.TagNumber(8)
  set intro($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasIntro() => $_has(7);
  @$pb.TagNumber(8)
  void clearIntro() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get authorId => $_getI64(8);
  @$pb.TagNumber(9)
  set authorId($fixnum.Int64 v) {
    $_setInt64(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasAuthorId() => $_has(8);
  @$pb.TagNumber(9)
  void clearAuthorId() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get status => $_getIZ(9);
  @$pb.TagNumber(10)
  set status($core.int v) {
    $_setSignedInt32(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get rowPicUrl => $_getSZ(10);
  @$pb.TagNumber(11)
  set rowPicUrl($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasRowPicUrl() => $_has(10);
  @$pb.TagNumber(11)
  void clearRowPicUrl() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get colPicUrl => $_getSZ(11);
  @$pb.TagNumber(12)
  set colPicUrl($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasColPicUrl() => $_has(11);
  @$pb.TagNumber(12)
  void clearColPicUrl() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get qchatShow => $_getIZ(12);
  @$pb.TagNumber(13)
  set qchatShow($core.int v) {
    $_setSignedInt32(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasQchatShow() => $_has(12);
  @$pb.TagNumber(13)
  void clearQchatShow() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get pageUrl => $_getSZ(13);
  @$pb.TagNumber(14)
  set pageUrl($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasPageUrl() => $_has(13);
  @$pb.TagNumber(14)
  void clearPageUrl() => clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get commentAmount => $_getI64(14);
  @$pb.TagNumber(15)
  set commentAmount($fixnum.Int64 v) {
    $_setInt64(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasCommentAmount() => $_has(14);
  @$pb.TagNumber(15)
  void clearCommentAmount() => clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get authorUid => $_getI64(15);
  @$pb.TagNumber(16)
  set authorUid($fixnum.Int64 v) {
    $_setInt64(15, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasAuthorUid() => $_has(15);
  @$pb.TagNumber(16)
  void clearAuthorUid() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get cover => $_getSZ(16);
  @$pb.TagNumber(17)
  set cover($core.String v) {
    $_setString(16, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasCover() => $_has(16);
  @$pb.TagNumber(17)
  void clearCover() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get nickname => $_getSZ(17);
  @$pb.TagNumber(18)
  set nickname($core.String v) {
    $_setString(17, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasNickname() => $_has(17);
  @$pb.TagNumber(18)
  void clearNickname() => clearField(18);

  @$pb.TagNumber(19)
  $fixnum.Int64 get moodAmount => $_getI64(18);
  @$pb.TagNumber(19)
  set moodAmount($fixnum.Int64 v) {
    $_setInt64(18, v);
  }

  @$pb.TagNumber(19)
  $core.bool hasMoodAmount() => $_has(18);
  @$pb.TagNumber(19)
  void clearMoodAmount() => clearField(19);
}
