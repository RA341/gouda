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

@$core.Deprecated('Use userDeleteRequestDescriptor instead')
const UserDeleteRequest$json = {
  '1': 'UserDeleteRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 13, '10': 'userId'},
  ],
};

/// Descriptor for `UserDeleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDeleteRequestDescriptor = $convert.base64Decode(
    'ChFVc2VyRGVsZXRlUmVxdWVzdBIWCgZ1c2VySWQYASABKA1SBnVzZXJJZA==');

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
      '6': '.user.v1.User',
      '10': 'editUser'
    },
  ],
};

/// Descriptor for `UserEditRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userEditRequestDescriptor = $convert.base64Decode(
    'Cg9Vc2VyRWRpdFJlcXVlc3QSKQoIZWRpdFVzZXIYASABKAsyDS51c2VyLnYxLlVzZXJSCGVkaX'
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
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.user.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `AddUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addUserRequestDescriptor = $convert.base64Decode(
    'Cg5BZGRVc2VyUmVxdWVzdBIhCgR1c2VyGAEgASgLMg0udXNlci52MS5Vc2VyUgR1c2Vy');

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
      '6': '.user.v1.User',
      '10': 'users'
    },
  ],
};

/// Descriptor for `ListUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUsersResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0VXNlcnNSZXNwb25zZRIjCgV1c2VycxgBIAMoCzINLnVzZXIudjEuVXNlclIFdXNlcn'
    'M=');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'UserId', '3': 1, '4': 1, '5': 13, '10': 'UserId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    {'1': 'role', '3': 4, '4': 1, '5': 14, '6': '.user.v1.Role', '10': 'role'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEhYKBlVzZXJJZBgBIAEoDVIGVXNlcklkEhoKCHVzZXJuYW1lGAIgASgJUgh1c2Vybm'
    'FtZRIaCghwYXNzd29yZBgDIAEoCVIIcGFzc3dvcmQSIQoEcm9sZRgEIAEoDjINLnVzZXIudjEu'
    'Um9sZVIEcm9sZQ==');

const $core.Map<$core.String, $core.dynamic> UserServiceBase$json = {
  '1': 'UserService',
  '2': [
    {
      '1': 'UserList',
      '2': '.user.v1.ListUsersRequest',
      '3': '.user.v1.ListUsersResponse',
      '4': {}
    },
    {
      '1': 'UserAdd',
      '2': '.user.v1.AddUserRequest',
      '3': '.user.v1.AddUserResponse',
      '4': {}
    },
    {
      '1': 'UserDelete',
      '2': '.user.v1.UserDeleteRequest',
      '3': '.user.v1.UserDeleteResponse',
      '4': {}
    },
    {
      '1': 'UserEdit',
      '2': '.user.v1.UserEditRequest',
      '3': '.user.v1.UserEditResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use userServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    UserServiceBase$messageJson = {
  '.user.v1.ListUsersRequest': ListUsersRequest$json,
  '.user.v1.ListUsersResponse': ListUsersResponse$json,
  '.user.v1.User': User$json,
  '.user.v1.AddUserRequest': AddUserRequest$json,
  '.user.v1.AddUserResponse': AddUserResponse$json,
  '.user.v1.UserDeleteRequest': UserDeleteRequest$json,
  '.user.v1.UserDeleteResponse': UserDeleteResponse$json,
  '.user.v1.UserEditRequest': UserEditRequest$json,
  '.user.v1.UserEditResponse': UserEditResponse$json,
};

/// Descriptor for `UserService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List userServiceDescriptor = $convert.base64Decode(
    'CgtVc2VyU2VydmljZRJDCghVc2VyTGlzdBIZLnVzZXIudjEuTGlzdFVzZXJzUmVxdWVzdBoaLn'
    'VzZXIudjEuTGlzdFVzZXJzUmVzcG9uc2UiABI+CgdVc2VyQWRkEhcudXNlci52MS5BZGRVc2Vy'
    'UmVxdWVzdBoYLnVzZXIudjEuQWRkVXNlclJlc3BvbnNlIgASRwoKVXNlckRlbGV0ZRIaLnVzZX'
    'IudjEuVXNlckRlbGV0ZVJlcXVlc3QaGy51c2VyLnYxLlVzZXJEZWxldGVSZXNwb25zZSIAEkEK'
    'CFVzZXJFZGl0EhgudXNlci52MS5Vc2VyRWRpdFJlcXVlc3QaGS51c2VyLnYxLlVzZXJFZGl0Um'
    'VzcG9uc2UiAA==');
