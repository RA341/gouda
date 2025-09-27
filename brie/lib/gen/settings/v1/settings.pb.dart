// This is a generated file - do not edit.
//
// Generated from settings/v1/settings.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UpdateMamTokenRequest extends $pb.GeneratedMessage {
  factory UpdateMamTokenRequest() => create();

  UpdateMamTokenRequest._();

  factory UpdateMamTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMamTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMamTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMamTokenRequest clone() =>
      UpdateMamTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMamTokenRequest copyWith(
          void Function(UpdateMamTokenRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateMamTokenRequest))
          as UpdateMamTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMamTokenRequest create() => UpdateMamTokenRequest._();
  @$core.override
  UpdateMamTokenRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMamTokenRequest> createRepeated() =>
      $pb.PbList<UpdateMamTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMamTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMamTokenRequest>(create);
  static UpdateMamTokenRequest? _defaultInstance;
}

class UpdateMamTokenResponse extends $pb.GeneratedMessage {
  factory UpdateMamTokenResponse() => create();

  UpdateMamTokenResponse._();

  factory UpdateMamTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMamTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMamTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMamTokenResponse clone() =>
      UpdateMamTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMamTokenResponse copyWith(
          void Function(UpdateMamTokenResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateMamTokenResponse))
          as UpdateMamTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMamTokenResponse create() => UpdateMamTokenResponse._();
  @$core.override
  UpdateMamTokenResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateMamTokenResponse> createRepeated() =>
      $pb.PbList<UpdateMamTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateMamTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMamTokenResponse>(create);
  static UpdateMamTokenResponse? _defaultInstance;
}

class GetMetadataRequest extends $pb.GeneratedMessage {
  factory GetMetadataRequest() => create();

  GetMetadataRequest._();

  factory GetMetadataRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMetadataRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMetadataRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMetadataRequest clone() => GetMetadataRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMetadataRequest copyWith(void Function(GetMetadataRequest) updates) =>
      super.copyWith((message) => updates(message as GetMetadataRequest))
          as GetMetadataRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMetadataRequest create() => GetMetadataRequest._();
  @$core.override
  GetMetadataRequest createEmptyInstance() => create();
  static $pb.PbList<GetMetadataRequest> createRepeated() =>
      $pb.PbList<GetMetadataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMetadataRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMetadataRequest>(create);
  static GetMetadataRequest? _defaultInstance;
}

class TestTorrentResponse extends $pb.GeneratedMessage {
  factory TestTorrentResponse() => create();

  TestTorrentResponse._();

  factory TestTorrentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TestTorrentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestTorrentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestTorrentResponse clone() => TestTorrentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestTorrentResponse copyWith(void Function(TestTorrentResponse) updates) =>
      super.copyWith((message) => updates(message as TestTorrentResponse))
          as TestTorrentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestTorrentResponse create() => TestTorrentResponse._();
  @$core.override
  TestTorrentResponse createEmptyInstance() => create();
  static $pb.PbList<TestTorrentResponse> createRepeated() =>
      $pb.PbList<TestTorrentResponse>();
  @$core.pragma('dart2js:noInline')
  static TestTorrentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestTorrentResponse>(create);
  static TestTorrentResponse? _defaultInstance;
}

class GetMetadataResponse extends $pb.GeneratedMessage {
  factory GetMetadataResponse({
    $core.String? version,
    $core.String? binaryType,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (binaryType != null) result.binaryType = binaryType;
    return result;
  }

  GetMetadataResponse._();

  factory GetMetadataResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMetadataResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMetadataResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'binaryType', protoName: 'binaryType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMetadataResponse clone() => GetMetadataResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMetadataResponse copyWith(void Function(GetMetadataResponse) updates) =>
      super.copyWith((message) => updates(message as GetMetadataResponse))
          as GetMetadataResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMetadataResponse create() => GetMetadataResponse._();
  @$core.override
  GetMetadataResponse createEmptyInstance() => create();
  static $pb.PbList<GetMetadataResponse> createRepeated() =>
      $pb.PbList<GetMetadataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMetadataResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMetadataResponse>(create);
  static GetMetadataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get binaryType => $_getSZ(1);
  @$pb.TagNumber(2)
  set binaryType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBinaryType() => $_has(1);
  @$pb.TagNumber(2)
  void clearBinaryType() => $_clearField(2);
}

class ListSupportedClientsRequest extends $pb.GeneratedMessage {
  factory ListSupportedClientsRequest() => create();

