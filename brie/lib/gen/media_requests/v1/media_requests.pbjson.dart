// This is a generated file - do not edit.
//
// Generated from media_requests/v1/media_requests.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use downloadStatusDescriptor instead')
const DownloadStatus$json = {
  '1': 'DownloadStatus',
  '2': [
    {'1': 'Downloading', '2': 0},
    {'1': 'Error', '2': 1},
    {'1': 'Complete', '2': 2},
    {'1': 'Unknown', '2': 3},
  ],
};

/// Descriptor for `DownloadStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List downloadStatusDescriptor = $convert.base64Decode(
    'Cg5Eb3dubG9hZFN0YXR1cxIPCgtEb3dubG9hZGluZxAAEgkKBUVycm9yEAESDAoIQ29tcGxldG'
        'UQAhILCgdVbmtub3duEAM=');

@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest$json = {
  '1': 'SearchRequest',
  '2': [
    {'1': 'mediaQuery', '3': 1, '4': 1, '5': 9, '10': 'mediaQuery'},
  ],
};

/// Descriptor for `SearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDescriptor = $convert.base64Decode(
    'Cg1TZWFyY2hSZXF1ZXN0Eh4KCm1lZGlhUXVlcnkYASABKAlSCm1lZGlhUXVlcnk=');

@$core.Deprecated('Use searchResponseDescriptor instead')
const SearchResponse$json = {
  '1': 'SearchResponse',
  '2': [
    {
      '1': 'results',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.media_requests.v1.Media',
      '10': 'results'
    },
  ],
};

/// Descriptor for `SearchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchResponseDescriptor = $convert.base64Decode(
    'Cg5TZWFyY2hSZXNwb25zZRIyCgdyZXN1bHRzGAEgAygLMhgubWVkaWFfcmVxdWVzdHMudjEuTW'
    'VkaWFSB3Jlc3VsdHM=');

@$core.Deprecated('Use listRequestDescriptor instead')
const ListRequest$json = {
  '1': 'ListRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 4, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 4, '10': 'offset'},
  ],
};

/// Descriptor for `ListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRequestDescriptor = $convert.base64Decode(
    'CgtMaXN0UmVxdWVzdBIUCgVsaW1pdBgBIAEoBFIFbGltaXQSFgoGb2Zmc2V0GAIgASgEUgZvZm'
    'ZzZXQ=');

@$core.Deprecated('Use listResponseDescriptor instead')
const ListResponse$json = {
  '1': 'ListResponse',
  '2': [
    {'1': 'totalRecords', '3': 2, '4': 1, '5': 4, '10': 'totalRecords'},
    {
      '1': 'results',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.media_requests.v1.Media',
      '10': 'results'
    },
  ],
};

/// Descriptor for `ListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listResponseDescriptor = $convert.base64Decode(
    'CgxMaXN0UmVzcG9uc2USIgoMdG90YWxSZWNvcmRzGAIgASgEUgx0b3RhbFJlY29yZHMSMgoHcm'
    'VzdWx0cxgBIAMoCzIYLm1lZGlhX3JlcXVlc3RzLnYxLk1lZGlhUgdyZXN1bHRz');

@$core.Deprecated('Use deleteRequestDescriptor instead')
const DeleteRequest$json = {
  '1': 'DeleteRequest',
  '2': [
    {'1': 'requestId', '3': 1, '4': 1, '5': 4, '10': 'requestId'},
  ],
};

/// Descriptor for `DeleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRequestDescriptor = $convert.base64Decode(
    'Cg1EZWxldGVSZXF1ZXN0EhwKCXJlcXVlc3RJZBgBIAEoBFIJcmVxdWVzdElk');

@$core.Deprecated('Use deleteResponseDescriptor instead')
const DeleteResponse$json = {
  '1': 'DeleteResponse',
};

/// Descriptor for `DeleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteResponseDescriptor =
    $convert.base64Decode('Cg5EZWxldGVSZXNwb25zZQ==');

