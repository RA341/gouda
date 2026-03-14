// This is a generated file - do not edit.
//
// Generated from user/v1/user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $0;
import 'user.pbjson.dart';

export 'user.pb.dart';

abstract class UserServiceBase extends $pb.GeneratedService {
  $async.Future<$0.ListUsersResponse> userList(
      $pb.ServerContext ctx, $0.ListUsersRequest request);
  $async.Future<$0.AddUserResponse> userAdd(
      $pb.ServerContext ctx, $0.AddUserRequest request);
  $async.Future<$0.UserDeleteResponse> userDelete(
      $pb.ServerContext ctx, $0.UserDeleteRequest request);
  $async.Future<$0.UserEditResponse> userEdit(
      $pb.ServerContext ctx, $0.UserEditRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'UserList':
        return $0.ListUsersRequest();
      case 'UserAdd':
        return $0.AddUserRequest();
      case 'UserDelete':
        return $0.UserDeleteRequest();
      case 'UserEdit':
        return $0.UserEditRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'UserList':
        return userList(ctx, request as $0.ListUsersRequest);
      case 'UserAdd':
        return userAdd(ctx, request as $0.AddUserRequest);
      case 'UserDelete':
        return userDelete(ctx, request as $0.UserDeleteRequest);
      case 'UserEdit':
        return userEdit(ctx, request as $0.UserEditRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => UserServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => UserServiceBase$messageJson;
}
