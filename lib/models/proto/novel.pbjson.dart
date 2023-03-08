///
//  Generated code. Do not modify.
//  source: novel.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use novelChapterDetailProtoDescriptor instead')
const NovelChapterDetailProto$json = const {
  '1': 'NovelChapterDetailProto',
  '2': const [
    const {'1': 'chapterId', '3': 1, '4': 1, '5': 3, '10': 'chapterId'},
    const {'1': 'chapterName', '3': 2, '4': 1, '5': 9, '10': 'chapterName'},
    const {'1': 'chapterOrder', '3': 3, '4': 1, '5': 5, '10': 'chapterOrder'},
  ],
};

/// Descriptor for `NovelChapterDetailProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List novelChapterDetailProtoDescriptor = $convert.base64Decode('ChdOb3ZlbENoYXB0ZXJEZXRhaWxQcm90bxIcCgljaGFwdGVySWQYASABKANSCWNoYXB0ZXJJZBIgCgtjaGFwdGVyTmFtZRgCIAEoCVILY2hhcHRlck5hbWUSIgoMY2hhcHRlck9yZGVyGAMgASgFUgxjaGFwdGVyT3JkZXI=');
@$core.Deprecated('Use novelVolumeProtoDescriptor instead')
const NovelVolumeProto$json = const {
  '1': 'NovelVolumeProto',
  '2': const [
    const {'1': 'volume_id', '3': 1, '4': 1, '5': 3, '10': 'volumeId'},
    const {'1': 'lnovel_id', '3': 2, '4': 1, '5': 3, '10': 'lnovelId'},
    const {'1': 'volume_name', '3': 3, '4': 1, '5': 9, '10': 'volumeName'},
    const {'1': 'volume_order', '3': 4, '4': 1, '5': 5, '10': 'volumeOrder'},
    const {'1': 'addtime', '3': 5, '4': 1, '5': 3, '10': 'addtime'},
    const {'1': 'sum_chapters', '3': 6, '4': 1, '5': 5, '10': 'sumChapters'},
  ],
};

/// Descriptor for `NovelVolumeProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List novelVolumeProtoDescriptor = $convert.base64Decode('ChBOb3ZlbFZvbHVtZVByb3RvEhsKCXZvbHVtZV9pZBgBIAEoA1IIdm9sdW1lSWQSGwoJbG5vdmVsX2lkGAIgASgDUghsbm92ZWxJZBIfCgt2b2x1bWVfbmFtZRgDIAEoCVIKdm9sdW1lTmFtZRIhCgx2b2x1bWVfb3JkZXIYBCABKAVSC3ZvbHVtZU9yZGVyEhgKB2FkZHRpbWUYBSABKANSB2FkZHRpbWUSIQoMc3VtX2NoYXB0ZXJzGAYgASgFUgtzdW1DaGFwdGVycw==');
@$core.Deprecated('Use novelChapterResponseProtoDescriptor instead')
const NovelChapterResponseProto$json = const {
  '1': 'NovelChapterResponseProto',
  '2': const [
    const {'1': 'errno', '3': 1, '4': 1, '5': 5, '10': 'errno'},
    const {'1': 'errmsg', '3': 2, '4': 1, '5': 9, '10': 'errmsg'},
    const {'1': 'data', '3': 3, '4': 3, '5': 11, '6': '.NovelVolumeDetailProto', '10': 'data'},
  ],
};

/// Descriptor for `NovelChapterResponseProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List novelChapterResponseProtoDescriptor = $convert.base64Decode('ChlOb3ZlbENoYXB0ZXJSZXNwb25zZVByb3RvEhQKBWVycm5vGAEgASgFUgVlcnJubxIWCgZlcnJtc2cYAiABKAlSBmVycm1zZxIrCgRkYXRhGAMgAygLMhcuTm92ZWxWb2x1bWVEZXRhaWxQcm90b1IEZGF0YQ==');
@$core.Deprecated('Use novelVolumeDetailProtoDescriptor instead')
const NovelVolumeDetailProto$json = const {
  '1': 'NovelVolumeDetailProto',
  '2': const [
    const {'1': 'volume_id', '3': 1, '4': 1, '5': 3, '10': 'volumeId'},
    const {'1': 'volume_name', '3': 2, '4': 1, '5': 9, '10': 'volumeName'},
    const {'1': 'volume_order', '3': 3, '4': 1, '5': 5, '10': 'volumeOrder'},
    const {'1': 'chapters', '3': 4, '4': 3, '5': 11, '6': '.NovelChapterDetailProto', '10': 'chapters'},
  ],
};

