///
//  Generated code. Do not modify.
//  source: comic.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use comicChapterDetailProtoDescriptor instead')
const ComicChapterDetailProto$json = const {
  '1': 'ComicChapterDetailProto',
  '2': const [
    const {'1': 'chapterId', '3': 1, '4': 1, '5': 3, '10': 'chapterId'},
    const {'1': 'comicId', '3': 2, '4': 1, '5': 3, '10': 'comicId'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'chapterOrder', '3': 4, '4': 1, '5': 5, '10': 'chapterOrder'},
    const {'1': 'direction', '3': 5, '4': 1, '5': 5, '10': 'direction'},
    const {'1': 'pageUrl', '3': 6, '4': 3, '5': 9, '10': 'pageUrl'},
    const {'1': 'picnum', '3': 7, '4': 1, '5': 5, '10': 'picnum'},
    const {'1': 'pageUrlHD', '3': 8, '4': 3, '5': 9, '10': 'pageUrlHD'},
    const {'1': 'commentCount', '3': 9, '4': 1, '5': 5, '10': 'commentCount'},
  ],
};

/// Descriptor for `ComicChapterDetailProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicChapterDetailProtoDescriptor = $convert.base64Decode('ChdDb21pY0NoYXB0ZXJEZXRhaWxQcm90bxIcCgljaGFwdGVySWQYASABKANSCWNoYXB0ZXJJZBIYCgdjb21pY0lkGAIgASgDUgdjb21pY0lkEhQKBXRpdGxlGAMgASgJUgV0aXRsZRIiCgxjaGFwdGVyT3JkZXIYBCABKAVSDGNoYXB0ZXJPcmRlchIcCglkaXJlY3Rpb24YBSABKAVSCWRpcmVjdGlvbhIYCgdwYWdlVXJsGAYgAygJUgdwYWdlVXJsEhYKBnBpY251bRgHIAEoBVIGcGljbnVtEhwKCXBhZ2VVcmxIRBgIIAMoCVIJcGFnZVVybEhEEiIKDGNvbW1lbnRDb3VudBgJIAEoBVIMY29tbWVudENvdW50');
@$core.Deprecated('Use comicChapterInfoProtoDescriptor instead')
const ComicChapterInfoProto$json = const {
  '1': 'ComicChapterInfoProto',
  '2': const [
    const {'1': 'chapterId', '3': 1, '4': 1, '5': 3, '10': 'chapterId'},
    const {'1': 'chapterTitle', '3': 2, '4': 1, '5': 9, '10': 'chapterTitle'},
    const {'1': 'updateTime', '3': 3, '4': 1, '5': 3, '10': 'updateTime'},
    const {'1': 'fileSize', '3': 4, '4': 1, '5': 5, '10': 'fileSize'},
    const {'1': 'chapterOrder', '3': 5, '4': 1, '5': 5, '10': 'chapterOrder'},
    const {'1': 'isFee', '3': 6, '4': 1, '5': 5, '10': 'isFee'},
  ],
};

/// Descriptor for `ComicChapterInfoProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicChapterInfoProtoDescriptor = $convert.base64Decode('ChVDb21pY0NoYXB0ZXJJbmZvUHJvdG8SHAoJY2hhcHRlcklkGAEgASgDUgljaGFwdGVySWQSIgoMY2hhcHRlclRpdGxlGAIgASgJUgxjaGFwdGVyVGl0bGUSHgoKdXBkYXRlVGltZRgDIAEoA1IKdXBkYXRlVGltZRIaCghmaWxlU2l6ZRgEIAEoBVIIZmlsZVNpemUSIgoMY2hhcHRlck9yZGVyGAUgASgFUgxjaGFwdGVyT3JkZXISFAoFaXNGZWUYBiABKAVSBWlzRmVl');
@$core.Deprecated('Use comicChapterResponseProtoDescriptor instead')
const ComicChapterResponseProto$json = const {
  '1': 'ComicChapterResponseProto',
  '2': const [
    const {'1': 'errno', '3': 1, '4': 1, '5': 5, '10': 'errno'},
    const {'1': 'errmsg', '3': 2, '4': 1, '5': 9, '10': 'errmsg'},
    const {'1': 'data', '3': 3, '4': 1, '5': 11, '6': '.ComicChapterDetailProto', '10': 'data'},
  ],
};

