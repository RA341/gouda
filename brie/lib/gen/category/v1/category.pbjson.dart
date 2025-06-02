//
//  Generated code. Do not modify.
//  source: category/v1/category.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use listCategoriesRequestDescriptor instead')
const ListCategoriesRequest$json = {
  '1': 'ListCategoriesRequest',
};

/// Descriptor for `ListCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCategoriesRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0Q2F0ZWdvcmllc1JlcXVlc3Q=');

@$core.Deprecated('Use listCategoriesResponseDescriptor instead')
const ListCategoriesResponse$json = {
  '1': 'ListCategoriesResponse',
  '2': [
    {'1': 'categories', '3': 1, '4': 3, '5': 11, '6': '.category.v1.Category', '10': 'categories'},
  ],
};

/// Descriptor for `ListCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCategoriesResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0Q2F0ZWdvcmllc1Jlc3BvbnNlEjUKCmNhdGVnb3JpZXMYASADKAsyFS5jYXRlZ29yeS'
    '52MS5DYXRlZ29yeVIKY2F0ZWdvcmllcw==');

@$core.Deprecated('Use addCategoriesRequestDescriptor instead')
const AddCategoriesRequest$json = {
  '1': 'AddCategoriesRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `AddCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addCategoriesRequestDescriptor = $convert.base64Decode(
    'ChRBZGRDYXRlZ29yaWVzUmVxdWVzdBIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnk=');

@$core.Deprecated('Use addCategoriesResponseDescriptor instead')
const AddCategoriesResponse$json = {
  '1': 'AddCategoriesResponse',
};

/// Descriptor for `AddCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addCategoriesResponseDescriptor = $convert.base64Decode(
    'ChVBZGRDYXRlZ29yaWVzUmVzcG9uc2U=');

@$core.Deprecated('Use delCategoriesRequestDescriptor instead')
const DelCategoriesRequest$json = {
  '1': 'DelCategoriesRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 11, '6': '.category.v1.Category', '10': 'category'},
  ],
};

/// Descriptor for `DelCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delCategoriesRequestDescriptor = $convert.base64Decode(
    'ChREZWxDYXRlZ29yaWVzUmVxdWVzdBIxCghjYXRlZ29yeRgBIAEoCzIVLmNhdGVnb3J5LnYxLk'
    'NhdGVnb3J5UghjYXRlZ29yeQ==');

@$core.Deprecated('Use delCategoriesResponseDescriptor instead')
const DelCategoriesResponse$json = {
  '1': 'DelCategoriesResponse',
};

/// Descriptor for `DelCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delCategoriesResponseDescriptor = $convert.base64Decode(
    'ChVEZWxDYXRlZ29yaWVzUmVzcG9uc2U=');

@$core.Deprecated('Use categoryDescriptor instead')
const Category$json = {
  '1': 'Category',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
    {'1': 'category', '3': 2, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `Category`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryDescriptor = $convert.base64Decode(
    'CghDYXRlZ29yeRIOCgJJRBgBIAEoBFICSUQSGgoIY2F0ZWdvcnkYAiABKAlSCGNhdGVnb3J5');

