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

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetMetadataRequest extends $pb.GeneratedMessage {
  factory GetMetadataRequest() => create();

  GetMetadataRequest._();

  factory GetMetadataRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetMetadataRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMetadataRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMetadataRequest clone() => GetMetadataRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMetadataRequest copyWith(void Function(GetMetadataRequest) updates) => super.copyWith((message) => updates(message as GetMetadataRequest)) as GetMetadataRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMetadataRequest create() => GetMetadataRequest._();
  @$core.override
  GetMetadataRequest createEmptyInstance() => create();
  static $pb.PbList<GetMetadataRequest> createRepeated() => $pb.PbList<GetMetadataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMetadataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMetadataRequest>(create);
  static GetMetadataRequest? _defaultInstance;
}

class TestTorrentResponse extends $pb.GeneratedMessage {
  factory TestTorrentResponse() => create();

  TestTorrentResponse._();

  factory TestTorrentResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TestTorrentResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TestTorrentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestTorrentResponse clone() => TestTorrentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TestTorrentResponse copyWith(void Function(TestTorrentResponse) updates) => super.copyWith((message) => updates(message as TestTorrentResponse)) as TestTorrentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestTorrentResponse create() => TestTorrentResponse._();
  @$core.override
  TestTorrentResponse createEmptyInstance() => create();
  static $pb.PbList<TestTorrentResponse> createRepeated() => $pb.PbList<TestTorrentResponse>();
  @$core.pragma('dart2js:noInline')
  static TestTorrentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestTorrentResponse>(create);
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

  factory GetMetadataResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetMetadataResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMetadataResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'binaryType', protoName: 'binaryType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMetadataResponse clone() => GetMetadataResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMetadataResponse copyWith(void Function(GetMetadataResponse) updates) => super.copyWith((message) => updates(message as GetMetadataResponse)) as GetMetadataResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMetadataResponse create() => GetMetadataResponse._();
  @$core.override
  GetMetadataResponse createEmptyInstance() => create();
  static $pb.PbList<GetMetadataResponse> createRepeated() => $pb.PbList<GetMetadataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMetadataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMetadataResponse>(create);
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

  factory ListSupportedClientsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListSupportedClientsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListSupportedClientsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSupportedClientsRequest clone() => ListSupportedClientsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSupportedClientsRequest copyWith(void Function(ListSupportedClientsRequest) updates) => super.copyWith((message) => updates(message as ListSupportedClientsRequest)) as ListSupportedClientsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsRequest create() => ListSupportedClientsRequest._();
  @$core.override
  ListSupportedClientsRequest createEmptyInstance() => create();
  static $pb.PbList<ListSupportedClientsRequest> createRepeated() => $pb.PbList<ListSupportedClientsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSupportedClientsRequest>(create);
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

  factory ListSupportedClientsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListSupportedClientsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListSupportedClientsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'clients')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSupportedClientsResponse clone() => ListSupportedClientsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSupportedClientsResponse copyWith(void Function(ListSupportedClientsResponse) updates) => super.copyWith((message) => updates(message as ListSupportedClientsResponse)) as ListSupportedClientsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsResponse create() => ListSupportedClientsResponse._();
  @$core.override
  ListSupportedClientsResponse createEmptyInstance() => create();
  static $pb.PbList<ListSupportedClientsResponse> createRepeated() => $pb.PbList<ListSupportedClientsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSupportedClientsResponse>(create);
  static ListSupportedClientsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get clients => $_getList(0);
}

class UpdateSettingsResponse extends $pb.GeneratedMessage {
  factory UpdateSettingsResponse() => create();

  UpdateSettingsResponse._();

  factory UpdateSettingsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateSettingsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSettingsResponse clone() => UpdateSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSettingsResponse copyWith(void Function(UpdateSettingsResponse) updates) => super.copyWith((message) => updates(message as UpdateSettingsResponse)) as UpdateSettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSettingsResponse create() => UpdateSettingsResponse._();
  @$core.override
  UpdateSettingsResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSettingsResponse> createRepeated() => $pb.PbList<UpdateSettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSettingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSettingsResponse>(create);
  static UpdateSettingsResponse? _defaultInstance;
}

class ListSettingsResponse extends $pb.GeneratedMessage {
  factory ListSettingsResponse() => create();

  ListSettingsResponse._();

  factory ListSettingsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListSettingsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListSettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSettingsResponse clone() => ListSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSettingsResponse copyWith(void Function(ListSettingsResponse) updates) => super.copyWith((message) => updates(message as ListSettingsResponse)) as ListSettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSettingsResponse create() => ListSettingsResponse._();
  @$core.override
  ListSettingsResponse createEmptyInstance() => create();
  static $pb.PbList<ListSettingsResponse> createRepeated() => $pb.PbList<ListSettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSettingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSettingsResponse>(create);
  static ListSettingsResponse? _defaultInstance;
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
    if (downloadCheckTimeout != null) result.downloadCheckTimeout = downloadCheckTimeout;
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

  factory Settings.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Settings.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Settings', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apiKey')
    ..aOS(2, _omitFieldNames ? '' : 'serverPort')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'downloadCheckTimeout', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'completeFolder')
    ..aOS(5, _omitFieldNames ? '' : 'downloadFolder')
    ..aOS(6, _omitFieldNames ? '' : 'torrentsFolder')
    ..aOS(7, _omitFieldNames ? '' : 'username')
    ..aOS(8, _omitFieldNames ? '' : 'password')
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'userUid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'groupUid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<TorrentClient>(11, _omitFieldNames ? '' : 'client', subBuilder: TorrentClient.create)
    ..aOB(12, _omitFieldNames ? '' : 'exitOnClose')
    ..aOB(13, _omitFieldNames ? '' : 'ignoreTimeout')
    ..aOB(14, _omitFieldNames ? '' : 'setupComplete')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Settings clone() => Settings()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Settings copyWith(void Function(Settings) updates) => super.copyWith((message) => updates(message as Settings)) as Settings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Settings create() => Settings._();
  @$core.override
  Settings createEmptyInstance() => create();
  static $pb.PbList<Settings> createRepeated() => $pb.PbList<Settings>();
  @$core.pragma('dart2js:noInline')
  static Settings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Settings>(create);
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

  factory TorrentClient.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TorrentClient.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TorrentClient', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'torrentHost')
    ..aOS(2, _omitFieldNames ? '' : 'torrentName')
    ..aOS(3, _omitFieldNames ? '' : 'torrentPassword')
    ..aOS(4, _omitFieldNames ? '' : 'torrentProtocol')
    ..aOS(5, _omitFieldNames ? '' : 'torrentUser')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TorrentClient clone() => TorrentClient()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TorrentClient copyWith(void Function(TorrentClient) updates) => super.copyWith((message) => updates(message as TorrentClient)) as TorrentClient;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TorrentClient create() => TorrentClient._();
  @$core.override
  TorrentClient createEmptyInstance() => create();
  static $pb.PbList<TorrentClient> createRepeated() => $pb.PbList<TorrentClient>();
  @$core.pragma('dart2js:noInline')
  static TorrentClient getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TorrentClient>(create);
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


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
