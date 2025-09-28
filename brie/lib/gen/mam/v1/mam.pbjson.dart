// This is a generated file - do not edit.
//
// Generated from mam/v1/mam.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use isMamSetupRequestDescriptor instead')
const IsMamSetupRequest$json = {
  '1': 'IsMamSetupRequest',
};

/// Descriptor for `IsMamSetupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isMamSetupRequestDescriptor =
    $convert.base64Decode('ChFJc01hbVNldHVwUmVxdWVzdA==');

@$core.Deprecated('Use isMamSetupResponseDescriptor instead')
const IsMamSetupResponse$json = {
  '1': 'IsMamSetupResponse',
};

/// Descriptor for `IsMamSetupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isMamSetupResponseDescriptor =
    $convert.base64Decode('ChJJc01hbVNldHVwUmVzcG9uc2U=');

@$core.Deprecated('Use userDataDescriptor instead')
const UserData$json = {
  '1': 'UserData',
  '2': [
    {'1': 'classname', '3': 1, '4': 1, '5': 9, '10': 'classname'},
    {'1': 'country_code', '3': 2, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'country_name', '3': 3, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'downloaded', '3': 4, '4': 1, '5': 9, '10': 'downloaded'},
    {'1': 'downloaded_bytes', '3': 5, '4': 1, '5': 3, '10': 'downloadedBytes'},
    {'1': 'ratio', '3': 6, '4': 1, '5': 1, '10': 'ratio'},
    {'1': 'seedbonus', '3': 7, '4': 1, '5': 5, '10': 'seedbonus'},
    {'1': 'uid', '3': 8, '4': 1, '5': 5, '10': 'uid'},
    {'1': 'uploaded', '3': 9, '4': 1, '5': 9, '10': 'uploaded'},
    {'1': 'uploaded_bytes', '3': 10, '4': 1, '5': 3, '10': 'uploadedBytes'},
    {'1': 'username', '3': 11, '4': 1, '5': 9, '10': 'username'},
    {'1': 'vip_until', '3': 12, '4': 1, '5': 9, '10': 'vipUntil'},
  ],
};

/// Descriptor for `UserData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDataDescriptor = $convert.base64Decode(
    'CghVc2VyRGF0YRIcCgljbGFzc25hbWUYASABKAlSCWNsYXNzbmFtZRIhCgxjb3VudHJ5X2NvZG'
    'UYAiABKAlSC2NvdW50cnlDb2RlEiEKDGNvdW50cnlfbmFtZRgDIAEoCVILY291bnRyeU5hbWUS'
    'HgoKZG93bmxvYWRlZBgEIAEoCVIKZG93bmxvYWRlZBIpChBkb3dubG9hZGVkX2J5dGVzGAUgAS'
    'gDUg9kb3dubG9hZGVkQnl0ZXMSFAoFcmF0aW8YBiABKAFSBXJhdGlvEhwKCXNlZWRib251cxgH'
    'IAEoBVIJc2VlZGJvbnVzEhAKA3VpZBgIIAEoBVIDdWlkEhoKCHVwbG9hZGVkGAkgASgJUgh1cG'
    'xvYWRlZBIlCg51cGxvYWRlZF9ieXRlcxgKIAEoA1INdXBsb2FkZWRCeXRlcxIaCgh1c2VybmFt'
    'ZRgLIAEoCVIIdXNlcm5hbWUSGwoJdmlwX3VudGlsGAwgASgJUgh2aXBVbnRpbA==');

@$core.Deprecated('Use vipRequestDescriptor instead')
const VipRequest$json = {
  '1': 'VipRequest',
  '2': [
    {'1': 'amountInWeeks', '3': 1, '4': 1, '5': 5, '10': 'amountInWeeks'},
  ],
};

/// Descriptor for `VipRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vipRequestDescriptor = $convert.base64Decode(
    'CgpWaXBSZXF1ZXN0EiQKDWFtb3VudEluV2Vla3MYASABKAVSDWFtb3VudEluV2Vla3M=');

@$core.Deprecated('Use vipResponseDescriptor instead')
const VipResponse$json = {
  '1': 'VipResponse',
  '2': [
    {'1': 'Success', '3': 1, '4': 1, '5': 8, '10': 'Success'},
    {'1': 'Type', '3': 2, '4': 1, '5': 9, '10': 'Type'},
    {'1': 'Amount', '3': 3, '4': 1, '5': 2, '10': 'Amount'},
    {'1': 'SeedBonus', '3': 4, '4': 1, '5': 2, '10': 'SeedBonus'},
  ],
};

/// Descriptor for `VipResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vipResponseDescriptor = $convert.base64Decode(
    'CgtWaXBSZXNwb25zZRIYCgdTdWNjZXNzGAEgASgIUgdTdWNjZXNzEhIKBFR5cGUYAiABKAlSBF'
    'R5cGUSFgoGQW1vdW50GAMgASgCUgZBbW91bnQSHAoJU2VlZEJvbnVzGAQgASgCUglTZWVkQm9u'
    'dXM=');

