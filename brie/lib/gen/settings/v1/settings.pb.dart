//
//  Generated code. Do not modify.
//  source: settings/v1/settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class GetProgramInfoRequest extends $pb.GeneratedMessage {
  factory GetProgramInfoRequest() => create();
  GetProgramInfoRequest._() : super();
  factory GetProgramInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProgramInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetProgramInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProgramInfoRequest clone() => GetProgramInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProgramInfoRequest copyWith(void Function(GetProgramInfoRequest) updates) => super.copyWith((message) => updates(message as GetProgramInfoRequest)) as GetProgramInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProgramInfoRequest create() => GetProgramInfoRequest._();
  GetProgramInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetProgramInfoRequest> createRepeated() => $pb.PbList<GetProgramInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProgramInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProgramInfoRequest>(create);
  static GetProgramInfoRequest? _defaultInstance;
}

class GetProgramInfoResponse extends $pb.GeneratedMessage {
  factory GetProgramInfoResponse({
    $core.String? version,
    $core.String? binaryType,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (binaryType != null) {
      $result.binaryType = binaryType;
    }
    return $result;
  }
  GetProgramInfoResponse._() : super();
  factory GetProgramInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProgramInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetProgramInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..aOS(2, _omitFieldNames ? '' : 'binaryType', protoName: 'binaryType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProgramInfoResponse clone() => GetProgramInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProgramInfoResponse copyWith(void Function(GetProgramInfoResponse) updates) => super.copyWith((message) => updates(message as GetProgramInfoResponse)) as GetProgramInfoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProgramInfoResponse create() => GetProgramInfoResponse._();
  GetProgramInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetProgramInfoResponse> createRepeated() => $pb.PbList<GetProgramInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetProgramInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProgramInfoResponse>(create);
  static GetProgramInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get binaryType => $_getSZ(1);
  @$pb.TagNumber(2)
  set binaryType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBinaryType() => $_has(1);
  @$pb.TagNumber(2)
  void clearBinaryType() => clearField(2);
}

class ListSupportedClientsRequest extends $pb.GeneratedMessage {
  factory ListSupportedClientsRequest() => create();
  ListSupportedClientsRequest._() : super();
  factory ListSupportedClientsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSupportedClientsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListSupportedClientsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListSupportedClientsRequest clone() => ListSupportedClientsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListSupportedClientsRequest copyWith(void Function(ListSupportedClientsRequest) updates) => super.copyWith((message) => updates(message as ListSupportedClientsRequest)) as ListSupportedClientsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsRequest create() => ListSupportedClientsRequest._();
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
    final $result = create();
    if (clients != null) {
      $result.clients.addAll(clients);
    }
    return $result;
  }
  ListSupportedClientsResponse._() : super();
  factory ListSupportedClientsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSupportedClientsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListSupportedClientsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'clients')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListSupportedClientsResponse clone() => ListSupportedClientsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListSupportedClientsResponse copyWith(void Function(ListSupportedClientsResponse) updates) => super.copyWith((message) => updates(message as ListSupportedClientsResponse)) as ListSupportedClientsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsResponse create() => ListSupportedClientsResponse._();
  ListSupportedClientsResponse createEmptyInstance() => create();
  static $pb.PbList<ListSupportedClientsResponse> createRepeated() => $pb.PbList<ListSupportedClientsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSupportedClientsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSupportedClientsResponse>(create);
  static ListSupportedClientsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get clients => $_getList(0);
}

class UpdateSettingsResponse extends $pb.GeneratedMessage {
  factory UpdateSettingsResponse() => create();
  UpdateSettingsResponse._() : super();
  factory UpdateSettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSettingsResponse clone() => UpdateSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSettingsResponse copyWith(void Function(UpdateSettingsResponse) updates) => super.copyWith((message) => updates(message as UpdateSettingsResponse)) as UpdateSettingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSettingsResponse create() => UpdateSettingsResponse._();
  UpdateSettingsResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSettingsResponse> createRepeated() => $pb.PbList<UpdateSettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSettingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSettingsResponse>(create);
  static UpdateSettingsResponse? _defaultInstance;
}

