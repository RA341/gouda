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

@$core.Deprecated('Use roleDescriptor instead')
const Role$json = {
  '1': 'Role',
  '2': [
    {'1': 'Admin', '2': 0},
    {'1': 'Mouse', '2': 1},
    {'1': 'Unknown', '2': 999},
  ],
};

/// Descriptor for `Role`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roleDescriptor = $convert
    .base64Decode('CgRSb2xlEgkKBUFkbWluEAASCQoFTW91c2UQARIMCgdVbmtub3duEOcH');

@$core.Deprecated('Use userProfileRequestDescriptor instead')
const UserProfileRequest$json = {
  '1': 'UserProfileRequest',
};

/// Descriptor for `UserProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userProfileRequestDescriptor =
$convert.base64Decode('ChJVc2VyUHJvZmlsZVJlcXVlc3Q=');

@$core.Deprecated('Use userProfileResponseDescriptor instead')
const UserProfileResponse$json = {
  '1': 'UserProfileResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auth.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `UserProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userProfileResponseDescriptor = $convert
    .base64Decode(
    'ChNVc2VyUHJvZmlsZVJlc3BvbnNlEiEKBHVzZXIYASABKAsyDS5hdXRoLnYxLlVzZXJSBHVzZX'
        'I=');

@$core.Deprecated('Use userDeleteRequestDescriptor instead')
const UserDeleteRequest$json = {
  '1': 'UserDeleteRequest',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auth.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `UserDeleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDeleteRequestDescriptor = $convert.base64Decode(
    'ChFVc2VyRGVsZXRlUmVxdWVzdBIhCgR1c2VyGAEgASgLMg0uYXV0aC52MS5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use userDeleteResponseDescriptor instead')
const UserDeleteResponse$json = {
  '1': 'UserDeleteResponse',
};

/// Descriptor for `UserDeleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDeleteResponseDescriptor =
$convert.base64Decode('ChJVc2VyRGVsZXRlUmVzcG9uc2U=');

@$core.Deprecated('Use userEditRequestDescriptor instead')
const UserEditRequest$json = {
  '1': 'UserEditRequest',
  '2': [
    {
      '1': 'editUser',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.auth.v1.User',
      '10': 'editUser'
    },
  ],
};

/// Descriptor for `UserEditRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userEditRequestDescriptor = $convert.base64Decode(
    'Cg9Vc2VyRWRpdFJlcXVlc3QSKQoIZWRpdFVzZXIYASABKAsyDS5hdXRoLnYxLlVzZXJSCGVkaX'
        'RVc2Vy');

@$core.Deprecated('Use userEditResponseDescriptor instead')
const UserEditResponse$json = {
  '1': 'UserEditResponse',
};

/// Descriptor for `UserEditResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userEditResponseDescriptor =
$convert.base64Decode('ChBVc2VyRWRpdFJlc3BvbnNl');

@$core.Deprecated('Use addUserRequestDescriptor instead')
const AddUserRequest$json = {
  '1': 'AddUserRequest',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auth.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `AddUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addUserRequestDescriptor = $convert.base64Decode(
    'Cg5BZGRVc2VyUmVxdWVzdBIhCgR1c2VyGAEgASgLMg0uYXV0aC52MS5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use addUserResponseDescriptor instead')
const AddUserResponse$json = {
  '1': 'AddUserResponse',
};

/// Descriptor for `AddUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addUserResponseDescriptor =
$convert.base64Decode('Cg9BZGRVc2VyUmVzcG9uc2U=');

@$core.Deprecated('Use listUsersRequestDescriptor instead')
const ListUsersRequest$json = {
  '1': 'ListUsersRequest',
};

/// Descriptor for `ListUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUsersRequestDescriptor =
$convert.base64Decode('ChBMaXN0VXNlcnNSZXF1ZXN0');

@$core.Deprecated('Use listUsersResponseDescriptor instead')
const ListUsersResponse$json = {
  '1': 'ListUsersResponse',
  '2': [
    {
      '1': 'users',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.auth.v1.User',
      '10': 'users'
    },
  ],
};

/// Descriptor for `ListUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUsersResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0VXNlcnNSZXNwb25zZRIjCgV1c2VycxgBIAMoCzINLmF1dGgudjEuVXNlclIFdXNlcn'
        'M=');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'role', '3': 3, '4': 1, '5': 14, '6': '.auth.v1.Role', '10': 'role'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIaCghwYXNzd29yZBgCIAEoCVIIcG'
        'Fzc3dvcmQSIQoEcm9sZRgDIAEoDjINLmF1dGgudjEuUm9sZVIEcm9sZQ==');

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

