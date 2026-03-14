// This is a generated file - do not edit.
//
// Generated from auth/v1/auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pb.dart' as $1;
import 'auth.pbjson.dart';

export 'auth.pb.dart';

abstract class AuthServiceBase extends $pb.GeneratedService {
  $async.Future<$1.LoginResponse> login(
      $pb.ServerContext ctx, $1.LoginRequest request);
  $async.Future<$1.LogoutResponse> logout(
      $pb.ServerContext ctx, $1.LogoutRequest request);
  $async.Future<$1.UserProfileResponse> userProfile(
      $pb.ServerContext ctx, $1.UserProfileRequest request);
  $async.Future<$1.VerifySessionResponse> verifySession(
      $pb.ServerContext ctx, $1.VerifySessionRequest request);
  $async.Future<$1.RefreshSessionResponse> refreshSession(
      $pb.ServerContext ctx, $1.RefreshSessionRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Login':
        return $1.LoginRequest();
      case 'Logout':
        return $1.LogoutRequest();
      case 'UserProfile':
        return $1.UserProfileRequest();
      case 'VerifySession':
        return $1.VerifySessionRequest();
      case 'RefreshSession':
        return $1.RefreshSessionRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Login':
        return login(ctx, request as $1.LoginRequest);
      case 'Logout':
        return logout(ctx, request as $1.LogoutRequest);
      case 'UserProfile':
        return userProfile(ctx, request as $1.UserProfileRequest);
      case 'VerifySession':
        return verifySession(ctx, request as $1.VerifySessionRequest);
      case 'RefreshSession':
        return refreshSession(ctx, request as $1.RefreshSessionRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => AuthServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => AuthServiceBase$messageJson;
}