/// Descriptor for `ComicChapterResponseProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicChapterResponseProtoDescriptor = $convert.base64Decode('ChlDb21pY0NoYXB0ZXJSZXNwb25zZVByb3RvEhQKBWVycm5vGAEgASgFUgVlcnJubxIWCgZlcnJtc2cYAiABKAlSBmVycm1zZxIsCgRkYXRhGAMgASgLMhguQ29taWNDaGFwdGVyRGV0YWlsUHJvdG9SBGRhdGE=');
@$core.Deprecated('Use comicChapterListProtoDescriptor instead')
const ComicChapterListProto$json = const {
  '1': 'ComicChapterListProto',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'data', '3': 2, '4': 3, '5': 11, '6': '.ComicChapterInfoProto', '10': 'data'},
  ],
};

/// Descriptor for `ComicChapterListProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicChapterListProtoDescriptor = $convert.base64Decode('ChVDb21pY0NoYXB0ZXJMaXN0UHJvdG8SFAoFdGl0bGUYASABKAlSBXRpdGxlEioKBGRhdGEYAiADKAsyFi5Db21pY0NoYXB0ZXJJbmZvUHJvdG9SBGRhdGE=');
@$core.Deprecated('Use comicDetailResponseProtoDescriptor instead')
const ComicDetailResponseProto$json = const {
  '1': 'ComicDetailResponseProto',
  '2': const [
    const {'1': 'errno', '3': 1, '4': 1, '5': 5, '10': 'errno'},
    const {'1': 'errmsg', '3': 2, '4': 1, '5': 9, '10': 'errmsg'},
    const {'1': 'data', '3': 3, '4': 1, '5': 11, '6': '.ComicDetailProto', '10': 'data'},
  ],
};