@$core.Deprecated('Use bonusRequestDescriptor instead')
const BonusRequest$json = {
  '1': 'BonusRequest',
  '2': [
    {'1': 'amountInGB', '3': 1, '4': 1, '5': 5, '10': 'amountInGB'},
  ],
};

/// Descriptor for `BonusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bonusRequestDescriptor = $convert.base64Decode(
    'CgxCb251c1JlcXVlc3QSHgoKYW1vdW50SW5HQhgBIAEoBVIKYW1vdW50SW5HQg==');

@$core.Deprecated('Use bonusResponseDescriptor instead')
const BonusResponse$json = {
  '1': 'BonusResponse',
  '2': [
    {'1': 'Success', '3': 1, '4': 1, '5': 8, '10': 'Success'},
    {'1': 'Type', '3': 2, '4': 1, '5': 9, '10': 'Type'},
    {'1': 'Amount', '3': 3, '4': 1, '5': 2, '10': 'Amount'},
    {'1': 'Seedbonus', '3': 4, '4': 1, '5': 2, '10': 'Seedbonus'},
    {'1': 'Uploaded', '3': 5, '4': 1, '5': 3, '10': 'Uploaded'},
    {'1': 'Downloaded', '3': 6, '4': 1, '5': 3, '10': 'Downloaded'},
    {'1': 'UploadFancy', '3': 7, '4': 1, '5': 9, '10': 'UploadFancy'},
    {'1': 'DownloadFancy', '3': 8, '4': 1, '5': 9, '10': 'DownloadFancy'},
    {'1': 'Ratio', '3': 9, '4': 1, '5': 2, '10': 'Ratio'},
  ],
};

/// Descriptor for `BonusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bonusResponseDescriptor = $convert.base64Decode(
    'Cg1Cb251c1Jlc3BvbnNlEhgKB1N1Y2Nlc3MYASABKAhSB1N1Y2Nlc3MSEgoEVHlwZRgCIAEoCV'
    'IEVHlwZRIWCgZBbW91bnQYAyABKAJSBkFtb3VudBIcCglTZWVkYm9udXMYBCABKAJSCVNlZWRi'
    'b251cxIaCghVcGxvYWRlZBgFIAEoA1IIVXBsb2FkZWQSHgoKRG93bmxvYWRlZBgGIAEoA1IKRG'
    '93bmxvYWRlZBIgCgtVcGxvYWRGYW5jeRgHIAEoCVILVXBsb2FkRmFuY3kSJAoNRG93bmxvYWRG'
    'YW5jeRgIIAEoCVINRG93bmxvYWRGYW5jeRIUCgVSYXRpbxgJIAEoAlIFUmF0aW8=');