@$core.Deprecated('Use editRequestDescriptor instead')
const EditRequest$json = {
  '1': 'EditRequest',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.media_requests.v1.Media',
      '10': 'media'
    },
  ],
};

/// Descriptor for `EditRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editRequestDescriptor = $convert.base64Decode(
    'CgtFZGl0UmVxdWVzdBIuCgVtZWRpYRgBIAEoCzIYLm1lZGlhX3JlcXVlc3RzLnYxLk1lZGlhUg'
    'VtZWRpYQ==');

@$core.Deprecated('Use editResponseDescriptor instead')
const EditResponse$json = {
  '1': 'EditResponse',
};

/// Descriptor for `EditResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editResponseDescriptor =
    $convert.base64Decode('CgxFZGl0UmVzcG9uc2U=');

@$core.Deprecated('Use existsRequestDescriptor instead')
const ExistsRequest$json = {
  '1': 'ExistsRequest',
  '2': [
    {'1': 'mamId', '3': 1, '4': 1, '5': 4, '10': 'mamId'},
  ],
};

/// Descriptor for `ExistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List existsRequestDescriptor = $convert
    .base64Decode('Cg1FeGlzdHNSZXF1ZXN0EhQKBW1hbUlkGAEgASgEUgVtYW1JZA==');

@$core.Deprecated('Use existsResponseDescriptor instead')
const ExistsResponse$json = {
  '1': 'ExistsResponse',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.media_requests.v1.Media',
      '10': 'media'
    },
  ],
};

/// Descriptor for `ExistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List existsResponseDescriptor = $convert.base64Decode(
    'Cg5FeGlzdHNSZXNwb25zZRIuCgVtZWRpYRgBIAEoCzIYLm1lZGlhX3JlcXVlc3RzLnYxLk1lZG'
    'lhUgVtZWRpYQ==');

@$core.Deprecated('Use retryRequestDescriptor instead')
const RetryRequest$json = {
  '1': 'RetryRequest',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
  ],
};

/// Descriptor for `RetryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List retryRequestDescriptor =
    $convert.base64Decode('CgxSZXRyeVJlcXVlc3QSDgoCSUQYASABKARSAklE');

@$core.Deprecated('Use retryResponseDescriptor instead')
const RetryResponse$json = {
  '1': 'RetryResponse',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.media_requests.v1.Media',
      '10': 'media'
    },
  ],
};

/// Descriptor for `RetryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List retryResponseDescriptor = $convert.base64Decode(
    'Cg1SZXRyeVJlc3BvbnNlEi4KBW1lZGlhGAEgASgLMhgubWVkaWFfcmVxdWVzdHMudjEuTWVkaW'
    'FSBW1lZGlh');

@$core.Deprecated('Use addMediaRequestDescriptor instead')
const AddMediaRequest$json = {
  '1': 'AddMediaRequest',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.media_requests.v1.Media',
      '10': 'media'
    },
  ],
};

/// Descriptor for `AddMediaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMediaRequestDescriptor = $convert.base64Decode(
    'Cg9BZGRNZWRpYVJlcXVlc3QSLgoFbWVkaWEYASABKAsyGC5tZWRpYV9yZXF1ZXN0cy52MS5NZW'
    'RpYVIFbWVkaWE=');

@$core.Deprecated('Use addMediaResponseDescriptor instead')
const AddMediaResponse$json = {
  '1': 'AddMediaResponse',
};

/// Descriptor for `AddMediaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMediaResponseDescriptor =
    $convert.base64Decode('ChBBZGRNZWRpYVJlc3BvbnNl');

