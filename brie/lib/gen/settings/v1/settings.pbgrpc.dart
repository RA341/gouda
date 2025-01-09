//
//  Generated code. Do not modify.
//  source: settings/v1/settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'settings.pb.dart' as $3;

export 'settings.pb.dart';

@$pb.GrpcServiceName('settings.v1.SettingsService')
class SettingsServiceClient extends $grpc.Client {
  static final _$updateSettings = $grpc.ClientMethod<$3.Settings, $3.UpdateSettingsResponse>(
      '/settings.v1.SettingsService/UpdateSettings',
      ($3.Settings value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.UpdateSettingsResponse.fromBuffer(value));
  static final _$listSettings = $grpc.ClientMethod<$3.ListSettingsResponse, $3.Settings>(
      '/settings.v1.SettingsService/ListSettings',
      ($3.ListSettingsResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Settings.fromBuffer(value));

  SettingsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$3.UpdateSettingsResponse> updateSettings($3.Settings request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSettings, request, options: options);
  }

  $grpc.ResponseFuture<$3.Settings> listSettings($3.ListSettingsResponse request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listSettings, request, options: options);
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
  }

  $async.Future<$3.UpdateSettingsResponse> updateSettings_Pre($grpc.ServiceCall call, $async.Future<$3.Settings> request) async {
    return updateSettings(call, await request);
  }

  $async.Future<$3.Settings> listSettings_Pre($grpc.ServiceCall call, $async.Future<$3.ListSettingsResponse> request) async {
    return listSettings(call, await request);
  }

  $async.Future<$3.UpdateSettingsResponse> updateSettings($grpc.ServiceCall call, $3.Settings request);
  $async.Future<$3.Settings> listSettings($grpc.ServiceCall call, $3.ListSettingsResponse request);
}