  ListSupportedClientsRequest._();

  factory ListSupportedClientsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSupportedClientsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSupportedClientsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSupportedClientsRequest clone() =>
      ListSupportedClientsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSupportedClientsRequest copyWith(
          void Function(ListSupportedClientsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListSupportedClientsRequest))
          as ListSupportedClientsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsRequest create() =>
      ListSupportedClientsRequest._();
  @$core.override
  ListSupportedClientsRequest createEmptyInstance() => create();
  static $pb.PbList<ListSupportedClientsRequest> createRepeated() =>
      $pb.PbList<ListSupportedClientsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSupportedClientsRequest>(create);
  static ListSupportedClientsRequest? _defaultInstance;
}

class ListSupportedClientsResponse extends $pb.GeneratedMessage {
  factory ListSupportedClientsResponse({
    $core.Iterable<$core.String>? clients,
  }) {
    final result = create();
    if (clients != null) result.clients.addAll(clients);
    return result;
  }

  ListSupportedClientsResponse._();

  factory ListSupportedClientsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSupportedClientsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSupportedClientsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'clients')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSupportedClientsResponse clone() =>
      ListSupportedClientsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSupportedClientsResponse copyWith(
          void Function(ListSupportedClientsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListSupportedClientsResponse))
          as ListSupportedClientsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsResponse create() =>
      ListSupportedClientsResponse._();
  @$core.override
  ListSupportedClientsResponse createEmptyInstance() => create();
  static $pb.PbList<ListSupportedClientsResponse> createRepeated() =>
      $pb.PbList<ListSupportedClientsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSupportedClientsResponse>(create);
  static ListSupportedClientsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get clients => $_getList(0);
}

class UpdateSettingsResponse extends $pb.GeneratedMessage {
  factory UpdateSettingsResponse() => create();

  UpdateSettingsResponse._();

  factory UpdateSettingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSettingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSettingsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSettingsResponse clone() =>
      UpdateSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSettingsResponse copyWith(
          void Function(UpdateSettingsResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateSettingsResponse))
          as UpdateSettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSettingsResponse create() => UpdateSettingsResponse._();
  @$core.override
  UpdateSettingsResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSettingsResponse> createRepeated() =>
      $pb.PbList<UpdateSettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSettingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSettingsResponse>(create);
  static UpdateSettingsResponse? _defaultInstance;
}

class ListSettingsResponse extends $pb.GeneratedMessage {
  factory ListSettingsResponse() => create();

  ListSettingsResponse._();

  factory ListSettingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSettingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSettingsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSettingsResponse clone() =>
      ListSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSettingsResponse copyWith(void Function(ListSettingsResponse) updates) =>
      super.copyWith((message) => updates(message as ListSettingsResponse))
          as ListSettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSettingsResponse create() => ListSettingsResponse._();
  @$core.override
  ListSettingsResponse createEmptyInstance() => create();
  static $pb.PbList<ListSettingsResponse> createRepeated() =>
      $pb.PbList<ListSettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSettingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSettingsResponse>(create);
  static ListSettingsResponse? _defaultInstance;
}

/// Top-level Gouda configuration
class GoudaConfig extends $pb.GeneratedMessage {
  factory GoudaConfig({
    $core.int? port,
    $core.String? allowedOrigins,
    $core.String? uiPath,
    $core.bool? auth,
    $core.String? mamToken,
    Directories? dir,
    Logger? log,
    Downloader? downloader,
    UserPermissions? permissions,
  }) {
    final result = create();
    if (port != null) result.port = port;
    if (allowedOrigins != null) result.allowedOrigins = allowedOrigins;
    if (uiPath != null) result.uiPath = uiPath;
    if (auth != null) result.auth = auth;
    if (mamToken != null) result.mamToken = mamToken;
    if (dir != null) result.dir = dir;
    if (log != null) result.log = log;
    if (downloader != null) result.downloader = downloader;
    if (permissions != null) result.permissions = permissions;
    return result;
  }

  GoudaConfig._();

