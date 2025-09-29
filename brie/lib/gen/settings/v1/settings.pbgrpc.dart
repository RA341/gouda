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

  $grpc.ResponseFuture<$0.LoadSettingsResponse> loadSettings(
    $0.LoadSettingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$loadSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSettingsResponse> updateSettings(
    $0.UpdateSettingsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateMamSettingsResponse> updateMamSettings(
      $0.UpdateMamSettingsRequest request, {
        $grpc.CallOptions? options,
      }) {
    return $createUnaryCall(_$updateMamSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateTorrentClientResponse> updateTorrentClient(
      $0.UpdateTorrentClientRequest request, {
        $grpc.CallOptions? options,
      }) {
    return $createUnaryCall(_$updateTorrentClient, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateFolderPathsResponse> updateFolderPaths(
      $0.UpdateFolderPathsRequest request, {
        $grpc.CallOptions? options,
      }) {
    return $createUnaryCall(_$updateFolderPaths, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListDirectoriesResponse> listDirectories(
      $0.ListDirectoriesRequest request, {
        $grpc.CallOptions? options,
      }) {
    return $createUnaryCall(_$listDirectories, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMetadataResponse> getMetadata(
    $0.GetMetadataRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMetadata, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListSupportedClientsResponse> listSupportedClients(
    $0.ListSupportedClientsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listSupportedClients, request, options: options);
  }

  $grpc.ResponseFuture<$0.TestTorrentResponse> testClient(
    $0.TorrentClient request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$testClient, request, options: options);
  }

  // method descriptors

  static final _$loadSettings =
      $grpc.ClientMethod<$0.LoadSettingsRequest, $0.LoadSettingsResponse>(
          '/settings.v1.SettingsService/LoadSettings',
          ($0.LoadSettingsRequest value) => value.writeToBuffer(),
          $0.LoadSettingsResponse.fromBuffer);
  static final _$updateSettings =
      $grpc.ClientMethod<$0.UpdateSettingsRequest, $0.UpdateSettingsResponse>(
          '/settings.v1.SettingsService/UpdateSettings',
          ($0.UpdateSettingsRequest value) => value.writeToBuffer(),
          $0.UpdateSettingsResponse.fromBuffer);
  static final _$updateMamSettings = $grpc.ClientMethod<
      $0.UpdateMamSettingsRequest,
      $0.UpdateMamSettingsResponse>(
      '/settings.v1.SettingsService/UpdateMamSettings',
          ($0.UpdateMamSettingsRequest value) => value.writeToBuffer(),
      $0.UpdateMamSettingsResponse.fromBuffer);
  static final _$updateTorrentClient = $grpc.ClientMethod<
      $0.UpdateTorrentClientRequest,
      $0.UpdateTorrentClientResponse>(
      '/settings.v1.SettingsService/UpdateTorrentClient',
          ($0.UpdateTorrentClientRequest value) => value.writeToBuffer(),
      $0.UpdateTorrentClientResponse.fromBuffer);
  static final _$updateFolderPaths = $grpc.ClientMethod<
      $0.UpdateFolderPathsRequest,
      $0.UpdateFolderPathsResponse>(
      '/settings.v1.SettingsService/UpdateFolderPaths',
          ($0.UpdateFolderPathsRequest value) => value.writeToBuffer(),
      $0.UpdateFolderPathsResponse.fromBuffer);
  static final _$listDirectories =
  $grpc.ClientMethod<$0.ListDirectoriesRequest, $0.ListDirectoriesResponse>(
      '/settings.v1.SettingsService/ListDirectories',
          ($0.ListDirectoriesRequest value) => value.writeToBuffer(),
      $0.ListDirectoriesResponse.fromBuffer);
  static final _$getMetadata =
      $grpc.ClientMethod<$0.GetMetadataRequest, $0.GetMetadataResponse>(
          '/settings.v1.SettingsService/GetMetadata',
          ($0.GetMetadataRequest value) => value.writeToBuffer(),
          $0.GetMetadataResponse.fromBuffer);
  static final _$listSupportedClients = $grpc.ClientMethod<
          $0.ListSupportedClientsRequest, $0.ListSupportedClientsResponse>(
      '/settings.v1.SettingsService/ListSupportedClients',
      ($0.ListSupportedClientsRequest value) => value.writeToBuffer(),
      $0.ListSupportedClientsResponse.fromBuffer);
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
    $addMethod(
        $grpc.ServiceMethod<$0.LoadSettingsRequest, $0.LoadSettingsResponse>(
            'LoadSettings',
            loadSettings_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.LoadSettingsRequest.fromBuffer(value),
            ($0.LoadSettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSettingsRequest,
            $0.UpdateSettingsResponse>(
        'UpdateSettings',
        updateSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateSettingsRequest.fromBuffer(value),
        ($0.UpdateSettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateMamSettingsRequest,
        $0.UpdateMamSettingsResponse>(
        'UpdateMamSettings',
        updateMamSettings_Pre,
        false,
        false,
            ($core.List<$core.int> value) =>
            $0.UpdateMamSettingsRequest.fromBuffer(value),
            ($0.UpdateMamSettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateTorrentClientRequest,
        $0.UpdateTorrentClientResponse>(
        'UpdateTorrentClient',
        updateTorrentClient_Pre,
        false,
        false,
            ($core.List<$core.int> value) =>
            $0.UpdateTorrentClientRequest.fromBuffer(value),
            ($0.UpdateTorrentClientResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFolderPathsRequest,
        $0.UpdateFolderPathsResponse>(
        'UpdateFolderPaths',
        updateFolderPaths_Pre,
        false,
        false,
            ($core.List<$core.int> value) =>
            $0.UpdateFolderPathsRequest.fromBuffer(value),
            ($0.UpdateFolderPathsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListDirectoriesRequest,
        $0.ListDirectoriesResponse>(
        'ListDirectories',
        listDirectories_Pre,
        false,
        false,
            ($core.List<$core.int> value) =>
            $0.ListDirectoriesRequest.fromBuffer(value),
            ($0.ListDirectoriesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetMetadataRequest, $0.GetMetadataResponse>(
            'GetMetadata',
            getMetadata_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetMetadataRequest.fromBuffer(value),
            ($0.GetMetadataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListSupportedClientsRequest,
            $0.ListSupportedClientsResponse>(
        'ListSupportedClients',
        listSupportedClients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListSupportedClientsRequest.fromBuffer(value),
        ($0.ListSupportedClientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TorrentClient, $0.TestTorrentResponse>(
        'TestClient',
        testClient_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TorrentClient.fromBuffer(value),
        ($0.TestTorrentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.LoadSettingsResponse> loadSettings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.LoadSettingsRequest> $request) async {
    return loadSettings($call, await $request);
  }

  $async.Future<$0.LoadSettingsResponse> loadSettings(
      $grpc.ServiceCall call, $0.LoadSettingsRequest request);

  $async.Future<$0.UpdateSettingsResponse> updateSettings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateSettingsRequest> $request) async {
    return updateSettings($call, await $request);
  }

  $async.Future<$0.UpdateSettingsResponse> updateSettings(
      $grpc.ServiceCall call, $0.UpdateSettingsRequest request);

  $async.Future<$0.UpdateMamSettingsResponse> updateMamSettings_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateMamSettingsRequest> $request) async {
    return updateMamSettings($call, await $request);
  }

  $async.Future<$0.UpdateMamSettingsResponse> updateMamSettings(
      $grpc.ServiceCall call, $0.UpdateMamSettingsRequest request);

  $async.Future<$0.UpdateTorrentClientResponse> updateTorrentClient_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateTorrentClientRequest> $request) async {
    return updateTorrentClient($call, await $request);
  }

  $async.Future<$0.UpdateTorrentClientResponse> updateTorrentClient(
      $grpc.ServiceCall call, $0.UpdateTorrentClientRequest request);

  $async.Future<$0.UpdateFolderPathsResponse> updateFolderPaths_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateFolderPathsRequest> $request) async {
    return updateFolderPaths($call, await $request);
  }

  $async.Future<$0.UpdateFolderPathsResponse> updateFolderPaths(
      $grpc.ServiceCall call, $0.UpdateFolderPathsRequest request);

  $async.Future<$0.ListDirectoriesResponse> listDirectories_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListDirectoriesRequest> $request) async {
    return listDirectories($call, await $request);
  }

  $async.Future<$0.ListDirectoriesResponse> listDirectories(
      $grpc.ServiceCall call, $0.ListDirectoriesRequest request);

  $async.Future<$0.GetMetadataResponse> getMetadata_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetMetadataRequest> $request) async {
    return getMetadata($call, await $request);
  }

  $async.Future<$0.GetMetadataResponse> getMetadata(
      $grpc.ServiceCall call, $0.GetMetadataRequest request);

  $async.Future<$0.ListSupportedClientsResponse> listSupportedClients_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListSupportedClientsRequest> $request) async {
    return listSupportedClients($call, await $request);
  }

  $async.Future<$0.ListSupportedClientsResponse> listSupportedClients(
      $grpc.ServiceCall call, $0.ListSupportedClientsRequest request);

  $async.Future<$0.TestTorrentResponse> testClient_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.TorrentClient> $request) async {
    return testClient($call, await $request);
  }

  $async.Future<$0.TestTorrentResponse> testClient(
      $grpc.ServiceCall call, $0.TorrentClient request);
}
