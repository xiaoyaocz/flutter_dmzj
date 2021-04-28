///
//  Generated code. Do not modify.
//  source: lib/protobuf/comic/update_list_response.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use comicUpdateListResponseDescriptor instead')
const ComicUpdateListResponse$json = const {
  '1': 'ComicUpdateListResponse',
  '2': const [
    const {'1': 'Errno', '3': 1, '4': 1, '5': 5, '10': 'Errno'},
    const {'1': 'Errmsg', '3': 2, '4': 1, '5': 9, '10': 'Errmsg'},
    const {'1': 'Data', '3': 3, '4': 3, '5': 11, '6': '.dmzj.comic.ComicUpdateListItemResponse', '10': 'Data'},
  ],
};

/// Descriptor for `ComicUpdateListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicUpdateListResponseDescriptor = $convert.base64Decode('ChdDb21pY1VwZGF0ZUxpc3RSZXNwb25zZRIUCgVFcnJubxgBIAEoBVIFRXJybm8SFgoGRXJybXNnGAIgASgJUgZFcnJtc2cSOwoERGF0YRgDIAMoCzInLmRtemouY29taWMuQ29taWNVcGRhdGVMaXN0SXRlbVJlc3BvbnNlUgREYXRh');
@$core.Deprecated('Use comicUpdateListItemResponseDescriptor instead')
const ComicUpdateListItemResponse$json = const {
  '1': 'ComicUpdateListItemResponse',
  '2': const [
    const {'1': 'ComicId', '3': 1, '4': 1, '5': 5, '10': 'ComicId'},
    const {'1': 'Title', '3': 2, '4': 1, '5': 9, '10': 'Title'},
    const {'1': 'Islong', '3': 3, '4': 1, '5': 8, '10': 'Islong'},
    const {'1': 'Authors', '3': 4, '4': 1, '5': 9, '10': 'Authors'},
    const {'1': 'Types', '3': 5, '4': 1, '5': 9, '10': 'Types'},
    const {'1': 'Cover', '3': 6, '4': 1, '5': 9, '10': 'Cover'},
    const {'1': 'Status', '3': 7, '4': 1, '5': 9, '10': 'Status'},
    const {'1': 'LastUpdateChapterName', '3': 8, '4': 1, '5': 9, '10': 'LastUpdateChapterName'},
    const {'1': 'LastUpdateChapterId', '3': 9, '4': 1, '5': 5, '10': 'LastUpdateChapterId'},
    const {'1': 'LastUpdatetime', '3': 10, '4': 1, '5': 3, '10': 'LastUpdatetime'},
  ],
};

/// Descriptor for `ComicUpdateListItemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicUpdateListItemResponseDescriptor = $convert.base64Decode('ChtDb21pY1VwZGF0ZUxpc3RJdGVtUmVzcG9uc2USGAoHQ29taWNJZBgBIAEoBVIHQ29taWNJZBIUCgVUaXRsZRgCIAEoCVIFVGl0bGUSFgoGSXNsb25nGAMgASgIUgZJc2xvbmcSGAoHQXV0aG9ycxgEIAEoCVIHQXV0aG9ycxIUCgVUeXBlcxgFIAEoCVIFVHlwZXMSFAoFQ292ZXIYBiABKAlSBUNvdmVyEhYKBlN0YXR1cxgHIAEoCVIGU3RhdHVzEjQKFUxhc3RVcGRhdGVDaGFwdGVyTmFtZRgIIAEoCVIVTGFzdFVwZGF0ZUNoYXB0ZXJOYW1lEjAKE0xhc3RVcGRhdGVDaGFwdGVySWQYCSABKAVSE0xhc3RVcGRhdGVDaGFwdGVySWQSJgoOTGFzdFVwZGF0ZXRpbWUYCiABKANSDkxhc3RVcGRhdGV0aW1l');
