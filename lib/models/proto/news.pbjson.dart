///
//  Generated code. Do not modify.
//  source: news.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use newsListResponseProtoDescriptor instead')
const NewsListResponseProto$json = const {
  '1': 'NewsListResponseProto',
  '2': const [
    const {'1': 'errno', '3': 1, '4': 1, '5': 5, '10': 'errno'},
    const {'1': 'errmsg', '3': 2, '4': 1, '5': 9, '10': 'errmsg'},
    const {'1': 'data', '3': 3, '4': 3, '5': 11, '6': '.NewsListInfoProto', '10': 'data'},
  ],
};

/// Descriptor for `NewsListResponseProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newsListResponseProtoDescriptor = $convert.base64Decode('ChVOZXdzTGlzdFJlc3BvbnNlUHJvdG8SFAoFZXJybm8YASABKAVSBWVycm5vEhYKBmVycm1zZxgCIAEoCVIGZXJybXNnEiYKBGRhdGEYAyADKAsyEi5OZXdzTGlzdEluZm9Qcm90b1IEZGF0YQ==');
@$core.Deprecated('Use newsListInfoProtoDescriptor instead')
const NewsListInfoProto$json = const {
  '1': 'NewsListInfoProto',
  '2': const [
    const {'1': 'articleId', '3': 1, '4': 1, '5': 3, '10': 'articleId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'fromName', '3': 3, '4': 1, '5': 9, '10': 'fromName'},
    const {'1': 'fromUrl', '3': 4, '4': 1, '5': 9, '10': 'fromUrl'},
    const {'1': 'createTime', '3': 5, '4': 1, '5': 3, '10': 'createTime'},
    const {'1': 'isForeign', '3': 6, '4': 1, '5': 5, '10': 'isForeign'},
    const {'1': 'foreignUrl', '3': 7, '4': 1, '5': 9, '10': 'foreignUrl'},
    const {'1': 'intro', '3': 8, '4': 1, '5': 9, '10': 'intro'},
    const {'1': 'authorId', '3': 9, '4': 1, '5': 3, '10': 'authorId'},
    const {'1': 'status', '3': 10, '4': 1, '5': 5, '10': 'status'},
    const {'1': 'rowPicUrl', '3': 11, '4': 1, '5': 9, '10': 'rowPicUrl'},
    const {'1': 'colPicUrl', '3': 12, '4': 1, '5': 9, '10': 'colPicUrl'},
    const {'1': 'qchatShow', '3': 13, '4': 1, '5': 5, '10': 'qchatShow'},
    const {'1': 'pageUrl', '3': 14, '4': 1, '5': 9, '10': 'pageUrl'},
    const {'1': 'commentAmount', '3': 15, '4': 1, '5': 3, '10': 'commentAmount'},
    const {'1': 'authorUid', '3': 16, '4': 1, '5': 3, '10': 'authorUid'},
    const {'1': 'cover', '3': 17, '4': 1, '5': 9, '10': 'cover'},
    const {'1': 'nickname', '3': 18, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'moodAmount', '3': 19, '4': 1, '5': 3, '10': 'moodAmount'},
  ],
};

/// Descriptor for `NewsListInfoProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newsListInfoProtoDescriptor = $convert.base64Decode('ChFOZXdzTGlzdEluZm9Qcm90bxIcCglhcnRpY2xlSWQYASABKANSCWFydGljbGVJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSGgoIZnJvbU5hbWUYAyABKAlSCGZyb21OYW1lEhgKB2Zyb21VcmwYBCABKAlSB2Zyb21VcmwSHgoKY3JlYXRlVGltZRgFIAEoA1IKY3JlYXRlVGltZRIcCglpc0ZvcmVpZ24YBiABKAVSCWlzRm9yZWlnbhIeCgpmb3JlaWduVXJsGAcgASgJUgpmb3JlaWduVXJsEhQKBWludHJvGAggASgJUgVpbnRybxIaCghhdXRob3JJZBgJIAEoA1IIYXV0aG9ySWQSFgoGc3RhdHVzGAogASgFUgZzdGF0dXMSHAoJcm93UGljVXJsGAsgASgJUglyb3dQaWNVcmwSHAoJY29sUGljVXJsGAwgASgJUgljb2xQaWNVcmwSHAoJcWNoYXRTaG93GA0gASgFUglxY2hhdFNob3cSGAoHcGFnZVVybBgOIAEoCVIHcGFnZVVybBIkCg1jb21tZW50QW1vdW50GA8gASgDUg1jb21tZW50QW1vdW50EhwKCWF1dGhvclVpZBgQIAEoA1IJYXV0aG9yVWlkEhQKBWNvdmVyGBEgASgJUgVjb3ZlchIaCghuaWNrbmFtZRgSIAEoCVIIbmlja25hbWUSHgoKbW9vZEFtb3VudBgTIAEoA1IKbW9vZEFtb3VudA==');
