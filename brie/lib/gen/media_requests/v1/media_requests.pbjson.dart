//
//  Generated code. Do not modify.
//  source: media_requests/v1/media_requests.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

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
    {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.media_requests.v1.Media', '10': 'results'},
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
    {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.media_requests.v1.Media', '10': 'results'},
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
final $typed_data.Uint8List deleteResponseDescriptor = $convert.base64Decode(
    'Cg5EZWxldGVSZXNwb25zZQ==');

@$core.Deprecated('Use editRequestDescriptor instead')
const EditRequest$json = {
  '1': 'EditRequest',
  '2': [
    {'1': 'media', '3': 1, '4': 1, '5': 11, '6': '.media_requests.v1.Media', '10': 'media'},
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
final $typed_data.Uint8List editResponseDescriptor = $convert.base64Decode(
    'CgxFZGl0UmVzcG9uc2U=');

@$core.Deprecated('Use existsRequestDescriptor instead')
const ExistsRequest$json = {
  '1': 'ExistsRequest',
  '2': [
    {'1': 'mamId', '3': 1, '4': 1, '5': 4, '10': 'mamId'},
  ],
};

/// Descriptor for `ExistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List existsRequestDescriptor = $convert.base64Decode(
    'Cg1FeGlzdHNSZXF1ZXN0EhQKBW1hbUlkGAEgASgEUgVtYW1JZA==');

@$core.Deprecated('Use existsResponseDescriptor instead')
const ExistsResponse$json = {
  '1': 'ExistsResponse',
  '2': [
    {'1': 'media', '3': 1, '4': 1, '5': 11, '6': '.media_requests.v1.Media', '10': 'media'},
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
final $typed_data.Uint8List retryRequestDescriptor = $convert.base64Decode(
    'CgxSZXRyeVJlcXVlc3QSDgoCSUQYASABKARSAklE');

@$core.Deprecated('Use retryResponseDescriptor instead')
const RetryResponse$json = {
  '1': 'RetryResponse',
  '2': [
    {'1': 'media', '3': 1, '4': 1, '5': 11, '6': '.media_requests.v1.Media', '10': 'media'},
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
    {'1': 'media', '3': 1, '4': 1, '5': 11, '6': '.media_requests.v1.Media', '10': 'media'},
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
final $typed_data.Uint8List addMediaResponseDescriptor = $convert.base64Decode(
    'ChBBZGRNZWRpYVJlc3BvbnNl');

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
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'torrent_id', '3': 9, '4': 1, '5': 9, '10': 'torrentId'},
    {'1': 'time_running', '3': 10, '4': 1, '5': 13, '10': 'timeRunning'},
    {'1': 'torrent_file_location', '3': 11, '4': 1, '5': 9, '10': 'torrentFileLocation'},
    {'1': 'createdAt', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `Media`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaDescriptor = $convert.base64Decode(
    'CgVNZWRpYRIOCgJJRBgBIAEoBFICSUQSFgoGYXV0aG9yGAIgASgJUgZhdXRob3ISEgoEYm9vax'
    'gDIAEoCVIEYm9vaxIWCgZzZXJpZXMYBCABKAlSBnNlcmllcxIjCg1zZXJpZXNfbnVtYmVyGAUg'
    'ASgNUgxzZXJpZXNOdW1iZXISGgoIY2F0ZWdvcnkYBiABKAlSCGNhdGVnb3J5Eh4KC21hbV9ib2'
    '9rX2lkGAcgASgEUgltYW1Cb29rSWQSGwoJZmlsZV9saW5rGAwgASgJUghmaWxlTGluaxIWCgZz'
    'dGF0dXMYCCABKAlSBnN0YXR1cxIdCgp0b3JyZW50X2lkGAkgASgJUgl0b3JyZW50SWQSIQoMdG'
    'ltZV9ydW5uaW5nGAogASgNUgt0aW1lUnVubmluZxIyChV0b3JyZW50X2ZpbGVfbG9jYXRpb24Y'
    'CyABKAlSE3RvcnJlbnRGaWxlTG9jYXRpb24SHAoJY3JlYXRlZEF0GA0gASgJUgljcmVhdGVkQX'
    'Q=');

