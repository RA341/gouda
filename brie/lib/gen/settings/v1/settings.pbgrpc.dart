// This is a generated file - do not edit.
//
// Generated from settings/v1/settings.proto.

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

import 'settings.pb.dart' as $0;

export 'settings.pb.dart';

@$pb.GrpcServiceName('settings.v1.SettingsService')
class SettingsServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SettingsServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.UpdateSettingsResponse> updateSettings(
    $0.Settings request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.Settings> listSettings(
    $0.ListSettingsResponse request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListSupportedClientsResponse> listSupportedClients(
    $0.ListSupportedClientsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listSupportedClients, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMetadataResponse> getMetadata(
    $0.GetMetadataRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMetadata, request, options: options);
  }

  $grpc.ResponseFuture<$0.TestTorrentResponse> testClient(
    $0.TorrentClient request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$testClient, request, options: options);
  }

  // method descriptors

  static final _$updateSettings =
      $grpc.ClientMethod<$0.Settings, $0.UpdateSettingsResponse>(
          '/settings.v1.SettingsService/UpdateSettings',
          ($0.Settings value) => value.writeToBuffer(),
          $0.UpdateSettingsResponse.fromBuffer);
  static final _$listSettings =
      $grpc.ClientMethod<$0.ListSettingsResponse, $0.Settings>(
          '/settings.v1.SettingsService/ListSettings',
          ($0.ListSettingsResponse value) => value.writeToBuffer(),
          $0.Settings.fromBuffer);
  static final _$listSupportedClients = $grpc.ClientMethod<
          $0.ListSupportedClientsRequest, $0.ListSupportedClientsResponse>(
      '/settings.v1.SettingsService/ListSupportedClients',
      ($0.ListSupportedClientsRequest value) => value.writeToBuffer(),
      $0.ListSupportedClientsResponse.fromBuffer);
  static final _$getMetadata =
      $grpc.ClientMethod<$0.GetMetadataRequest, $0.GetMetadataResponse>(
          '/settings.v1.SettingsService/GetMetadata',
          ($0.GetMetadataRequest value) => value.writeToBuffer(),
          $0.GetMetadataResponse.fromBuffer);
  static final _$testClient =
      $grpc.ClientMethod<$0.TorrentClient, $0.TestTorrentResponse>(
          '/settings.v1.SettingsService/TestClient',
          ($0.TorrentClient value) => value.writeToBuffer(),
          $0.TestTorrentResponse.fromBuffer);
}

@$pb.GrpcServiceName('settings.v1.SettingsService')
abstract class SettingsServiceBase extends $grpc.Service {
  $core.String get $name => 'settings.v1.SettingsService';

  SettingsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Settings, $0.UpdateSettingsResponse>(
        'UpdateSettings',
        updateSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Settings.fromBuffer(value),
        ($0.UpdateSettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListSettingsResponse, $0.Settings>(
        'ListSettings',
        listSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListSettingsResponse.fromBuffer(value),
        ($0.Settings value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListSupportedClientsRequest,
            $0.ListSupportedClientsResponse>(
        'ListSupportedClients',
        listSupportedClients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListSupportedClientsRequest.fromBuffer(value),
        ($0.ListSupportedClientsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetMetadataRequest, $0.GetMetadataResponse>(
            'GetMetadata',
            getMetadata_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetMetadataRequest.fromBuffer(value),
            ($0.GetMetadataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TorrentClient, $0.TestTorrentResponse>(
        'TestClient',
        testClient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TorrentClient.fromBuffer(value),
        ($0.TestTorrentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.UpdateSettingsResponse> updateSettings_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Settings> $request) async {
    return updateSettings($call, await $request);
  }

  $async.Future<$0.UpdateSettingsResponse> updateSettings(
      $grpc.ServiceCall call, $0.Settings request);

  $async.Future<$0.Settings> listSettings_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListSettingsResponse> $request) async {
    return listSettings($call, await $request);
  }

  $async.Future<$0.Settings> listSettings(
      $grpc.ServiceCall call, $0.ListSettingsResponse request);

  $async.Future<$0.ListSupportedClientsResponse> listSupportedClients_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListSupportedClientsRequest> $request) async {
    return listSupportedClients($call, await $request);
  }

  $async.Future<$0.ListSupportedClientsResponse> listSupportedClients(
      $grpc.ServiceCall call, $0.ListSupportedClientsRequest request);

  $async.Future<$0.GetMetadataResponse> getMetadata_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetMetadataRequest> $request) async {
    return getMetadata($call, await $request);
  }

  $async.Future<$0.GetMetadataResponse> getMetadata(
      $grpc.ServiceCall call, $0.GetMetadataRequest request);

  $async.Future<$0.TestTorrentResponse> testClient_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.TorrentClient> $request) async {
    return testClient($call, await $request);
  }

  $async.Future<$0.TestTorrentResponse> testClient(
      $grpc.ServiceCall call, $0.TorrentClient request);
}