  factory GoudaConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GoudaConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GoudaConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'port', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'allowedOrigins')
    ..aOS(3, _omitFieldNames ? '' : 'uiPath')
    ..aOB(4, _omitFieldNames ? '' : 'auth')
    ..aOS(5, _omitFieldNames ? '' : 'mamToken')
    ..aOM<Directories>(6, _omitFieldNames ? '' : 'dir',
        subBuilder: Directories.create)
    ..aOM<Logger>(7, _omitFieldNames ? '' : 'log', subBuilder: Logger.create)
    ..aOM<Downloader>(8, _omitFieldNames ? '' : 'downloader',
        subBuilder: Downloader.create)
    ..aOM<UserPermissions>(9, _omitFieldNames ? '' : 'permissions',
        subBuilder: UserPermissions.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GoudaConfig clone() => GoudaConfig()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GoudaConfig copyWith(void Function(GoudaConfig) updates) =>
      super.copyWith((message) => updates(message as GoudaConfig))
          as GoudaConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GoudaConfig create() => GoudaConfig._();
  @$core.override
  GoudaConfig createEmptyInstance() => create();
  static $pb.PbList<GoudaConfig> createRepeated() => $pb.PbList<GoudaConfig>();
  @$core.pragma('dart2js:noInline')
  static GoudaConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GoudaConfig>(create);
  static GoudaConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get port => $_getIZ(0);
  @$pb.TagNumber(1)
  set port($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPort() => $_has(0);
  @$pb.TagNumber(1)
  void clearPort() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get allowedOrigins => $_getSZ(1);
  @$pb.TagNumber(2)
  set allowedOrigins($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAllowedOrigins() => $_has(1);
  @$pb.TagNumber(2)
  void clearAllowedOrigins() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get uiPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set uiPath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUiPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearUiPath() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get auth => $_getBF(3);
  @$pb.TagNumber(4)
  set auth($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuth() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuth() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get mamToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set mamToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMamToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearMamToken() => $_clearField(5);

  @$pb.TagNumber(6)
  Directories get dir => $_getN(5);
  @$pb.TagNumber(6)
  set dir(Directories value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDir() => $_has(5);
  @$pb.TagNumber(6)
  void clearDir() => $_clearField(6);
  @$pb.TagNumber(6)
  Directories ensureDir() => $_ensure(5);

  @$pb.TagNumber(7)
  Logger get log => $_getN(6);
  @$pb.TagNumber(7)
  set log(Logger value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasLog() => $_has(6);
  @$pb.TagNumber(7)
  void clearLog() => $_clearField(7);
  @$pb.TagNumber(7)
  Logger ensureLog() => $_ensure(6);

  @$pb.TagNumber(8)
  Downloader get downloader => $_getN(7);
  @$pb.TagNumber(8)
  set downloader(Downloader value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasDownloader() => $_has(7);
  @$pb.TagNumber(8)
  void clearDownloader() => $_clearField(8);
  @$pb.TagNumber(8)
  Downloader ensureDownloader() => $_ensure(7);

  @$pb.TagNumber(9)
  UserPermissions get permissions => $_getN(8);
  @$pb.TagNumber(9)
  set permissions(UserPermissions value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPermissions() => $_has(8);
  @$pb.TagNumber(9)
  void clearPermissions() => $_clearField(9);
  @$pb.TagNumber(9)
  UserPermissions ensurePermissions() => $_ensure(8);
}

class Directories extends $pb.GeneratedMessage {
  factory Directories({
    $core.String? configDir,
    $core.String? downloadDir,
    $core.String? completeDir,
    $core.String? torrentDir,
  }) {
    final result = create();
    if (configDir != null) result.configDir = configDir;
    if (downloadDir != null) result.downloadDir = downloadDir;
    if (completeDir != null) result.completeDir = completeDir;
    if (torrentDir != null) result.torrentDir = torrentDir;
    return result;
  }

  Directories._();

  factory Directories.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Directories.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Directories',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'configDir')
    ..aOS(2, _omitFieldNames ? '' : 'downloadDir')
    ..aOS(3, _omitFieldNames ? '' : 'completeDir')
    ..aOS(4, _omitFieldNames ? '' : 'torrentDir')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Directories clone() => Directories()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Directories copyWith(void Function(Directories) updates) =>
      super.copyWith((message) => updates(message as Directories))
          as Directories;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Directories create() => Directories._();
  @$core.override
  Directories createEmptyInstance() => create();
  static $pb.PbList<Directories> createRepeated() => $pb.PbList<Directories>();
  @$core.pragma('dart2js:noInline')
  static Directories getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Directories>(create);
  static Directories? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get configDir => $_getSZ(0);
  @$pb.TagNumber(1)
  set configDir($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConfigDir() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfigDir() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get downloadDir => $_getSZ(1);
  @$pb.TagNumber(2)
  set downloadDir($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDownloadDir() => $_has(1);
  @$pb.TagNumber(2)
  void clearDownloadDir() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get completeDir => $_getSZ(2);
  @$pb.TagNumber(3)
  set completeDir($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCompleteDir() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompleteDir() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get torrentDir => $_getSZ(3);
  @$pb.TagNumber(4)
  set torrentDir($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTorrentDir() => $_has(3);
  @$pb.TagNumber(4)
  void clearTorrentDir() => $_clearField(4);
}

class Logger extends $pb.GeneratedMessage {
  factory Logger({
    $core.String? level,
    $core.bool? verbose,
  }) {
    final result = create();
    if (level != null) result.level = level;
    if (verbose != null) result.verbose = verbose;
    return result;
  }

  Logger._();

  factory Logger.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Logger.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Logger',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'level')
    ..aOB(2, _omitFieldNames ? '' : 'verbose')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Logger clone() => Logger()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Logger copyWith(void Function(Logger) updates) =>
      super.copyWith((message) => updates(message as Logger)) as Logger;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Logger create() => Logger._();
  @$core.override
  Logger createEmptyInstance() => create();
  static $pb.PbList<Logger> createRepeated() => $pb.PbList<Logger>();
  @$core.pragma('dart2js:noInline')
  static Logger getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Logger>(create);
  static Logger? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get level => $_getSZ(0);
  @$pb.TagNumber(1)
  set level($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get verbose => $_getBF(1);
  @$pb.TagNumber(2)
  set verbose($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerbose() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerbose() => $_clearField(2);
}

class Downloader extends $pb.GeneratedMessage {
  factory Downloader({
    $core.String? timeout,
    $core.bool? ignoreTimeout,
  }) {
    final result = create();
    if (timeout != null) result.timeout = timeout;
    if (ignoreTimeout != null) result.ignoreTimeout = ignoreTimeout;
    return result;
  }

  Downloader._();

  factory Downloader.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Downloader.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Downloader',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'timeout')
    ..aOB(2, _omitFieldNames ? '' : 'ignoreTimeout')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Downloader clone() => Downloader()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Downloader copyWith(void Function(Downloader) updates) =>
      super.copyWith((message) => updates(message as Downloader)) as Downloader;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Downloader create() => Downloader._();
  @$core.override
  Downloader createEmptyInstance() => create();
  static $pb.PbList<Downloader> createRepeated() => $pb.PbList<Downloader>();
  @$core.pragma('dart2js:noInline')
  static Downloader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Downloader>(create);
  static Downloader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get timeout => $_getSZ(0);
  @$pb.TagNumber(1)
  set timeout($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimeout() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeout() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get ignoreTimeout => $_getBF(1);
  @$pb.TagNumber(2)
  set ignoreTimeout($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIgnoreTimeout() => $_has(1);
  @$pb.TagNumber(2)
  void clearIgnoreTimeout() => $_clearField(2);
}

class UserPermissions extends $pb.GeneratedMessage {
  factory UserPermissions({
    $core.int? uid,
    $core.int? gid,
  }) {
    final result = create();
    if (uid != null) result.uid = uid;
    if (gid != null) result.gid = gid;
    return result;
  }

  UserPermissions._();

  factory UserPermissions.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserPermissions.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserPermissions',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'uid', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'gid', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPermissions clone() => UserPermissions()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPermissions copyWith(void Function(UserPermissions) updates) =>
      super.copyWith((message) => updates(message as UserPermissions))
          as UserPermissions;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserPermissions create() => UserPermissions._();
  @$core.override
  UserPermissions createEmptyInstance() => create();
  static $pb.PbList<UserPermissions> createRepeated() =>
      $pb.PbList<UserPermissions>();
  @$core.pragma('dart2js:noInline')
  static UserPermissions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserPermissions>(create);
  static UserPermissions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get uid => $_getIZ(0);
  @$pb.TagNumber(1)
  set uid($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get gid => $_getIZ(1);
  @$pb.TagNumber(2)
  set gid($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGid() => $_has(1);
  @$pb.TagNumber(2)
  void clearGid() => $_clearField(2);
}

class Settings extends $pb.GeneratedMessage {
  factory Settings({
    $core.String? apiKey,
    $core.String? serverPort,
    $fixnum.Int64? downloadCheckTimeout,
    $core.String? completeFolder,
    $core.String? downloadFolder,
    $core.String? torrentsFolder,
    $core.String? username,
    $core.String? password,
    $fixnum.Int64? userUid,
    $fixnum.Int64? groupUid,
    TorrentClient? client,
    $core.bool? exitOnClose,
    $core.bool? ignoreTimeout,
    $core.bool? setupComplete,
  }) {
    final result = create();
    if (apiKey != null) result.apiKey = apiKey;
    if (serverPort != null) result.serverPort = serverPort;
    if (downloadCheckTimeout != null)
      result.downloadCheckTimeout = downloadCheckTimeout;
    if (completeFolder != null) result.completeFolder = completeFolder;
    if (downloadFolder != null) result.downloadFolder = downloadFolder;
    if (torrentsFolder != null) result.torrentsFolder = torrentsFolder;
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    if (userUid != null) result.userUid = userUid;
    if (groupUid != null) result.groupUid = groupUid;
    if (client != null) result.client = client;
    if (exitOnClose != null) result.exitOnClose = exitOnClose;
    if (ignoreTimeout != null) result.ignoreTimeout = ignoreTimeout;
    if (setupComplete != null) result.setupComplete = setupComplete;
    return result;
  }

  Settings._();

  factory Settings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Settings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Settings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apiKey')
    ..aOS(2, _omitFieldNames ? '' : 'serverPort')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'downloadCheckTimeout', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'completeFolder')
    ..aOS(5, _omitFieldNames ? '' : 'downloadFolder')
    ..aOS(6, _omitFieldNames ? '' : 'torrentsFolder')
    ..aOS(7, _omitFieldNames ? '' : 'username')
    ..aOS(8, _omitFieldNames ? '' : 'password')
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'userUid', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        10, _omitFieldNames ? '' : 'groupUid', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<TorrentClient>(11, _omitFieldNames ? '' : 'client',
        subBuilder: TorrentClient.create)
    ..aOB(12, _omitFieldNames ? '' : 'exitOnClose')
    ..aOB(13, _omitFieldNames ? '' : 'ignoreTimeout')
    ..aOB(14, _omitFieldNames ? '' : 'setupComplete')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Settings clone() => Settings()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Settings copyWith(void Function(Settings) updates) =>
      super.copyWith((message) => updates(message as Settings)) as Settings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Settings create() => Settings._();
  @$core.override
  Settings createEmptyInstance() => create();
  static $pb.PbList<Settings> createRepeated() => $pb.PbList<Settings>();
  @$core.pragma('dart2js:noInline')
  static Settings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Settings>(create);
  static Settings? _defaultInstance;

  /// General settings
  @$pb.TagNumber(1)
  $core.String get apiKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set apiKey($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasApiKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearApiKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get serverPort => $_getSZ(1);
  @$pb.TagNumber(2)
  set serverPort($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServerPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerPort() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get downloadCheckTimeout => $_getI64(2);
  @$pb.TagNumber(3)
  set downloadCheckTimeout($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDownloadCheckTimeout() => $_has(2);
  @$pb.TagNumber(3)
  void clearDownloadCheckTimeout() => $_clearField(3);

  /// Folder settings
  @$pb.TagNumber(4)
  $core.String get completeFolder => $_getSZ(3);
  @$pb.TagNumber(4)
  set completeFolder($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCompleteFolder() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompleteFolder() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get downloadFolder => $_getSZ(4);
  @$pb.TagNumber(5)
  set downloadFolder($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDownloadFolder() => $_has(4);
  @$pb.TagNumber(5)
  void clearDownloadFolder() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get torrentsFolder => $_getSZ(5);
  @$pb.TagNumber(6)
  set torrentsFolder($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTorrentsFolder() => $_has(5);
  @$pb.TagNumber(6)
  void clearTorrentsFolder() => $_clearField(6);

  /// User settings
  @$pb.TagNumber(7)
  $core.String get username => $_getSZ(6);
  @$pb.TagNumber(7)
  set username($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearUsername() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get password => $_getSZ(7);
  @$pb.TagNumber(8)
  set password($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPassword() => $_has(7);
  @$pb.TagNumber(8)
  void clearPassword() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get userUid => $_getI64(8);
  @$pb.TagNumber(9)
  set userUid($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUserUid() => $_has(8);
  @$pb.TagNumber(9)
  void clearUserUid() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get groupUid => $_getI64(9);
  @$pb.TagNumber(10)
  set groupUid($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasGroupUid() => $_has(9);
  @$pb.TagNumber(10)
  void clearGroupUid() => $_clearField(10);

  /// Torrent settings
  @$pb.TagNumber(11)
  TorrentClient get client => $_getN(10);
  @$pb.TagNumber(11)
  set client(TorrentClient value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasClient() => $_has(10);
  @$pb.TagNumber(11)
  void clearClient() => $_clearField(11);
  @$pb.TagNumber(11)
  TorrentClient ensureClient() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.bool get exitOnClose => $_getBF(11);
  @$pb.TagNumber(12)
  set exitOnClose($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasExitOnClose() => $_has(11);
  @$pb.TagNumber(12)
  void clearExitOnClose() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get ignoreTimeout => $_getBF(12);
  @$pb.TagNumber(13)
  set ignoreTimeout($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIgnoreTimeout() => $_has(12);
  @$pb.TagNumber(13)
  void clearIgnoreTimeout() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get setupComplete => $_getBF(13);
  @$pb.TagNumber(14)
  set setupComplete($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSetupComplete() => $_has(13);
  @$pb.TagNumber(14)
  void clearSetupComplete() => $_clearField(14);
}

class TorrentClient extends $pb.GeneratedMessage {
  factory TorrentClient({
    $core.String? torrentHost,
    $core.String? torrentName,
    $core.String? torrentPassword,
    $core.String? torrentProtocol,
    $core.String? torrentUser,
  }) {
    final result = create();
    if (torrentHost != null) result.torrentHost = torrentHost;
    if (torrentName != null) result.torrentName = torrentName;
    if (torrentPassword != null) result.torrentPassword = torrentPassword;
    if (torrentProtocol != null) result.torrentProtocol = torrentProtocol;
    if (torrentUser != null) result.torrentUser = torrentUser;
    return result;
  }

  TorrentClient._();

  factory TorrentClient.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TorrentClient.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TorrentClient',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'torrentHost')
    ..aOS(2, _omitFieldNames ? '' : 'torrentName')
    ..aOS(3, _omitFieldNames ? '' : 'torrentPassword')
    ..aOS(4, _omitFieldNames ? '' : 'torrentProtocol')
    ..aOS(5, _omitFieldNames ? '' : 'torrentUser')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TorrentClient clone() => TorrentClient()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TorrentClient copyWith(void Function(TorrentClient) updates) =>
      super.copyWith((message) => updates(message as TorrentClient))
          as TorrentClient;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TorrentClient create() => TorrentClient._();
  @$core.override
  TorrentClient createEmptyInstance() => create();
  static $pb.PbList<TorrentClient> createRepeated() =>
      $pb.PbList<TorrentClient>();
  @$core.pragma('dart2js:noInline')
  static TorrentClient getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TorrentClient>(create);
  static TorrentClient? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get torrentHost => $_getSZ(0);
  @$pb.TagNumber(1)
  set torrentHost($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTorrentHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearTorrentHost() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get torrentName => $_getSZ(1);
  @$pb.TagNumber(2)
  set torrentName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTorrentName() => $_has(1);
  @$pb.TagNumber(2)
  void clearTorrentName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get torrentPassword => $_getSZ(2);
  @$pb.TagNumber(3)
  set torrentPassword($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTorrentPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearTorrentPassword() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get torrentProtocol => $_getSZ(3);
  @$pb.TagNumber(4)
  set torrentProtocol($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTorrentProtocol() => $_has(3);
  @$pb.TagNumber(4)
  void clearTorrentProtocol() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get torrentUser => $_getSZ(4);
  @$pb.TagNumber(5)
  set torrentUser($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTorrentUser() => $_has(4);
  @$pb.TagNumber(5)
  void clearTorrentUser() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