class ListSettingsResponse extends $pb.GeneratedMessage {
  factory ListSettingsResponse() => create();
  ListSettingsResponse._() : super();
  factory ListSettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListSettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListSettingsResponse clone() => ListSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListSettingsResponse copyWith(void Function(ListSettingsResponse) updates) => super.copyWith((message) => updates(message as ListSettingsResponse)) as ListSettingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSettingsResponse create() => ListSettingsResponse._();
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
    $core.String? torrentHost,
    $core.String? torrentName,
    $core.String? torrentPassword,
    $core.String? torrentProtocol,
    $core.String? torrentUser,
    $core.bool? exitOnClose,
  }) {
    final $result = create();
    if (apiKey != null) {
      $result.apiKey = apiKey;
    }
    if (serverPort != null) {
      $result.serverPort = serverPort;
    }
    if (downloadCheckTimeout != null) {
      $result.downloadCheckTimeout = downloadCheckTimeout;
    }
    if (completeFolder != null) {
      $result.completeFolder = completeFolder;
    }
    if (downloadFolder != null) {
      $result.downloadFolder = downloadFolder;
    }
    if (torrentsFolder != null) {
      $result.torrentsFolder = torrentsFolder;
    }
    if (username != null) {
      $result.username = username;
    }
    if (password != null) {
      $result.password = password;
    }
    if (userUid != null) {
      $result.userUid = userUid;
    }
    if (groupUid != null) {
      $result.groupUid = groupUid;
    }
    if (torrentHost != null) {
      $result.torrentHost = torrentHost;
    }
    if (torrentName != null) {
      $result.torrentName = torrentName;
    }
    if (torrentPassword != null) {
      $result.torrentPassword = torrentPassword;
    }
    if (torrentProtocol != null) {
      $result.torrentProtocol = torrentProtocol;
    }
    if (torrentUser != null) {
      $result.torrentUser = torrentUser;
    }
    if (exitOnClose != null) {
      $result.exitOnClose = exitOnClose;
    }
    return $result;
  }
  Settings._() : super();
  factory Settings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Settings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

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
    ..aOS(11, _omitFieldNames ? '' : 'torrentHost')
    ..aOS(12, _omitFieldNames ? '' : 'torrentName')
    ..aOS(13, _omitFieldNames ? '' : 'torrentPassword')
    ..aOS(14, _omitFieldNames ? '' : 'torrentProtocol')
    ..aOS(15, _omitFieldNames ? '' : 'torrentUser')
    ..aOB(16, _omitFieldNames ? '' : 'exitOnClose')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Settings clone() => Settings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Settings copyWith(void Function(Settings) updates) => super.copyWith((message) => updates(message as Settings)) as Settings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Settings create() => Settings._();
  Settings createEmptyInstance() => create();
  static $pb.PbList<Settings> createRepeated() => $pb.PbList<Settings>();
  @$core.pragma('dart2js:noInline')
  static Settings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Settings>(create);
  static Settings? _defaultInstance;

  /// General settings
  @$pb.TagNumber(1)
  $core.String get apiKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set apiKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasApiKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearApiKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get serverPort => $_getSZ(1);
  @$pb.TagNumber(2)
  set serverPort($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasServerPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerPort() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get downloadCheckTimeout => $_getI64(2);
  @$pb.TagNumber(3)
  set downloadCheckTimeout($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDownloadCheckTimeout() => $_has(2);
  @$pb.TagNumber(3)
  void clearDownloadCheckTimeout() => clearField(3);

  /// Folder settings
  @$pb.TagNumber(4)
  $core.String get completeFolder => $_getSZ(3);
  @$pb.TagNumber(4)
  set completeFolder($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCompleteFolder() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompleteFolder() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get downloadFolder => $_getSZ(4);
  @$pb.TagNumber(5)
  set downloadFolder($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDownloadFolder() => $_has(4);
  @$pb.TagNumber(5)
  void clearDownloadFolder() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get torrentsFolder => $_getSZ(5);
  @$pb.TagNumber(6)
  set torrentsFolder($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTorrentsFolder() => $_has(5);
  @$pb.TagNumber(6)
  void clearTorrentsFolder() => clearField(6);

  /// User settings
  @$pb.TagNumber(7)
  $core.String get username => $_getSZ(6);
  @$pb.TagNumber(7)
  set username($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearUsername() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get password => $_getSZ(7);
  @$pb.TagNumber(8)
  set password($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPassword() => $_has(7);
  @$pb.TagNumber(8)
  void clearPassword() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get userUid => $_getI64(8);
  @$pb.TagNumber(9)
  set userUid($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUserUid() => $_has(8);
  @$pb.TagNumber(9)
  void clearUserUid() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get groupUid => $_getI64(9);
  @$pb.TagNumber(10)
  set groupUid($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasGroupUid() => $_has(9);
  @$pb.TagNumber(10)
  void clearGroupUid() => clearField(10);

  /// Torrent settings
  @$pb.TagNumber(11)
  $core.String get torrentHost => $_getSZ(10);
  @$pb.TagNumber(11)
  set torrentHost($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTorrentHost() => $_has(10);
  @$pb.TagNumber(11)
  void clearTorrentHost() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get torrentName => $_getSZ(11);
  @$pb.TagNumber(12)
  set torrentName($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTorrentName() => $_has(11);
  @$pb.TagNumber(12)
  void clearTorrentName() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get torrentPassword => $_getSZ(12);
  @$pb.TagNumber(13)
  set torrentPassword($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasTorrentPassword() => $_has(12);
  @$pb.TagNumber(13)
  void clearTorrentPassword() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get torrentProtocol => $_getSZ(13);
  @$pb.TagNumber(14)
  set torrentProtocol($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasTorrentProtocol() => $_has(13);
  @$pb.TagNumber(14)
  void clearTorrentProtocol() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get torrentUser => $_getSZ(14);
  @$pb.TagNumber(15)
  set torrentUser($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasTorrentUser() => $_has(14);
  @$pb.TagNumber(15)
  void clearTorrentUser() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get exitOnClose => $_getBF(15);
  @$pb.TagNumber(16)
  set exitOnClose($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasExitOnClose() => $_has(15);
  @$pb.TagNumber(16)
  void clearExitOnClose() => clearField(16);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
