// This is a generated file - do not edit.
//
// Generated from mam/v1/mam.proto.

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

import 'mam.pb.dart' as $0;

export 'mam.pb.dart';

@$pb.GrpcServiceName('mam.v1.MamService')
class MamServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MamServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.SearchResults> search(
    $0.Query request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$search, request, options: options);
  }

  $grpc.ResponseFuture<$0.VipResponse> buyVip(
    $0.VipRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$buyVip, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserData> getProfile(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProfile, request, options: options);
  }

  $grpc.ResponseFuture<$0.BonusResponse> buyBonus(
    $0.BonusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$buyBonus, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsMamSetupResponse> isMamSetup(
    $0.IsMamSetupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$isMamSetup, request, options: options);
  }

  // method descriptors

  static final _$search = $grpc.ClientMethod<$0.Query, $0.SearchResults>(
      '/mam.v1.MamService/Search',
      ($0.Query value) => value.writeToBuffer(),
      $0.SearchResults.fromBuffer);
  static final _$buyVip = $grpc.ClientMethod<$0.VipRequest, $0.VipResponse>(
      '/mam.v1.MamService/BuyVip',
      ($0.VipRequest value) => value.writeToBuffer(),
      $0.VipResponse.fromBuffer);
  static final _$getProfile = $grpc.ClientMethod<$0.Empty, $0.UserData>(
      '/mam.v1.MamService/GetProfile',
      ($0.Empty value) => value.writeToBuffer(),
      $0.UserData.fromBuffer);
  static final _$buyBonus =
      $grpc.ClientMethod<$0.BonusRequest, $0.BonusResponse>(
          '/mam.v1.MamService/BuyBonus',
          ($0.BonusRequest value) => value.writeToBuffer(),
          $0.BonusResponse.fromBuffer);
  static final _$isMamSetup =
      $grpc.ClientMethod<$0.IsMamSetupRequest, $0.IsMamSetupResponse>(
          '/mam.v1.MamService/IsMamSetup',
          ($0.IsMamSetupRequest value) => value.writeToBuffer(),
          $0.IsMamSetupResponse.fromBuffer);
}

@$pb.GrpcServiceName('mam.v1.MamService')
abstract class MamServiceBase extends $grpc.Service {
  $core.String get $name => 'mam.v1.MamService';

  MamServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Query, $0.SearchResults>(
        'Search',
        search_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Query.fromBuffer(value),
        ($0.SearchResults value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VipRequest, $0.VipResponse>(
        'BuyVip',
        buyVip_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VipRequest.fromBuffer(value),
        ($0.VipResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.UserData>(
        'GetProfile',
        getProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.UserData value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BonusRequest, $0.BonusResponse>(
        'BuyBonus',
        buyBonus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BonusRequest.fromBuffer(value),
        ($0.BonusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.IsMamSetupRequest, $0.IsMamSetupResponse>(
        'IsMamSetup',
        isMamSetup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.IsMamSetupRequest.fromBuffer(value),
        ($0.IsMamSetupResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SearchResults> search_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Query> $request) async {
    return search($call, await $request);
  }

  $async.Future<$0.SearchResults> search(
      $grpc.ServiceCall call, $0.Query request);

  $async.Future<$0.VipResponse> buyVip_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.VipRequest> $request) async {
    return buyVip($call, await $request);
  }

  $async.Future<$0.VipResponse> buyVip(
      $grpc.ServiceCall call, $0.VipRequest request);

  $async.Future<$0.UserData> getProfile_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return getProfile($call, await $request);
  }

  $async.Future<$0.UserData> getProfile(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$0.BonusResponse> buyBonus_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.BonusRequest> $request) async {
    return buyBonus($call, await $request);
  }

  $async.Future<$0.BonusResponse> buyBonus(
      $grpc.ServiceCall call, $0.BonusRequest request);

  $async.Future<$0.IsMamSetupResponse> isMamSetup_Pre($grpc.ServiceCall $call,
      $async.Future<$0.IsMamSetupRequest> $request) async {
    return isMamSetup($call, await $request);
  }

  $async.Future<$0.IsMamSetupResponse> isMamSetup(
      $grpc.ServiceCall call, $0.IsMamSetupRequest request);
}
