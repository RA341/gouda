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

import 'package:protobuf/protobuf.dart' as $pb;

import 'settings.pb.dart' as $0;
import 'settings.pbjson.dart';

export 'settings.pb.dart';

abstract class SettingsServiceBase extends $pb.GeneratedService {
  $async.Future<$0.LoadSettingsResponse> loadSettings($pb.ServerContext ctx,
      $0.LoadSettingsRequest request);

  $async.Future<$0.UpdateSettingsResponse> updateSettings($pb.ServerContext ctx,
      $0.UpdateSettingsRequest request);

  $async.Future<$0.UpdateMamResponse> updateMam($pb.ServerContext ctx,
      $0.UpdateMamRequest request);
  $async.Future<$0.UpdateDownloaderResponse> updateDownloader(
      $pb.ServerContext ctx, $0.UpdateDownloaderRequest request);

  $async.Future<$0.UpdateDirResponse> updateDir($pb.ServerContext ctx,
      $0.UpdateDirRequest request);
  $async.Future<$0.ListDirectoriesResponse> listDirectories(
      $pb.ServerContext ctx, $0.ListDirectoriesRequest request);
  $async.Future<$0.ListSupportedClientsResponse> listSupportedClients(
      $pb.ServerContext ctx, $0.ListSupportedClientsRequest request);

  $async.Future<$0.TestTorrentResponse> testClient($pb.ServerContext ctx,
      $0.TorrentClient request);

  $async.Future<$0.GetMetadataResponse> getMetadata($pb.ServerContext ctx,
      $0.GetMetadataRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'LoadSettings':
        return $0.LoadSettingsRequest();
      case 'UpdateSettings':
        return $0.UpdateSettingsRequest();
      case 'UpdateMam':
        return $0.UpdateMamRequest();
      case 'UpdateDownloader':
        return $0.UpdateDownloaderRequest();
      case 'UpdateDir':
        return $0.UpdateDirRequest();
      case 'ListDirectories':
        return $0.ListDirectoriesRequest();
      case 'ListSupportedClients':
        return $0.ListSupportedClientsRequest();
      case 'TestClient':
        return $0.TorrentClient();
      case 'GetMetadata':
        return $0.GetMetadataRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'LoadSettings':
        return loadSettings(ctx, request as $0.LoadSettingsRequest);
      case 'UpdateSettings':
        return updateSettings(ctx, request as $0.UpdateSettingsRequest);
      case 'UpdateMam':
        return updateMam(ctx, request as $0.UpdateMamRequest);
      case 'UpdateDownloader':
        return updateDownloader(ctx, request as $0.UpdateDownloaderRequest);
      case 'UpdateDir':
        return updateDir(ctx, request as $0.UpdateDirRequest);
      case 'ListDirectories':
        return listDirectories(ctx, request as $0.ListDirectoriesRequest);
      case 'ListSupportedClients':
        return listSupportedClients(
            ctx, request as $0.ListSupportedClientsRequest);
      case 'TestClient':
        return testClient(ctx, request as $0.TorrentClient);
      case 'GetMetadata':
        return getMetadata(ctx, request as $0.GetMetadataRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => SettingsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
  get $messageJson => SettingsServiceBase$messageJson;
}