@$core.Deprecated('Use mediaDescriptor instead')
const Media$json = {
  '1': 'Media',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
    {'1': 'author', '3': 2, '4': 1, '5': 9, '10': 'author'},
    {'1': 'book', '3': 3, '4': 1, '5': 9, '10': 'book'},
    {'1': 'series', '3': 4, '4': 1, '5': 9, '10': 'series'},
    {'1': 'series_number', '3': 5, '4': 1, '5': 13, '10': 'seriesNumber'},
    {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
    {'1': 'mam_book_id', '3': 7, '4': 1, '5': 4, '10': 'mamBookId'},
    {'1': 'file_link', '3': 12, '4': 1, '5': 9, '10': 'fileLink'},
    {
      '1': 'status',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.media_requests.v1.DownloadStatus',
      '10': 'status'
    },
    {'1': 'statusMessage', '3': 15, '4': 1, '5': 9, '10': 'statusMessage'},
    {'1': 'torrent_id', '3': 9, '4': 1, '5': 9, '10': 'torrentId'},
    {
      '1': 'torrent_file_location',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'torrentFileLocation'
    },
    {'1': 'createdAt', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updatedAt', '3': 14, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Media`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaDescriptor = $convert.base64Decode(
    'CgVNZWRpYRIOCgJJRBgBIAEoBFICSUQSFgoGYXV0aG9yGAIgASgJUgZhdXRob3ISEgoEYm9vax'
    'gDIAEoCVIEYm9vaxIWCgZzZXJpZXMYBCABKAlSBnNlcmllcxIjCg1zZXJpZXNfbnVtYmVyGAUg'
    'ASgNUgxzZXJpZXNOdW1iZXISGgoIY2F0ZWdvcnkYBiABKAlSCGNhdGVnb3J5Eh4KC21hbV9ib2'
        '9rX2lkGAcgASgEUgltYW1Cb29rSWQSGwoJZmlsZV9saW5rGAwgASgJUghmaWxlTGluaxI5CgZz'
        'dGF0dXMYCCABKA4yIS5tZWRpYV9yZXF1ZXN0cy52MS5Eb3dubG9hZFN0YXR1c1IGc3RhdHVzEi'
        'QKDXN0YXR1c01lc3NhZ2UYDyABKAlSDXN0YXR1c01lc3NhZ2USHQoKdG9ycmVudF9pZBgJIAEo'
        'CVIJdG9ycmVudElkEjIKFXRvcnJlbnRfZmlsZV9sb2NhdGlvbhgLIAEoCVITdG9ycmVudEZpbG'
        'VMb2NhdGlvbhIcCgljcmVhdGVkQXQYDSABKAlSCWNyZWF0ZWRBdBIcCgl1cGRhdGVkQXQYDiAB'
        'KAlSCXVwZGF0ZWRBdA==');

const $core.Map<$core.String, $core.dynamic> MediaRequestServiceBase$json = {
  '1': 'MediaRequestService',
  '2': [
    {
      '1': 'Search',
      '2': '.media_requests.v1.SearchRequest',
      '3': '.media_requests.v1.SearchResponse',
      '4': {}
    },
    {
      '1': 'List',
      '2': '.media_requests.v1.ListRequest',
      '3': '.media_requests.v1.ListResponse',
      '4': {}
    },
    {
      '1': 'Delete',
      '2': '.media_requests.v1.DeleteRequest',
      '3': '.media_requests.v1.DeleteResponse',
      '4': {}
    },
    {
      '1': 'Edit',
      '2': '.media_requests.v1.EditRequest',
      '3': '.media_requests.v1.EditResponse',
      '4': {}
    },
    {
      '1': 'Exists',
      '2': '.media_requests.v1.ExistsRequest',
      '3': '.media_requests.v1.ExistsResponse',
      '4': {}
    },
    {
      '1': 'Retry',
      '2': '.media_requests.v1.RetryRequest',
      '3': '.media_requests.v1.RetryResponse',
      '4': {}
    },
    {
      '1': 'AddMedia',
      '2': '.media_requests.v1.AddMediaRequest',
      '3': '.media_requests.v1.AddMediaResponse',
      '4': {}
    },
    {
      '1': 'AddMediaWithFreeleech',
      '2': '.media_requests.v1.AddMediaRequest',
      '3': '.media_requests.v1.AddMediaResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use mediaRequestServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
MediaRequestServiceBase$messageJson = {
  '.media_requests.v1.SearchRequest': SearchRequest$json,
  '.media_requests.v1.SearchResponse': SearchResponse$json,
  '.media_requests.v1.Media': Media$json,
  '.media_requests.v1.ListRequest': ListRequest$json,
  '.media_requests.v1.ListResponse': ListResponse$json,
  '.media_requests.v1.DeleteRequest': DeleteRequest$json,
  '.media_requests.v1.DeleteResponse': DeleteResponse$json,
  '.media_requests.v1.EditRequest': EditRequest$json,
  '.media_requests.v1.EditResponse': EditResponse$json,
  '.media_requests.v1.ExistsRequest': ExistsRequest$json,
  '.media_requests.v1.ExistsResponse': ExistsResponse$json,
  '.media_requests.v1.RetryRequest': RetryRequest$json,
  '.media_requests.v1.RetryResponse': RetryResponse$json,
  '.media_requests.v1.AddMediaRequest': AddMediaRequest$json,
  '.media_requests.v1.AddMediaResponse': AddMediaResponse$json,
};

/// Descriptor for `MediaRequestService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List mediaRequestServiceDescriptor = $convert
    .base64Decode(
    'ChNNZWRpYVJlcXVlc3RTZXJ2aWNlEk8KBlNlYXJjaBIgLm1lZGlhX3JlcXVlc3RzLnYxLlNlYX'
        'JjaFJlcXVlc3QaIS5tZWRpYV9yZXF1ZXN0cy52MS5TZWFyY2hSZXNwb25zZSIAEkkKBExpc3QS'
        'Hi5tZWRpYV9yZXF1ZXN0cy52MS5MaXN0UmVxdWVzdBofLm1lZGlhX3JlcXVlc3RzLnYxLkxpc3'
        'RSZXNwb25zZSIAEk8KBkRlbGV0ZRIgLm1lZGlhX3JlcXVlc3RzLnYxLkRlbGV0ZVJlcXVlc3Qa'
        'IS5tZWRpYV9yZXF1ZXN0cy52MS5EZWxldGVSZXNwb25zZSIAEkkKBEVkaXQSHi5tZWRpYV9yZX'
        'F1ZXN0cy52MS5FZGl0UmVxdWVzdBofLm1lZGlhX3JlcXVlc3RzLnYxLkVkaXRSZXNwb25zZSIA'
        'Ek8KBkV4aXN0cxIgLm1lZGlhX3JlcXVlc3RzLnYxLkV4aXN0c1JlcXVlc3QaIS5tZWRpYV9yZX'
        'F1ZXN0cy52MS5FeGlzdHNSZXNwb25zZSIAEkwKBVJldHJ5Eh8ubWVkaWFfcmVxdWVzdHMudjEu'
        'UmV0cnlSZXF1ZXN0GiAubWVkaWFfcmVxdWVzdHMudjEuUmV0cnlSZXNwb25zZSIAElUKCEFkZE'
        '1lZGlhEiIubWVkaWFfcmVxdWVzdHMudjEuQWRkTWVkaWFSZXF1ZXN0GiMubWVkaWFfcmVxdWVz'
        'dHMudjEuQWRkTWVkaWFSZXNwb25zZSIAEmIKFUFkZE1lZGlhV2l0aEZyZWVsZWVjaBIiLm1lZG'
        'lhX3JlcXVlc3RzLnYxLkFkZE1lZGlhUmVxdWVzdBojLm1lZGlhX3JlcXVlc3RzLnYxLkFkZE1l'
        'ZGlhUmVzcG9uc2UiAA==');
