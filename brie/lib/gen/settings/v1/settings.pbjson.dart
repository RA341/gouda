// This is a generated file - do not edit.
//
// Generated from settings/v1/settings.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use updateMamTokenRequestDescriptor instead')
const UpdateMamTokenRequest$json = {
  '1': 'UpdateMamTokenRequest',
};

/// Descriptor for `UpdateMamTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMamTokenRequestDescriptor =
    $convert.base64Decode('ChVVcGRhdGVNYW1Ub2tlblJlcXVlc3Q=');

@$core.Deprecated('Use updateMamTokenResponseDescriptor instead')
const UpdateMamTokenResponse$json = {
  '1': 'UpdateMamTokenResponse',
};

/// Descriptor for `UpdateMamTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMamTokenResponseDescriptor =
    $convert.base64Decode('ChZVcGRhdGVNYW1Ub2tlblJlc3BvbnNl');

@$core.Deprecated('Use getMetadataRequestDescriptor instead')
const GetMetadataRequest$json = {
  '1': 'GetMetadataRequest',
};

/// Descriptor for `GetMetadataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMetadataRequestDescriptor =
    $convert.base64Decode('ChJHZXRNZXRhZGF0YVJlcXVlc3Q=');

@$core.Deprecated('Use testTorrentResponseDescriptor instead')
const TestTorrentResponse$json = {
  '1': 'TestTorrentResponse',
};

/// Descriptor for `TestTorrentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testTorrentResponseDescriptor =
    $convert.base64Decode('ChNUZXN0VG9ycmVudFJlc3BvbnNl');

@$core.Deprecated('Use getMetadataResponseDescriptor instead')
const GetMetadataResponse$json = {
  '1': 'GetMetadataResponse',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
    {'1': 'binaryType', '3': 2, '4': 1, '5': 9, '10': 'binaryType'},
  ],
};

/// Descriptor for `GetMetadataResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMetadataResponseDescriptor = $convert.base64Decode(
    'ChNHZXRNZXRhZGF0YVJlc3BvbnNlEhgKB3ZlcnNpb24YASABKAlSB3ZlcnNpb24SHgoKYmluYX'
    'J5VHlwZRgCIAEoCVIKYmluYXJ5VHlwZQ==');

@$core.Deprecated('Use listSupportedClientsRequestDescriptor instead')
const ListSupportedClientsRequest$json = {
  '1': 'ListSupportedClientsRequest',
};

/// Descriptor for `ListSupportedClientsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSupportedClientsRequestDescriptor =
    $convert.base64Decode('ChtMaXN0U3VwcG9ydGVkQ2xpZW50c1JlcXVlc3Q=');

@$core.Deprecated('Use listSupportedClientsResponseDescriptor instead')
const ListSupportedClientsResponse$json = {
  '1': 'ListSupportedClientsResponse',
  '2': [
    {'1': 'clients', '3': 1, '4': 3, '5': 9, '10': 'clients'},
  ],
};

/// Descriptor for `ListSupportedClientsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSupportedClientsResponseDescriptor =
    $convert.base64Decode(
        'ChxMaXN0U3VwcG9ydGVkQ2xpZW50c1Jlc3BvbnNlEhgKB2NsaWVudHMYASADKAlSB2NsaWVudH'
        'M=');

@$core.Deprecated('Use updateSettingsResponseDescriptor instead')
const UpdateSettingsResponse$json = {
  '1': 'UpdateSettingsResponse',
};

/// Descriptor for `UpdateSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSettingsResponseDescriptor =
    $convert.base64Decode('ChZVcGRhdGVTZXR0aW5nc1Jlc3BvbnNl');

@$core.Deprecated('Use listSettingsResponseDescriptor instead')
const ListSettingsResponse$json = {
  '1': 'ListSettingsResponse',
};

/// Descriptor for `ListSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSettingsResponseDescriptor =
    $convert.base64Decode('ChRMaXN0U2V0dGluZ3NSZXNwb25zZQ==');

@$core.Deprecated('Use goudaConfigDescriptor instead')
const GoudaConfig$json = {
  '1': 'GoudaConfig',
  '2': [
    {'1': 'port', '3': 1, '4': 1, '5': 5, '10': 'port'},
    {'1': 'allowed_origins', '3': 2, '4': 1, '5': 9, '10': 'allowedOrigins'},
    {'1': 'ui_path', '3': 3, '4': 1, '5': 9, '10': 'uiPath'},
    {'1': 'auth', '3': 4, '4': 1, '5': 8, '10': 'auth'},
    {'1': 'mam_token', '3': 5, '4': 1, '5': 9, '10': 'mamToken'},
    {
      '1': 'dir',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.Directories',
      '10': 'dir'
    },
    {
      '1': 'log',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.Logger',
      '10': 'log'
    },
    {
      '1': 'downloader',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.Downloader',
      '10': 'downloader'
    },
    {
      '1': 'permissions',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.UserPermissions',
      '10': 'permissions'
    },
  ],
};

