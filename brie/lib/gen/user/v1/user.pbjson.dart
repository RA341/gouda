// This is a generated file - do not edit.
//
// Generated from user/v1/user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getUserInfoRequestDescriptor instead')
const GetUserInfoRequest$json = {
  '1': 'GetUserInfoRequest',
};

/// Descriptor for `GetUserInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInfoRequestDescriptor =
    $convert.base64Decode('ChJHZXRVc2VySW5mb1JlcXVlc3Q=');

@$core.Deprecated('Use getUserInfoResponseDescriptor instead')
const GetUserInfoResponse$json = {
  '1': 'GetUserInfoResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.user.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `GetUserInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserInfoResponseDescriptor = $convert.base64Decode(
    'ChNHZXRVc2VySW5mb1Jlc3BvbnNlEiEKBHVzZXIYASABKAsyDS51c2VyLnYxLlVzZXJSBHVzZX'
    'I=');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'role', '3': 2, '4': 1, '5': 9, '10': 'role'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRISCgRyb2xlGAIgASgJUgRyb2xl');
