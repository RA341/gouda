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

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pb.dart' as $0;

export 'auth.pb.dart';

@$pb.GrpcServiceName('auth.v1.AuthService')
class AuthServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AuthServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.LoginResponse> login(
    $0.LoginRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.RegisterResponse> register(
    $0.RegisterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifySessionResponse> verifySession(
    $0.VerifySessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifySession, request, options: options);
  }

  $grpc.ResponseFuture<$0.RefreshSessionResponse> refreshSession(
    $0.RefreshSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$refreshSession, request, options: options);
  }

  // method descriptors

  static final _$login = $grpc.ClientMethod<$0.LoginRequest, $0.LoginResponse>(
      '/auth.v1.AuthService/Login',
      ($0.LoginRequest value) => value.writeToBuffer(),
      $0.LoginResponse.fromBuffer);
  static final _$register =
      $grpc.ClientMethod<$0.RegisterRequest, $0.RegisterResponse>(
          '/auth.v1.AuthService/Register',
          ($0.RegisterRequest value) => value.writeToBuffer(),
          $0.RegisterResponse.fromBuffer);
  static final _$verifySession =
      $grpc.ClientMethod<$0.VerifySessionRequest, $0.VerifySessionResponse>(
          '/auth.v1.AuthService/VerifySession',
          ($0.VerifySessionRequest value) => value.writeToBuffer(),
          $0.VerifySessionResponse.fromBuffer);
  static final _$refreshSession =
      $grpc.ClientMethod<$0.RefreshSessionRequest, $0.RefreshSessionResponse>(
          '/auth.v1.AuthService/RefreshSession',
          ($0.RefreshSessionRequest value) => value.writeToBuffer(),
          $0.RefreshSessionResponse.fromBuffer);
}

@$pb.GrpcServiceName('auth.v1.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.v1.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LoginRequest, $0.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegisterRequest, $0.RegisterResponse>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RegisterRequest.fromBuffer(value),
        ($0.RegisterResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.VerifySessionRequest, $0.VerifySessionResponse>(
            'VerifySession',
            verifySession_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.VerifySessionRequest.fromBuffer(value),
            ($0.VerifySessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RefreshSessionRequest,
            $0.RefreshSessionResponse>(
        'RefreshSession',
        refreshSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RefreshSessionRequest.fromBuffer(value),
        ($0.RefreshSessionResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.LoginResponse> login_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.LoginRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$0.LoginResponse> login(
      $grpc.ServiceCall call, $0.LoginRequest request);

  $async.Future<$0.RegisterResponse> register_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RegisterRequest> $request) async {
    return register($call, await $request);
  }

  $async.Future<$0.RegisterResponse> register(
      $grpc.ServiceCall call, $0.RegisterRequest request);

  $async.Future<$0.VerifySessionResponse> verifySession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifySessionRequest> $request) async {
    return verifySession($call, await $request);
  }

  $async.Future<$0.VerifySessionResponse> verifySession(
      $grpc.ServiceCall call, $0.VerifySessionRequest request);

  $async.Future<$0.RefreshSessionResponse> refreshSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RefreshSessionRequest> $request) async {
    return refreshSession($call, await $request);
  }

  $async.Future<$0.RefreshSessionResponse> refreshSession(
      $grpc.ServiceCall call, $0.RefreshSessionRequest request);
}