const $core.Map<$core.String, $core.dynamic> AuthServiceBase$json = {
  '1': 'AuthService',
  '2': [
    {
      '1': 'Login',
      '2': '.auth.v1.LoginRequest',
      '3': '.auth.v1.LoginResponse',
      '4': {}
    },
    {
      '1': 'Logout',
      '2': '.auth.v1.LogoutRequest',
      '3': '.auth.v1.LogoutResponse',
      '4': {}
    },
    {
      '1': 'UserList',
      '2': '.auth.v1.ListUsersRequest',
      '3': '.auth.v1.ListUsersResponse',
      '4': {}
    },
    {
      '1': 'UserAdd',
      '2': '.auth.v1.AddUserRequest',
      '3': '.auth.v1.AddUserResponse',
      '4': {}
    },
    {
      '1': 'UserDelete',
      '2': '.auth.v1.UserDeleteRequest',
      '3': '.auth.v1.UserDeleteResponse',
      '4': {}
    },
    {
      '1': 'UserEdit',
      '2': '.auth.v1.UserEditRequest',
      '3': '.auth.v1.UserEditResponse',
      '4': {}
    },
    {
      '1': 'UserProfile',
      '2': '.auth.v1.UserProfileRequest',
      '3': '.auth.v1.UserProfileResponse',
      '4': {}
    },
    {
      '1': 'VerifySession',
      '2': '.auth.v1.VerifySessionRequest',
      '3': '.auth.v1.VerifySessionResponse',
      '4': {}
    },
    {
      '1': 'RefreshSession',
      '2': '.auth.v1.RefreshSessionRequest',
      '3': '.auth.v1.RefreshSessionResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use authServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
AuthServiceBase$messageJson = {
  '.auth.v1.LoginRequest': LoginRequest$json,
  '.auth.v1.LoginResponse': LoginResponse$json,
  '.auth.v1.Session': Session$json,
  '.auth.v1.LogoutRequest': LogoutRequest$json,
  '.auth.v1.LogoutResponse': LogoutResponse$json,
  '.auth.v1.ListUsersRequest': ListUsersRequest$json,
  '.auth.v1.ListUsersResponse': ListUsersResponse$json,
  '.auth.v1.User': User$json,
  '.auth.v1.AddUserRequest': AddUserRequest$json,
  '.auth.v1.AddUserResponse': AddUserResponse$json,
  '.auth.v1.UserDeleteRequest': UserDeleteRequest$json,
  '.auth.v1.UserDeleteResponse': UserDeleteResponse$json,
  '.auth.v1.UserEditRequest': UserEditRequest$json,
  '.auth.v1.UserEditResponse': UserEditResponse$json,
  '.auth.v1.UserProfileRequest': UserProfileRequest$json,
  '.auth.v1.UserProfileResponse': UserProfileResponse$json,
  '.auth.v1.VerifySessionRequest': VerifySessionRequest$json,
  '.auth.v1.VerifySessionResponse': VerifySessionResponse$json,
  '.auth.v1.RefreshSessionRequest': RefreshSessionRequest$json,
  '.auth.v1.RefreshSessionResponse': RefreshSessionResponse$json,
};

/// Descriptor for `AuthService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List authServiceDescriptor = $convert.base64Decode(
    'CgtBdXRoU2VydmljZRI4CgVMb2dpbhIVLmF1dGgudjEuTG9naW5SZXF1ZXN0GhYuYXV0aC52MS'
        '5Mb2dpblJlc3BvbnNlIgASOwoGTG9nb3V0EhYuYXV0aC52MS5Mb2dvdXRSZXF1ZXN0GhcuYXV0'
        'aC52MS5Mb2dvdXRSZXNwb25zZSIAEkMKCFVzZXJMaXN0EhkuYXV0aC52MS5MaXN0VXNlcnNSZX'
        'F1ZXN0GhouYXV0aC52MS5MaXN0VXNlcnNSZXNwb25zZSIAEj4KB1VzZXJBZGQSFy5hdXRoLnYx'
        'LkFkZFVzZXJSZXF1ZXN0GhguYXV0aC52MS5BZGRVc2VyUmVzcG9uc2UiABJHCgpVc2VyRGVsZX'
        'RlEhouYXV0aC52MS5Vc2VyRGVsZXRlUmVxdWVzdBobLmF1dGgudjEuVXNlckRlbGV0ZVJlc3Bv'
        'bnNlIgASQQoIVXNlckVkaXQSGC5hdXRoLnYxLlVzZXJFZGl0UmVxdWVzdBoZLmF1dGgudjEuVX'
        'NlckVkaXRSZXNwb25zZSIAEkoKC1VzZXJQcm9maWxlEhsuYXV0aC52MS5Vc2VyUHJvZmlsZVJl'
        'cXVlc3QaHC5hdXRoLnYxLlVzZXJQcm9maWxlUmVzcG9uc2UiABJQCg1WZXJpZnlTZXNzaW9uEh'
        '0uYXV0aC52MS5WZXJpZnlTZXNzaW9uUmVxdWVzdBoeLmF1dGgudjEuVmVyaWZ5U2Vzc2lvblJl'
        'c3BvbnNlIgASUwoOUmVmcmVzaFNlc3Npb24SHi5hdXRoLnYxLlJlZnJlc2hTZXNzaW9uUmVxdW'
        'VzdBofLmF1dGgudjEuUmVmcmVzaFNlc3Npb25SZXNwb25zZSIA');
