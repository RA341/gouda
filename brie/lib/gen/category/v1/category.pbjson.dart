// This is a generated file - do not edit.
//
// Generated from category/v1/category.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use listCategoriesRequestDescriptor instead')
const ListCategoriesRequest$json = {
  '1': 'ListCategoriesRequest',
};

/// Descriptor for `ListCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCategoriesRequestDescriptor =
    $convert.base64Decode('ChVMaXN0Q2F0ZWdvcmllc1JlcXVlc3Q=');

@$core.Deprecated('Use listCategoriesResponseDescriptor instead')
const ListCategoriesResponse$json = {
  '1': 'ListCategoriesResponse',
  '2': [
    {
      '1': 'categories',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.category.v1.Category',
      '10': 'categories'
    },
  ],
};

/// Descriptor for `ListCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCategoriesResponseDescriptor =
    $convert.base64Decode(
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
final $typed_data.Uint8List addCategoriesRequestDescriptor =
    $convert.base64Decode(
        'ChRBZGRDYXRlZ29yaWVzUmVxdWVzdBIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnk=');

@$core.Deprecated('Use addCategoriesResponseDescriptor instead')
const AddCategoriesResponse$json = {
  '1': 'AddCategoriesResponse',
};

/// Descriptor for `AddCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addCategoriesResponseDescriptor =
    $convert.base64Decode('ChVBZGRDYXRlZ29yaWVzUmVzcG9uc2U=');

@$core.Deprecated('Use delCategoriesRequestDescriptor instead')
const DelCategoriesRequest$json = {
  '1': 'DelCategoriesRequest',
  '2': [
    {
      '1': 'category',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.category.v1.Category',
      '10': 'category'
    },
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
final $typed_data.Uint8List delCategoriesResponseDescriptor =
    $convert.base64Decode('ChVEZWxDYXRlZ29yaWVzUmVzcG9uc2U=');

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

const $core.Map<$core.String, $core.dynamic> CategoryServiceBase$json = {
  '1': 'CategoryService',
  '2': [
    {
      '1': 'ListCategories',
      '2': '.category.v1.ListCategoriesRequest',
      '3': '.category.v1.ListCategoriesResponse',
      '4': {}
    },
    {
      '1': 'AddCategories',
      '2': '.category.v1.AddCategoriesRequest',
      '3': '.category.v1.AddCategoriesResponse',
      '4': {}
    },
    {
      '1': 'DeleteCategories',
      '2': '.category.v1.DelCategoriesRequest',
      '3': '.category.v1.DelCategoriesResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use categoryServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    CategoryServiceBase$messageJson = {
  '.category.v1.ListCategoriesRequest': ListCategoriesRequest$json,
  '.category.v1.ListCategoriesResponse': ListCategoriesResponse$json,
  '.category.v1.Category': Category$json,
  '.category.v1.AddCategoriesRequest': AddCategoriesRequest$json,
  '.category.v1.AddCategoriesResponse': AddCategoriesResponse$json,
  '.category.v1.DelCategoriesRequest': DelCategoriesRequest$json,
  '.category.v1.DelCategoriesResponse': DelCategoriesResponse$json,
};

/// Descriptor for `CategoryService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List categoryServiceDescriptor = $convert.base64Decode(
    'Cg9DYXRlZ29yeVNlcnZpY2USWwoOTGlzdENhdGVnb3JpZXMSIi5jYXRlZ29yeS52MS5MaXN0Q2'
    'F0ZWdvcmllc1JlcXVlc3QaIy5jYXRlZ29yeS52MS5MaXN0Q2F0ZWdvcmllc1Jlc3BvbnNlIgAS'
    'WAoNQWRkQ2F0ZWdvcmllcxIhLmNhdGVnb3J5LnYxLkFkZENhdGVnb3JpZXNSZXF1ZXN0GiIuY2'
    'F0ZWdvcnkudjEuQWRkQ2F0ZWdvcmllc1Jlc3BvbnNlIgASWwoQRGVsZXRlQ2F0ZWdvcmllcxIh'
    'LmNhdGVnb3J5LnYxLkRlbENhdGVnb3JpZXNSZXF1ZXN0GiIuY2F0ZWdvcnkudjEuRGVsQ2F0ZW'
    'dvcmllc1Jlc3BvbnNlIgA=');
