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

import 'package:protobuf/protobuf.dart' as $pb;

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
    $core.int? downloadCheckTimeout,
    $core.String? completeFolder,
    $core.String? downloadFolder,
    $core.String? torrentsFolder,
    $core.String? username,
    $core.String? password,
    $core.int? userUid,
    $core.int? groupUid,
    $core.String? torrentHost,
    $core.String? torrentName,
    $core.String? torrentPassword,
    $core.String? torrentProtocol,
    $core.String? torrentUser,
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
    return $result;
  }
  Settings._() : super();
  factory Settings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Settings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Settings', package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'apiKey')
    ..aOS(2, _omitFieldNames ? '' : 'serverPort')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'downloadCheckTimeout', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'completeFolder')
    ..aOS(5, _omitFieldNames ? '' : 'downloadFolder')
    ..aOS(6, _omitFieldNames ? '' : 'torrentsFolder')
    ..aOS(7, _omitFieldNames ? '' : 'username')
    ..aOS(8, _omitFieldNames ? '' : 'password')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'userUid', $pb.PbFieldType.O3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'groupUid', $pb.PbFieldType.O3)
    ..aOS(11, _omitFieldNames ? '' : 'torrentHost')
    ..aOS(12, _omitFieldNames ? '' : 'torrentName')
    ..aOS(13, _omitFieldNames ? '' : 'torrentPassword')
    ..aOS(14, _omitFieldNames ? '' : 'torrentProtocol')
    ..aOS(15, _omitFieldNames ? '' : 'torrentUser')
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
  $core.int get downloadCheckTimeout => $_getIZ(2);
  @$pb.TagNumber(3)
  set downloadCheckTimeout($core.int v) { $_setSignedInt32(2, v); }
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
  $core.int get userUid => $_getIZ(8);
  @$pb.TagNumber(9)
  set userUid($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUserUid() => $_has(8);
  @$pb.TagNumber(9)
  void clearUserUid() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get groupUid => $_getIZ(9);
  @$pb.TagNumber(10)
  set groupUid($core.int v) { $_setSignedInt32(9, v); }
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
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