@$core.Deprecated('Use searchResultsDescriptor instead')
const SearchResults$json = {
  '1': 'SearchResults',
  '2': [
    {
      '1': 'results',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mam.v1.SearchBook',
      '10': 'results'
    },
    {'1': 'found', '3': 2, '4': 1, '5': 5, '10': 'found'},
    {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `SearchResults`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchResultsDescriptor = $convert.base64Decode(
    'Cg1TZWFyY2hSZXN1bHRzEiwKB3Jlc3VsdHMYASADKAsyEi5tYW0udjEuU2VhcmNoQm9va1IHcm'
    'VzdWx0cxIUCgVmb3VuZBgCIAEoBVIFZm91bmQSFAoFdG90YWwYAyABKAVSBXRvdGFs');

@$core.Deprecated('Use searchBookDescriptor instead')
const SearchBook$json = {
  '1': 'SearchBook',
  '2': [
    {'1': 'mam_id', '3': 1, '4': 1, '5': 5, '10': 'mamId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'thumbnail', '3': 3, '4': 1, '5': 9, '10': 'thumbnail'},
    {
      '1': 'author',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.mam.v1.Author',
      '10': 'author'
    },
    {
      '1': 'narrator',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.mam.v1.Author',
      '10': 'narrator'
    },
    {'1': 'uploader_name', '3': 6, '4': 1, '5': 9, '10': 'uploaderName'},
    {
      '1': 'series',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.mam.v1.Series',
      '10': 'series'
    },
    {'1': 'description', '3': 21, '4': 1, '5': 9, '10': 'description'},
    {'1': 'tags', '3': 8, '4': 1, '5': 9, '10': 'tags'},
    {'1': 'date_added_iso', '3': 9, '4': 1, '5': 9, '10': 'dateAddedIso'},
    {'1': 'snatched', '3': 10, '4': 1, '5': 8, '10': 'snatched'},
    {'1': 'language_code', '3': 11, '4': 1, '5': 9, '10': 'languageCode'},
    {'1': 'media_category', '3': 12, '4': 1, '5': 9, '10': 'mediaCategory'},
    {'1': 'category_id', '3': 13, '4': 1, '5': 5, '10': 'categoryId'},
    {'1': 'category_name', '3': 14, '4': 1, '5': 9, '10': 'categoryName'},
    {'1': 'media_format', '3': 15, '4': 1, '5': 9, '10': 'mediaFormat'},
    {'1': 'media_size', '3': 16, '4': 1, '5': 9, '10': 'mediaSize'},
    {'1': 'seeders', '3': 17, '4': 1, '5': 5, '10': 'seeders'},
    {'1': 'leechers', '3': 18, '4': 1, '5': 5, '10': 'leechers'},
    {'1': 'completed', '3': 19, '4': 1, '5': 5, '10': 'completed'},
    {'1': 'torrent_link', '3': 20, '4': 1, '5': 9, '10': 'torrentLink'},
  ],
};

/// Descriptor for `SearchBook`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchBookDescriptor = $convert.base64Decode(
    'CgpTZWFyY2hCb29rEhUKBm1hbV9pZBgBIAEoBVIFbWFtSWQSFAoFdGl0bGUYAiABKAlSBXRpdG'
    'xlEhwKCXRodW1ibmFpbBgDIAEoCVIJdGh1bWJuYWlsEiYKBmF1dGhvchgEIAMoCzIOLm1hbS52'
    'MS5BdXRob3JSBmF1dGhvchIqCghuYXJyYXRvchgFIAMoCzIOLm1hbS52MS5BdXRob3JSCG5hcn'
    'JhdG9yEiMKDXVwbG9hZGVyX25hbWUYBiABKAlSDHVwbG9hZGVyTmFtZRImCgZzZXJpZXMYByAD'
    'KAsyDi5tYW0udjEuU2VyaWVzUgZzZXJpZXMSIAoLZGVzY3JpcHRpb24YFSABKAlSC2Rlc2NyaX'
    'B0aW9uEhIKBHRhZ3MYCCABKAlSBHRhZ3MSJAoOZGF0ZV9hZGRlZF9pc28YCSABKAlSDGRhdGVB'
    'ZGRlZElzbxIaCghzbmF0Y2hlZBgKIAEoCFIIc25hdGNoZWQSIwoNbGFuZ3VhZ2VfY29kZRgLIA'
    'EoCVIMbGFuZ3VhZ2VDb2RlEiUKDm1lZGlhX2NhdGVnb3J5GAwgASgJUg1tZWRpYUNhdGVnb3J5'
    'Eh8KC2NhdGVnb3J5X2lkGA0gASgFUgpjYXRlZ29yeUlkEiMKDWNhdGVnb3J5X25hbWUYDiABKA'
    'lSDGNhdGVnb3J5TmFtZRIhCgxtZWRpYV9mb3JtYXQYDyABKAlSC21lZGlhRm9ybWF0Eh0KCm1l'
    'ZGlhX3NpemUYECABKAlSCW1lZGlhU2l6ZRIYCgdzZWVkZXJzGBEgASgFUgdzZWVkZXJzEhoKCG'
    'xlZWNoZXJzGBIgASgFUghsZWVjaGVycxIcCgljb21wbGV0ZWQYEyABKAVSCWNvbXBsZXRlZBIh'
    'Cgx0b3JyZW50X2xpbmsYFCABKAlSC3RvcnJlbnRMaW5r');

@$core.Deprecated('Use authorDescriptor instead')
const Author$json = {
  '1': 'Author',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Author`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorDescriptor = $convert.base64Decode(
    'CgZBdXRob3ISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');

@$core.Deprecated('Use seriesDescriptor instead')
const Series$json = {
  '1': 'Series',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'sequence_number', '3': 3, '4': 1, '5': 9, '10': 'sequenceNumber'},
  ],
};

/// Descriptor for `Series`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seriesDescriptor = $convert.base64Decode(
    'CgZTZXJpZXMSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSJwoPc2VxdWVuY2'
    'VfbnVtYmVyGAMgASgJUg5zZXF1ZW5jZU51bWJlcg==');

@$core.Deprecated('Use freeLeechInfoDescriptor instead')
const FreeLeechInfo$json = {
  '1': 'FreeLeechInfo',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'expires', '3': 2, '4': 1, '5': 9, '10': 'expires'},
  ],
};

/// Descriptor for `FreeLeechInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List freeLeechInfoDescriptor = $convert.base64Decode(
    'Cg1GcmVlTGVlY2hJbmZvEhIKBHR5cGUYASABKAlSBHR5cGUSGAoHZXhwaXJlcxgCIAEoCVIHZX'
    'hwaXJlcw==');

@$core.Deprecated('Use queryDescriptor instead')
const Query$json = {
  '1': 'Query',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `Query`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryDescriptor =
    $convert.base64Decode('CgVRdWVyeRIUCgVxdWVyeRgBIAEoCVIFcXVlcnk=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');
