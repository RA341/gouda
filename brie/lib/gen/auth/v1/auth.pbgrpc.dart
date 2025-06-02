//
//  Generated code. Do not modify.
//  source: auth/v1/auth.proto
//
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

  static final _$authenticate = $grpc.ClientMethod<$0.AuthRequest, $0.AuthResponse>(
      '/auth.v1.AuthService/Authenticate',
      ($0.AuthRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AuthResponse.fromBuffer(value));
  static final _$test = $grpc.ClientMethod<$0.AuthResponse, $0.TestResponse>(
      '/auth.v1.AuthService/Test',
      ($0.AuthResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TestResponse.fromBuffer(value));

  AuthServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.AuthResponse> authenticate($0.AuthRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$authenticate, request, options: options);
  }

  $grpc.ResponseFuture<$0.TestResponse> test($0.AuthResponse request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$test, request, options: options);
  }
}

@$pb.GrpcServiceName('auth.v1.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.v1.AuthService';

  AuthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AuthRequest, $0.AuthResponse>(
        'Authenticate',
        authenticate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AuthRequest.fromBuffer(value),
        ($0.AuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AuthResponse, $0.TestResponse>(
        'Test',
        test_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AuthResponse.fromBuffer(value),
        ($0.TestResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthResponse> authenticate_Pre($grpc.ServiceCall $call, $async.Future<$0.AuthRequest> $request) async {
    return authenticate($call, await $request);
  }

  $async.Future<$0.TestResponse> test_Pre($grpc.ServiceCall $call, $async.Future<$0.AuthResponse> $request) async {
    return test($call, await $request);
  }

  $async.Future<$0.AuthResponse> authenticate($grpc.ServiceCall call, $0.AuthRequest request);
  $async.Future<$0.TestResponse> test($grpc.ServiceCall call, $0.AuthResponse request);
}