/// Descriptor for `ComicDetailResponseProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicDetailResponseProtoDescriptor = $convert.base64Decode('ChhDb21pY0RldGFpbFJlc3BvbnNlUHJvdG8SFAoFZXJybm8YASABKAVSBWVycm5vEhYKBmVycm1zZxgCIAEoCVIGZXJybXNnEiUKBGRhdGEYAyABKAsyES5Db21pY0RldGFpbFByb3RvUgRkYXRh');
@$core.Deprecated('Use comicDetailProtoDescriptor instead')
const ComicDetailProto$json = const {
  '1': 'ComicDetailProto',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 5, '10': 'direction'},
    const {'1': 'islong', '3': 4, '4': 1, '5': 5, '10': 'islong'},
    const {'1': 'isDmzj', '3': 5, '4': 1, '5': 5, '10': 'isDmzj'},
    const {'1': 'cover', '3': 6, '4': 1, '5': 9, '10': 'cover'},
    const {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'lastUpdatetime', '3': 8, '4': 1, '5': 3, '10': 'lastUpdatetime'},
    const {'1': 'lastUpdateChapterName', '3': 9, '4': 1, '5': 9, '10': 'lastUpdateChapterName'},
    const {'1': 'copyright', '3': 10, '4': 1, '5': 5, '10': 'copyright'},
    const {'1': 'firstLetter', '3': 11, '4': 1, '5': 9, '10': 'firstLetter'},
    const {'1': 'comicPy', '3': 12, '4': 1, '5': 9, '10': 'comicPy'},
    const {'1': 'hidden', '3': 13, '4': 1, '5': 5, '10': 'hidden'},
    const {'1': 'hotNum', '3': 14, '4': 1, '5': 3, '10': 'hotNum'},
    const {'1': 'hitNum', '3': 15, '4': 1, '5': 3, '10': 'hitNum'},
    const {'1': 'uid', '3': 16, '4': 1, '5': 3, '10': 'uid'},
    const {'1': 'isLock', '3': 17, '4': 1, '5': 5, '10': 'isLock'},
    const {'1': 'lastUpdateChapterId', '3': 18, '4': 1, '5': 5, '10': 'lastUpdateChapterId'},
    const {'1': 'types', '3': 19, '4': 3, '5': 11, '6': '.ComicTagProto', '10': 'types'},
    const {'1': 'status', '3': 20, '4': 3, '5': 11, '6': '.ComicTagProto', '10': 'status'},
    const {'1': 'authors', '3': 21, '4': 3, '5': 11, '6': '.ComicTagProto', '10': 'authors'},
    const {'1': 'subscribeNum', '3': 22, '4': 1, '5': 3, '10': 'subscribeNum'},
    const {'1': 'chapters', '3': 23, '4': 3, '5': 11, '6': '.ComicChapterListProto', '10': 'chapters'},
    const {'1': 'isNeedLogin', '3': 24, '4': 1, '5': 5, '10': 'isNeedLogin'},
    const {'1': 'urlLinks', '3': 25, '4': 3, '5': 11, '6': '.ComicDetailUrlLinkProto', '10': 'urlLinks'},
    const {'1': 'isHideChapter', '3': 26, '4': 1, '5': 5, '10': 'isHideChapter'},
    const {'1': 'dhUrlLinks', '3': 27, '4': 3, '5': 11, '6': '.ComicDetailUrlLinkProto', '10': 'dhUrlLinks'},
    const {'1': 'cornerMark', '3': 28, '4': 1, '5': 9, '10': 'cornerMark'},
    const {'1': 'isFee', '3': 29, '4': 1, '5': 5, '10': 'isFee'},
  ],
};

/// Descriptor for `ComicDetailProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicDetailProtoDescriptor = $convert.base64Decode('ChBDb21pY0RldGFpbFByb3RvEg4KAmlkGAEgASgDUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSHAoJZGlyZWN0aW9uGAMgASgFUglkaXJlY3Rpb24SFgoGaXNsb25nGAQgASgFUgZpc2xvbmcSFgoGaXNEbXpqGAUgASgFUgZpc0RtemoSFAoFY292ZXIYBiABKAlSBWNvdmVyEiAKC2Rlc2NyaXB0aW9uGAcgASgJUgtkZXNjcmlwdGlvbhImCg5sYXN0VXBkYXRldGltZRgIIAEoA1IObGFzdFVwZGF0ZXRpbWUSNAoVbGFzdFVwZGF0ZUNoYXB0ZXJOYW1lGAkgASgJUhVsYXN0VXBkYXRlQ2hhcHRlck5hbWUSHAoJY29weXJpZ2h0GAogASgFUgljb3B5cmlnaHQSIAoLZmlyc3RMZXR0ZXIYCyABKAlSC2ZpcnN0TGV0dGVyEhgKB2NvbWljUHkYDCABKAlSB2NvbWljUHkSFgoGaGlkZGVuGA0gASgFUgZoaWRkZW4SFgoGaG90TnVtGA4gASgDUgZob3ROdW0SFgoGaGl0TnVtGA8gASgDUgZoaXROdW0SEAoDdWlkGBAgASgDUgN1aWQSFgoGaXNMb2NrGBEgASgFUgZpc0xvY2sSMAoTbGFzdFVwZGF0ZUNoYXB0ZXJJZBgSIAEoBVITbGFzdFVwZGF0ZUNoYXB0ZXJJZBIkCgV0eXBlcxgTIAMoCzIOLkNvbWljVGFnUHJvdG9SBXR5cGVzEiYKBnN0YXR1cxgUIAMoCzIOLkNvbWljVGFnUHJvdG9SBnN0YXR1cxIoCgdhdXRob3JzGBUgAygLMg4uQ29taWNUYWdQcm90b1IHYXV0aG9ycxIiCgxzdWJzY3JpYmVOdW0YFiABKANSDHN1YnNjcmliZU51bRIyCghjaGFwdGVycxgXIAMoCzIWLkNvbWljQ2hhcHRlckxpc3RQcm90b1IIY2hhcHRlcnMSIAoLaXNOZWVkTG9naW4YGCABKAVSC2lzTmVlZExvZ2luEjQKCHVybExpbmtzGBkgAygLMhguQ29taWNEZXRhaWxVcmxMaW5rUHJvdG9SCHVybExpbmtzEiQKDWlzSGlkZUNoYXB0ZXIYGiABKAVSDWlzSGlkZUNoYXB0ZXISOAoKZGhVcmxMaW5rcxgbIAMoCzIYLkNvbWljRGV0YWlsVXJsTGlua1Byb3RvUgpkaFVybExpbmtzEh4KCmNvcm5lck1hcmsYHCABKAlSCmNvcm5lck1hcmsSFAoFaXNGZWUYHSABKAVSBWlzRmVl');
@$core.Deprecated('Use comicTagProtoDescriptor instead')
const ComicTagProto$json = const {
  '1': 'ComicTagProto',
  '2': const [
    const {'1': 'tagId', '3': 1, '4': 1, '5': 3, '10': 'tagId'},
    const {'1': 'tagName', '3': 2, '4': 1, '5': 9, '10': 'tagName'},
  ],
};