/// Descriptor for `GoudaConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List goudaConfigDescriptor = $convert.base64Decode(
    'CgtHb3VkYUNvbmZpZxISCgRwb3J0GAEgASgFUgRwb3J0EicKD2FsbG93ZWRfb3JpZ2lucxgCIA'
    'EoCVIOYWxsb3dlZE9yaWdpbnMSFwoHdWlfcGF0aBgDIAEoCVIGdWlQYXRoEhIKBGF1dGgYBCAB'
    'KAhSBGF1dGgSGwoJbWFtX3Rva2VuGAUgASgJUghtYW1Ub2tlbhIqCgNkaXIYBiABKAsyGC5zZX'
    'R0aW5ncy52MS5EaXJlY3Rvcmllc1IDZGlyEiUKA2xvZxgHIAEoCzITLnNldHRpbmdzLnYxLkxv'
    'Z2dlclIDbG9nEjcKCmRvd25sb2FkZXIYCCABKAsyFy5zZXR0aW5ncy52MS5Eb3dubG9hZGVyUg'
    'pkb3dubG9hZGVyEj4KC3Blcm1pc3Npb25zGAkgASgLMhwuc2V0dGluZ3MudjEuVXNlclBlcm1p'
    'c3Npb25zUgtwZXJtaXNzaW9ucw==');

@$core.Deprecated('Use directoriesDescriptor instead')
const Directories$json = {
  '1': 'Directories',
  '2': [
    {'1': 'config_dir', '3': 1, '4': 1, '5': 9, '10': 'configDir'},
    {'1': 'download_dir', '3': 2, '4': 1, '5': 9, '10': 'downloadDir'},
    {'1': 'complete_dir', '3': 3, '4': 1, '5': 9, '10': 'completeDir'},
    {'1': 'torrent_dir', '3': 4, '4': 1, '5': 9, '10': 'torrentDir'},
  ],
};

/// Descriptor for `Directories`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directoriesDescriptor = $convert.base64Decode(
    'CgtEaXJlY3RvcmllcxIdCgpjb25maWdfZGlyGAEgASgJUgljb25maWdEaXISIQoMZG93bmxvYW'
    'RfZGlyGAIgASgJUgtkb3dubG9hZERpchIhCgxjb21wbGV0ZV9kaXIYAyABKAlSC2NvbXBsZXRl'
    'RGlyEh8KC3RvcnJlbnRfZGlyGAQgASgJUgp0b3JyZW50RGly');

@$core.Deprecated('Use loggerDescriptor instead')
const Logger$json = {
  '1': 'Logger',
  '2': [
    {'1': 'level', '3': 1, '4': 1, '5': 9, '10': 'level'},
    {'1': 'verbose', '3': 2, '4': 1, '5': 8, '10': 'verbose'},
  ],
};

/// Descriptor for `Logger`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loggerDescriptor = $convert.base64Decode(
    'CgZMb2dnZXISFAoFbGV2ZWwYASABKAlSBWxldmVsEhgKB3ZlcmJvc2UYAiABKAhSB3ZlcmJvc2'
    'U=');

@$core.Deprecated('Use downloaderDescriptor instead')
const Downloader$json = {
  '1': 'Downloader',
  '2': [
    {'1': 'timeout', '3': 1, '4': 1, '5': 9, '10': 'timeout'},
    {'1': 'ignore_timeout', '3': 2, '4': 1, '5': 8, '10': 'ignoreTimeout'},
  ],
};

/// Descriptor for `Downloader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloaderDescriptor = $convert.base64Decode(
    'CgpEb3dubG9hZGVyEhgKB3RpbWVvdXQYASABKAlSB3RpbWVvdXQSJQoOaWdub3JlX3RpbWVvdX'
    'QYAiABKAhSDWlnbm9yZVRpbWVvdXQ=');

@$core.Deprecated('Use userPermissionsDescriptor instead')
const UserPermissions$json = {
  '1': 'UserPermissions',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 5, '10': 'uid'},
    {'1': 'gid', '3': 2, '4': 1, '5': 5, '10': 'gid'},
  ],
};

/// Descriptor for `UserPermissions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPermissionsDescriptor = $convert.base64Decode(
    'Cg9Vc2VyUGVybWlzc2lvbnMSEAoDdWlkGAEgASgFUgN1aWQSEAoDZ2lkGAIgASgFUgNnaWQ=');

