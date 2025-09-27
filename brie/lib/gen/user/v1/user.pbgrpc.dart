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

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $0;

export 'user.pb.dart';

@$pb.GrpcServiceName('user.v1.UserService')
class UserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  UserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetUserInfoResponse> getUserInfo(
    $0.GetUserInfoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserInfo, request, options: options);
  }

  // method descriptors

  static final _$getUserInfo =
      $grpc.ClientMethod<$0.GetUserInfoRequest, $0.GetUserInfoResponse>(
          '/user.v1.UserService/GetUserInfo',
          ($0.GetUserInfoRequest value) => value.writeToBuffer(),
          $0.GetUserInfoResponse.fromBuffer);
}

@$pb.GrpcServiceName('user.v1.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'user.v1.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GetUserInfoRequest, $0.GetUserInfoResponse>(
            'GetUserInfo',
            getUserInfo_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUserInfoRequest.fromBuffer(value),
            ($0.GetUserInfoResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetUserInfoResponse> getUserInfo_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetUserInfoRequest> $request) async {
    return getUserInfo($call, await $request);
  }

  $async.Future<$0.GetUserInfoResponse> getUserInfo(
      $grpc.ServiceCall call, $0.GetUserInfoRequest request);
}