/// Descriptor for `NovelVolumeDetailProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List novelVolumeDetailProtoDescriptor = $convert.base64Decode('ChZOb3ZlbFZvbHVtZURldGFpbFByb3RvEhsKCXZvbHVtZV9pZBgBIAEoA1IIdm9sdW1lSWQSHwoLdm9sdW1lX25hbWUYAiABKAlSCnZvbHVtZU5hbWUSIQoMdm9sdW1lX29yZGVyGAMgASgFUgt2b2x1bWVPcmRlchI0CghjaGFwdGVycxgEIAMoCzIYLk5vdmVsQ2hhcHRlckRldGFpbFByb3RvUghjaGFwdGVycw==');
@$core.Deprecated('Use novelDetailProtoDescriptor instead')
const NovelDetailProto$json = const {
  '1': 'NovelDetailProto',
  '2': const [
    const {'1': 'novel_id', '3': 1, '4': 1, '5': 3, '10': 'novelId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'zone', '3': 3, '4': 1, '5': 9, '10': 'zone'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'last_update_volume_name', '3': 5, '4': 1, '5': 9, '10': 'lastUpdateVolumeName'},
    const {'1': 'last_update_chapter_name', '3': 6, '4': 1, '5': 9, '10': 'lastUpdateChapterName'},
    const {'1': 'last_update_volume_id', '3': 7, '4': 1, '5': 3, '10': 'lastUpdateVolumeId'},
    const {'1': 'last_update_chapter_id', '3': 8, '4': 1, '5': 3, '10': 'lastUpdateChapterId'},
    const {'1': 'last_update_time', '3': 9, '4': 1, '5': 3, '10': 'lastUpdateTime'},
    const {'1': 'cover', '3': 10, '4': 1, '5': 9, '10': 'cover'},
    const {'1': 'hot_hits', '3': 11, '4': 1, '5': 3, '10': 'hotHits'},
    const {'1': 'introduction', '3': 12, '4': 1, '5': 9, '10': 'introduction'},
    const {'1': 'types', '3': 13, '4': 3, '5': 9, '10': 'types'},
    const {'1': 'authors', '3': 14, '4': 1, '5': 9, '10': 'authors'},
    const {'1': 'first_letter', '3': 15, '4': 1, '5': 9, '10': 'firstLetter'},
    const {'1': 'subscribe_num', '3': 16, '4': 1, '5': 3, '10': 'subscribeNum'},
    const {'1': 'redis_update_time', '3': 17, '4': 1, '5': 3, '10': 'redisUpdateTime'},
    const {'1': 'volume', '3': 18, '4': 3, '5': 11, '6': '.NovelVolumeProto', '10': 'volume'},
  ],
};

/// Descriptor for `NovelDetailProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List novelDetailProtoDescriptor = $convert.base64Decode('ChBOb3ZlbERldGFpbFByb3RvEhkKCG5vdmVsX2lkGAEgASgDUgdub3ZlbElkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEem9uZRgDIAEoCVIEem9uZRIWCgZzdGF0dXMYBCABKAlSBnN0YXR1cxI1ChdsYXN0X3VwZGF0ZV92b2x1bWVfbmFtZRgFIAEoCVIUbGFzdFVwZGF0ZVZvbHVtZU5hbWUSNwoYbGFzdF91cGRhdGVfY2hhcHRlcl9uYW1lGAYgASgJUhVsYXN0VXBkYXRlQ2hhcHRlck5hbWUSMQoVbGFzdF91cGRhdGVfdm9sdW1lX2lkGAcgASgDUhJsYXN0VXBkYXRlVm9sdW1lSWQSMwoWbGFzdF91cGRhdGVfY2hhcHRlcl9pZBgIIAEoA1ITbGFzdFVwZGF0ZUNoYXB0ZXJJZBIoChBsYXN0X3VwZGF0ZV90aW1lGAkgASgDUg5sYXN0VXBkYXRlVGltZRIUCgVjb3ZlchgKIAEoCVIFY292ZXISGQoIaG90X2hpdHMYCyABKANSB2hvdEhpdHMSIgoMaW50cm9kdWN0aW9uGAwgASgJUgxpbnRyb2R1Y3Rpb24SFAoFdHlwZXMYDSADKAlSBXR5cGVzEhgKB2F1dGhvcnMYDiABKAlSB2F1dGhvcnMSIQoMZmlyc3RfbGV0dGVyGA8gASgJUgtmaXJzdExldHRlchIjCg1zdWJzY3JpYmVfbnVtGBAgASgDUgxzdWJzY3JpYmVOdW0SKgoRcmVkaXNfdXBkYXRlX3RpbWUYESABKANSD3JlZGlzVXBkYXRlVGltZRIpCgZ2b2x1bWUYEiADKAsyES5Ob3ZlbFZvbHVtZVByb3RvUgZ2b2x1bWU=');
@$core.Deprecated('Use novelDetailResponseProtoDescriptor instead')
const NovelDetailResponseProto$json = const {
  '1': 'NovelDetailResponseProto',
  '2': const [
    const {'1': 'errno', '3': 1, '4': 1, '5': 5, '10': 'errno'},
    const {'1': 'errmsg', '3': 2, '4': 1, '5': 9, '10': 'errmsg'},
    const {'1': 'data', '3': 3, '4': 1, '5': 11, '6': '.NovelDetailProto', '10': 'data'},
  ],
};

/// Descriptor for `NovelDetailResponseProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List novelDetailResponseProtoDescriptor = $convert.base64Decode('ChhOb3ZlbERldGFpbFJlc3BvbnNlUHJvdG8SFAoFZXJybm8YASABKAVSBWVycm5vEhYKBmVycm1zZxgCIAEoCVIGZXJybXNnEiUKBGRhdGEYAyABKAsyES5Ob3ZlbERldGFpbFByb3RvUgRkYXRh');