/// Descriptor for `ComicTagProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicTagProtoDescriptor = $convert.base64Decode('Cg1Db21pY1RhZ1Byb3RvEhQKBXRhZ0lkGAEgASgDUgV0YWdJZBIYCgd0YWdOYW1lGAIgASgJUgd0YWdOYW1l');
@$core.Deprecated('Use comicDetailUrlLinkProtoDescriptor instead')
const ComicDetailUrlLinkProto$json = const {
  '1': 'ComicDetailUrlLinkProto',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'list', '3': 2, '4': 3, '5': 11, '6': '.ComicDetailUrlProto', '10': 'list'},
  ],
};

/// Descriptor for `ComicDetailUrlLinkProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicDetailUrlLinkProtoDescriptor = $convert.base64Decode('ChdDb21pY0RldGFpbFVybExpbmtQcm90bxIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSKAoEbGlzdBgCIAMoCzIULkNvbWljRGV0YWlsVXJsUHJvdG9SBGxpc3Q=');
@$core.Deprecated('Use comicDetailUrlProtoDescriptor instead')
const ComicDetailUrlProto$json = const {
  '1': 'ComicDetailUrlProto',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'icon', '3': 4, '4': 1, '5': 9, '10': 'icon'},
    const {'1': 'packageName', '3': 5, '4': 1, '5': 9, '10': 'packageName'},
    const {'1': 'dUrl', '3': 6, '4': 1, '5': 9, '10': 'dUrl'},
    const {'1': 'btype', '3': 7, '4': 1, '5': 5, '10': 'btype'},
  ],
};

/// Descriptor for `ComicDetailUrlProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicDetailUrlProtoDescriptor = $convert.base64Decode('ChNDb21pY0RldGFpbFVybFByb3RvEg4KAmlkGAEgASgDUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSEAoDdXJsGAMgASgJUgN1cmwSEgoEaWNvbhgEIAEoCVIEaWNvbhIgCgtwYWNrYWdlTmFtZRgFIAEoCVILcGFja2FnZU5hbWUSEgoEZFVybBgGIAEoCVIEZFVybBIUCgVidHlwZRgHIAEoBVIFYnR5cGU=');
@$core.Deprecated('Use comicRankListResponseProtoDescriptor instead')
const ComicRankListResponseProto$json = const {
  '1': 'ComicRankListResponseProto',
  '2': const [
    const {'1': 'errno', '3': 1, '4': 1, '5': 5, '10': 'errno'},
    const {'1': 'errmsg', '3': 2, '4': 1, '5': 9, '10': 'errmsg'},
    const {'1': 'data', '3': 3, '4': 3, '5': 11, '6': '.ComicRankListInfoProto', '10': 'data'},
  ],
};

