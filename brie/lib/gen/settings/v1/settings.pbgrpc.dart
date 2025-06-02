//
//  Generated code. Do not modify.
//  source: settings/v1/settings.proto
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

import 'settings.pb.dart' as $3;

export 'settings.pb.dart';

@$pb.GrpcServiceName('settings.v1.SettingsService')
class SettingsServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$updateSettings = $grpc.ClientMethod<$3.Settings, $3.UpdateSettingsResponse>(
      '/settings.v1.SettingsService/UpdateSettings',
      ($3.Settings value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.UpdateSettingsResponse.fromBuffer(value));
  static final _$listSettings = $grpc.ClientMethod<$3.ListSettingsResponse, $3.Settings>(
      '/settings.v1.SettingsService/ListSettings',
      ($3.ListSettingsResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Settings.fromBuffer(value));
  static final _$listSupportedClients = $grpc.ClientMethod<$3.ListSupportedClientsRequest, $3.ListSupportedClientsResponse>(
      '/settings.v1.SettingsService/ListSupportedClients',
      ($3.ListSupportedClientsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.ListSupportedClientsResponse.fromBuffer(value));
  static final _$getMetadata = $grpc.ClientMethod<$3.GetMetadataRequest, $3.GetMetadataResponse>(
      '/settings.v1.SettingsService/GetMetadata',
      ($3.GetMetadataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetMetadataResponse.fromBuffer(value));
  static final _$testClient = $grpc.ClientMethod<$3.TorrentClient, $3.TestTorrentResponse>(
      '/settings.v1.SettingsService/TestClient',
      ($3.TorrentClient value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.TestTorrentResponse.fromBuffer(value));

  SettingsServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$3.UpdateSettingsResponse> updateSettings($3.Settings request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSettings, request, options: options);
  }

  $grpc.ResponseFuture<$3.Settings> listSettings($3.ListSettingsResponse request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSettings, request, options: options);
  }

  $grpc.ResponseFuture<$3.ListSupportedClientsResponse> listSupportedClients($3.ListSupportedClientsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSupportedClients, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetMetadataResponse> getMetadata($3.GetMetadataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMetadata, request, options: options);
  }

  $grpc.ResponseFuture<$3.TestTorrentResponse> testClient($3.TorrentClient request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testClient, request, options: options);
  }
}

@$pb.GrpcServiceName('settings.v1.SettingsService')
abstract class SettingsServiceBase extends $grpc.Service {
  $core.String get $name => 'settings.v1.SettingsService';

  SettingsServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.Settings, $3.UpdateSettingsResponse>(
        'UpdateSettings',
        updateSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.Settings.fromBuffer(value),
        ($3.UpdateSettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ListSettingsResponse, $3.Settings>(
        'ListSettings',
        listSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ListSettingsResponse.fromBuffer(value),
        ($3.Settings value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ListSupportedClientsRequest, $3.ListSupportedClientsResponse>(
        'ListSupportedClients',
        listSupportedClients_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ListSupportedClientsRequest.fromBuffer(value),
        ($3.ListSupportedClientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetMetadataRequest, $3.GetMetadataResponse>(
        'GetMetadata',
        getMetadata_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetMetadataRequest.fromBuffer(value),
        ($3.GetMetadataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.TorrentClient, $3.TestTorrentResponse>(
        'TestClient',
        testClient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.TorrentClient.fromBuffer(value),
        ($3.TestTorrentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.UpdateSettingsResponse> updateSettings_Pre($grpc.ServiceCall $call, $async.Future<$3.Settings> $request) async {
    return updateSettings($call, await $request);
  }

  $async.Future<$3.Settings> listSettings_Pre($grpc.ServiceCall $call, $async.Future<$3.ListSettingsResponse> $request) async {
    return listSettings($call, await $request);
  }

  $async.Future<$3.ListSupportedClientsResponse> listSupportedClients_Pre($grpc.ServiceCall $call, $async.Future<$3.ListSupportedClientsRequest> $request) async {
    return listSupportedClients($call, await $request);
  }

  $async.Future<$3.GetMetadataResponse> getMetadata_Pre($grpc.ServiceCall $call, $async.Future<$3.GetMetadataRequest> $request) async {
    return getMetadata($call, await $request);
  }

  $async.Future<$3.TestTorrentResponse> testClient_Pre($grpc.ServiceCall $call, $async.Future<$3.TorrentClient> $request) async {
    return testClient($call, await $request);
  }

  $async.Future<$3.UpdateSettingsResponse> updateSettings($grpc.ServiceCall call, $3.Settings request);
  $async.Future<$3.Settings> listSettings($grpc.ServiceCall call, $3.ListSettingsResponse request);
  $async.Future<$3.ListSupportedClientsResponse> listSupportedClients($grpc.ServiceCall call, $3.ListSupportedClientsRequest request);
  $async.Future<$3.GetMetadataResponse> getMetadata($grpc.ServiceCall call, $3.GetMetadataRequest request);
  $async.Future<$3.TestTorrentResponse> testClient($grpc.ServiceCall call, $3.TorrentClient request);
}