@$core.Deprecated('Use settingsDescriptor instead')
const Settings$json = {
  '1': 'Settings',
  '2': [
    {'1': 'api_key', '3': 1, '4': 1, '5': 9, '10': 'apiKey'},
    {'1': 'server_port', '3': 2, '4': 1, '5': 9, '10': 'serverPort'},
    {
      '1': 'download_check_timeout',
      '3': 3,
      '4': 1,
      '5': 4,
      '10': 'downloadCheckTimeout'
    },
    {'1': 'complete_folder', '3': 4, '4': 1, '5': 9, '10': 'completeFolder'},
    {'1': 'download_folder', '3': 5, '4': 1, '5': 9, '10': 'downloadFolder'},
    {'1': 'torrents_folder', '3': 6, '4': 1, '5': 9, '10': 'torrentsFolder'},
    {'1': 'username', '3': 7, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 8, '4': 1, '5': 9, '10': 'password'},
    {'1': 'user_uid', '3': 9, '4': 1, '5': 4, '10': 'userUid'},
    {'1': 'group_uid', '3': 10, '4': 1, '5': 4, '10': 'groupUid'},
    {
      '1': 'client',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.TorrentClient',
      '10': 'client'
    },
    {'1': 'exit_on_close', '3': 12, '4': 1, '5': 8, '10': 'exitOnClose'},
    {'1': 'ignore_timeout', '3': 13, '4': 1, '5': 8, '10': 'ignoreTimeout'},
    {'1': 'setup_complete', '3': 14, '4': 1, '5': 8, '10': 'setupComplete'},
  ],
};

/// Descriptor for `Settings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsDescriptor = $convert.base64Decode(
    'CghTZXR0aW5ncxIXCgdhcGlfa2V5GAEgASgJUgZhcGlLZXkSHwoLc2VydmVyX3BvcnQYAiABKA'
    'lSCnNlcnZlclBvcnQSNAoWZG93bmxvYWRfY2hlY2tfdGltZW91dBgDIAEoBFIUZG93bmxvYWRD'
    'aGVja1RpbWVvdXQSJwoPY29tcGxldGVfZm9sZGVyGAQgASgJUg5jb21wbGV0ZUZvbGRlchInCg'
    '9kb3dubG9hZF9mb2xkZXIYBSABKAlSDmRvd25sb2FkRm9sZGVyEicKD3RvcnJlbnRzX2ZvbGRl'
    'chgGIAEoCVIOdG9ycmVudHNGb2xkZXISGgoIdXNlcm5hbWUYByABKAlSCHVzZXJuYW1lEhoKCH'
    'Bhc3N3b3JkGAggASgJUghwYXNzd29yZBIZCgh1c2VyX3VpZBgJIAEoBFIHdXNlclVpZBIbCgln'
    'cm91cF91aWQYCiABKARSCGdyb3VwVWlkEjIKBmNsaWVudBgLIAEoCzIaLnNldHRpbmdzLnYxLl'
    'RvcnJlbnRDbGllbnRSBmNsaWVudBIiCg1leGl0X29uX2Nsb3NlGAwgASgIUgtleGl0T25DbG9z'
    'ZRIlCg5pZ25vcmVfdGltZW91dBgNIAEoCFINaWdub3JlVGltZW91dBIlCg5zZXR1cF9jb21wbG'
    'V0ZRgOIAEoCFINc2V0dXBDb21wbGV0ZQ==');

@$core.Deprecated('Use torrentClientDescriptor instead')
const TorrentClient$json = {
  '1': 'TorrentClient',
  '2': [
    {'1': 'torrent_host', '3': 1, '4': 1, '5': 9, '10': 'torrentHost'},
    {'1': 'torrent_name', '3': 2, '4': 1, '5': 9, '10': 'torrentName'},
    {'1': 'torrent_password', '3': 3, '4': 1, '5': 9, '10': 'torrentPassword'},
    {'1': 'torrent_protocol', '3': 4, '4': 1, '5': 9, '10': 'torrentProtocol'},
    {'1': 'torrent_user', '3': 5, '4': 1, '5': 9, '10': 'torrentUser'},
  ],
};

/// Descriptor for `TorrentClient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List torrentClientDescriptor = $convert.base64Decode(
    'Cg1Ub3JyZW50Q2xpZW50EiEKDHRvcnJlbnRfaG9zdBgBIAEoCVILdG9ycmVudEhvc3QSIQoMdG'
    '9ycmVudF9uYW1lGAIgASgJUgt0b3JyZW50TmFtZRIpChB0b3JyZW50X3Bhc3N3b3JkGAMgASgJ'
    'Ug90b3JyZW50UGFzc3dvcmQSKQoQdG9ycmVudF9wcm90b2NvbBgEIAEoCVIPdG9ycmVudFByb3'
    'RvY29sEiEKDHRvcnJlbnRfdXNlchgFIAEoCVILdG9ycmVudFVzZXI=');
