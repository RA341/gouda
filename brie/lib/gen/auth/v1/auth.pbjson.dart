// This is a generated file - do not edit.
//
// Generated from auth/v1/auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
  '2': [
    {'1': 'refresh', '3': 2, '4': 1, '5': 9, '10': 'refresh'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert
    .base64Decode('Cg1Mb2dvdXRSZXF1ZXN0EhgKB3JlZnJlc2gYAiABKAlSB3JlZnJlc2g=');

@$core.Deprecated('Use logoutResponseDescriptor instead')
const LogoutResponse$json = {
  '1': 'LogoutResponse',
};

/// Descriptor for `LogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutResponseDescriptor =
    $convert.base64Decode('Cg5Mb2dvdXRSZXNwb25zZQ==');

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW1lEhoKCHBhc3N3b3JkGA'
    'IgASgJUghwYXNzd29yZA==');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {
      '1': 'session',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.auth.v1.Session',
      '10': 'session'
    },
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode(
    'Cg1Mb2dpblJlc3BvbnNlEioKB3Nlc3Npb24YASABKAsyEC5hdXRoLnYxLlNlc3Npb25SB3Nlc3'
    'Npb24=');

@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = {
  '1': 'RegisterRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'passwordVerify', '3': 3, '4': 1, '5': 9, '10': 'passwordVerify'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode(
    'Cg9SZWdpc3RlclJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW1lEhoKCHBhc3N3b3'
    'JkGAIgASgJUghwYXNzd29yZBImCg5wYXNzd29yZFZlcmlmeRgDIAEoCVIOcGFzc3dvcmRWZXJp'
    'Znk=');

@$core.Deprecated('Use registerResponseDescriptor instead')
const RegisterResponse$json = {
  '1': 'RegisterResponse',
};

/// Descriptor for `RegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerResponseDescriptor =
    $convert.base64Decode('ChBSZWdpc3RlclJlc3BvbnNl');

@$core.Deprecated('Use verifySessionRequestDescriptor instead')
const VerifySessionRequest$json = {
  '1': 'VerifySessionRequest',
  '2': [
    {'1': 'sessionToken', '3': 1, '4': 1, '5': 9, '10': 'sessionToken'},
  ],
};

/// Descriptor for `VerifySessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifySessionRequestDescriptor = $convert.base64Decode(
    'ChRWZXJpZnlTZXNzaW9uUmVxdWVzdBIiCgxzZXNzaW9uVG9rZW4YASABKAlSDHNlc3Npb25Ub2'
    'tlbg==');

@$core.Deprecated('Use verifySessionResponseDescriptor instead')
const VerifySessionResponse$json = {
  '1': 'VerifySessionResponse',
};

/// Descriptor for `VerifySessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifySessionResponseDescriptor =
    $convert.base64Decode('ChVWZXJpZnlTZXNzaW9uUmVzcG9uc2U=');

@$core.Deprecated('Use refreshSessionRequestDescriptor instead')
const RefreshSessionRequest$json = {
  '1': 'RefreshSessionRequest',
  '2': [
    {'1': 'refreshToken', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `RefreshSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshSessionRequestDescriptor = $convert.base64Decode(
    'ChVSZWZyZXNoU2Vzc2lvblJlcXVlc3QSIgoMcmVmcmVzaFRva2VuGAEgASgJUgxyZWZyZXNoVG'
    '9rZW4=');

@$core.Deprecated('Use refreshSessionResponseDescriptor instead')
const RefreshSessionResponse$json = {
  '1': 'RefreshSessionResponse',
  '2': [
    {
      '1': 'session',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.auth.v1.Session',
      '10': 'session'
    },
  ],
};

/// Descriptor for `RefreshSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshSessionResponseDescriptor =
    $convert.base64Decode(
        'ChZSZWZyZXNoU2Vzc2lvblJlc3BvbnNlEioKB3Nlc3Npb24YASABKAsyEC5hdXRoLnYxLlNlc3'
        'Npb25SB3Nlc3Npb24=');

@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = {
  '1': 'Session',
  '2': [
    {'1': 'refreshToken', '3': 1, '4': 1, '5': 9, '10': 'refreshToken'},
    {'1': 'sessionToken', '3': 2, '4': 1, '5': 9, '10': 'sessionToken'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode(
    'CgdTZXNzaW9uEiIKDHJlZnJlc2hUb2tlbhgBIAEoCVIMcmVmcmVzaFRva2VuEiIKDHNlc3Npb2'
    '5Ub2tlbhgCIAEoCVIMc2Vzc2lvblRva2Vu');