/// Descriptor for `ComicRankListResponseProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicRankListResponseProtoDescriptor = $convert.base64Decode('ChpDb21pY1JhbmtMaXN0UmVzcG9uc2VQcm90bxIUCgVlcnJubxgBIAEoBVIFZXJybm8SFgoGZXJybXNnGAIgASgJUgZlcnJtc2cSKwoEZGF0YRgDIAMoCzIXLkNvbWljUmFua0xpc3RJbmZvUHJvdG9SBGRhdGE=');
@$core.Deprecated('Use comicRankListInfoProtoDescriptor instead')
const ComicRankListInfoProto$json = const {
  '1': 'ComicRankListInfoProto',
  '2': const [
    const {'1': 'comic_id', '3': 1, '4': 1, '5': 3, '10': 'comicId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'authors', '3': 3, '4': 1, '5': 9, '10': 'authors'},
    const {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'cover', '3': 5, '4': 1, '5': 9, '10': 'cover'},
    const {'1': 'types', '3': 6, '4': 1, '5': 9, '10': 'types'},
    const {'1': 'last_updatetime', '3': 7, '4': 1, '5': 3, '10': 'lastUpdatetime'},
    const {'1': 'last_update_chapter_name', '3': 8, '4': 1, '5': 9, '10': 'lastUpdateChapterName'},
    const {'1': 'comic_py', '3': 9, '4': 1, '5': 9, '10': 'comicPy'},
    const {'1': 'num', '3': 10, '4': 1, '5': 3, '10': 'num'},
    const {'1': 'tag_id', '3': 11, '4': 1, '5': 5, '10': 'tagId'},
    const {'1': 'chapter_name', '3': 12, '4': 1, '5': 9, '10': 'chapterName'},
    const {'1': 'chapter_id', '3': 13, '4': 1, '5': 3, '10': 'chapterId'},
  ],
};

/// Descriptor for `ComicRankListInfoProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicRankListInfoProtoDescriptor = $convert.base64Decode('ChZDb21pY1JhbmtMaXN0SW5mb1Byb3RvEhkKCGNvbWljX2lkGAEgASgDUgdjb21pY0lkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIYCgdhdXRob3JzGAMgASgJUgdhdXRob3JzEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVzEhQKBWNvdmVyGAUgASgJUgVjb3ZlchIUCgV0eXBlcxgGIAEoCVIFdHlwZXMSJwoPbGFzdF91cGRhdGV0aW1lGAcgASgDUg5sYXN0VXBkYXRldGltZRI3ChhsYXN0X3VwZGF0ZV9jaGFwdGVyX25hbWUYCCABKAlSFWxhc3RVcGRhdGVDaGFwdGVyTmFtZRIZCghjb21pY19weRgJIAEoCVIHY29taWNQeRIQCgNudW0YCiABKANSA251bRIVCgZ0YWdfaWQYCyABKAVSBXRhZ0lkEiEKDGNoYXB0ZXJfbmFtZRgMIAEoCVILY2hhcHRlck5hbWUSHQoKY2hhcHRlcl9pZBgNIAEoA1IJY2hhcHRlcklk');
@$core.Deprecated('Use rankTypeFilterResponseProtoDescriptor instead')
const RankTypeFilterResponseProto$json = const {
  '1': 'RankTypeFilterResponseProto',
  '2': const [
    const {'1': 'errno', '3': 1, '4': 1, '5': 5, '10': 'errno'},
    const {'1': 'errmsg', '3': 2, '4': 1, '5': 9, '10': 'errmsg'},
    const {'1': 'data', '3': 3, '4': 3, '5': 11, '6': '.ComicTagProto', '10': 'data'},
  ],
};

/// Descriptor for `RankTypeFilterResponseProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rankTypeFilterResponseProtoDescriptor = $convert.base64Decode('ChtSYW5rVHlwZUZpbHRlclJlc3BvbnNlUHJvdG8SFAoFZXJybm8YASABKAVSBWVycm5vEhYKBmVycm1zZxgCIAEoCVIGZXJybXNnEiIKBGRhdGEYAyADKAsyDi5Db21pY1RhZ1Byb3RvUgRkYXRh');
@$core.Deprecated('Use comicUpdateListResponseProtoDescriptor instead')
const ComicUpdateListResponseProto$json = const {
  '1': 'ComicUpdateListResponseProto',
  '2': const [
    const {'1': 'errno', '3': 1, '4': 1, '5': 5, '10': 'errno'},
    const {'1': 'errmsg', '3': 2, '4': 1, '5': 9, '10': 'errmsg'},
    const {'1': 'data', '3': 3, '4': 3, '5': 11, '6': '.ComicUpdateListInfoProto', '10': 'data'},
  ],
};

/// Descriptor for `ComicUpdateListResponseProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicUpdateListResponseProtoDescriptor = $convert.base64Decode('ChxDb21pY1VwZGF0ZUxpc3RSZXNwb25zZVByb3RvEhQKBWVycm5vGAEgASgFUgVlcnJubxIWCgZlcnJtc2cYAiABKAlSBmVycm1zZxItCgRkYXRhGAMgAygLMhkuQ29taWNVcGRhdGVMaXN0SW5mb1Byb3RvUgRkYXRh');
@$core.Deprecated('Use comicUpdateListInfoProtoDescriptor instead')
const ComicUpdateListInfoProto$json = const {
  '1': 'ComicUpdateListInfoProto',
  '2': const [
    const {'1': 'comicId', '3': 1, '4': 1, '5': 3, '10': 'comicId'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'islong', '3': 3, '4': 1, '5': 5, '10': 'islong'},
    const {'1': 'authors', '3': 4, '4': 1, '5': 9, '10': 'authors'},
    const {'1': 'types', '3': 5, '4': 1, '5': 9, '10': 'types'},
    const {'1': 'cover', '3': 6, '4': 1, '5': 9, '10': 'cover'},
    const {'1': 'status', '3': 7, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'lastUpdateChapterName', '3': 8, '4': 1, '5': 9, '10': 'lastUpdateChapterName'},
    const {'1': 'lastUpdateChapterId', '3': 9, '4': 1, '5': 3, '10': 'lastUpdateChapterId'},
    const {'1': 'lastUpdatetime', '3': 10, '4': 1, '5': 3, '10': 'lastUpdatetime'},
  ],
};

/// Descriptor for `ComicUpdateListInfoProto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List comicUpdateListInfoProtoDescriptor = $convert.base64Decode('ChhDb21pY1VwZGF0ZUxpc3RJbmZvUHJvdG8SGAoHY29taWNJZBgBIAEoA1IHY29taWNJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFgoGaXNsb25nGAMgASgFUgZpc2xvbmcSGAoHYXV0aG9ycxgEIAEoCVIHYXV0aG9ycxIUCgV0eXBlcxgFIAEoCVIFdHlwZXMSFAoFY292ZXIYBiABKAlSBWNvdmVyEhYKBnN0YXR1cxgHIAEoCVIGc3RhdHVzEjQKFWxhc3RVcGRhdGVDaGFwdGVyTmFtZRgIIAEoCVIVbGFzdFVwZGF0ZUNoYXB0ZXJOYW1lEjAKE2xhc3RVcGRhdGVDaGFwdGVySWQYCSABKANSE2xhc3RVcGRhdGVDaGFwdGVySWQSJgoObGFzdFVwZGF0ZXRpbWUYCiABKANSDmxhc3RVcGRhdGV0aW1l');
