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

@$core.Deprecated('Use updateMamAdminConfigRequestDescriptor instead')
const UpdateMamAdminConfigRequest$json = {
  '1': 'UpdateMamAdminConfigRequest',
};

/// Descriptor for `UpdateMamAdminConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMamAdminConfigRequestDescriptor =
$convert.base64Decode('ChtVcGRhdGVNYW1BZG1pbkNvbmZpZ1JlcXVlc3Q=');

@$core.Deprecated('Use updateMamAdminConfigResponseDescriptor instead')
const UpdateMamAdminConfigResponse$json = {
  '1': 'UpdateMamAdminConfigResponse',
};

/// Descriptor for `UpdateMamAdminConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMamAdminConfigResponseDescriptor =
$convert.base64Decode('ChxVcGRhdGVNYW1BZG1pbkNvbmZpZ1Jlc3BvbnNl');

@$core.Deprecated('Use listDirectoriesRequestDescriptor instead')
const ListDirectoriesRequest$json = {
  '1': 'ListDirectoriesRequest',
  '2': [
    {'1': 'filePath', '3': 1, '4': 1, '5': 9, '10': 'filePath'},
  ],
};

/// Descriptor for `ListDirectoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDirectoriesRequestDescriptor =
    $convert.base64Decode(
        'ChZMaXN0RGlyZWN0b3JpZXNSZXF1ZXN0EhoKCGZpbGVQYXRoGAEgASgJUghmaWxlUGF0aA==');

@$core.Deprecated('Use listDirectoriesResponseDescriptor instead')
const ListDirectoriesResponse$json = {
  '1': 'ListDirectoriesResponse',
  '2': [
    {'1': 'folders', '3': 1, '4': 3, '5': 9, '10': 'folders'},
    {'1': 'files', '3': 2, '4': 3, '5': 9, '10': 'files'},
  ],
};

/// Descriptor for `ListDirectoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDirectoriesResponseDescriptor =
    $convert.base64Decode(
        'ChdMaXN0RGlyZWN0b3JpZXNSZXNwb25zZRIYCgdmb2xkZXJzGAEgAygJUgdmb2xkZXJzEhQKBW'
        'ZpbGVzGAIgAygJUgVmaWxlcw==');

@$core.Deprecated('Use updateDirRequestDescriptor instead')
const UpdateDirRequest$json = {
  '1': 'UpdateDirRequest',
  '2': [
    {
      '1': 'dirs',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.Directories',
      '10': 'dirs'
    },
    {
      '1': 'perms',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.UserPermissions',
      '10': 'perms'
    },
  ],
};

/// Descriptor for `UpdateDirRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDirRequestDescriptor = $convert.base64Decode(
    'ChBVcGRhdGVEaXJSZXF1ZXN0EiwKBGRpcnMYASABKAsyGC5zZXR0aW5ncy52MS5EaXJlY3Rvcm'
    'llc1IEZGlycxIyCgVwZXJtcxgCIAEoCzIcLnNldHRpbmdzLnYxLlVzZXJQZXJtaXNzaW9uc1IF'
    'cGVybXM=');

@$core.Deprecated('Use updateDirResponseDescriptor instead')
const UpdateDirResponse$json = {
  '1': 'UpdateDirResponse',
};

/// Descriptor for `UpdateDirResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDirResponseDescriptor =
    $convert.base64Decode('ChFVcGRhdGVEaXJSZXNwb25zZQ==');

@$core.Deprecated('Use updateMamRequestDescriptor instead')
const UpdateMamRequest$json = {
  '1': 'UpdateMamRequest',
  '2': [
    {'1': 'mamToken', '3': 1, '4': 1, '5': 9, '10': 'mamToken'},
  ],
};

/// Descriptor for `UpdateMamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMamRequestDescriptor = $convert.base64Decode(
    'ChBVcGRhdGVNYW1SZXF1ZXN0EhoKCG1hbVRva2VuGAEgASgJUghtYW1Ub2tlbg==');

@$core.Deprecated('Use updateMamResponseDescriptor instead')
const UpdateMamResponse$json = {
  '1': 'UpdateMamResponse',
};

/// Descriptor for `UpdateMamResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMamResponseDescriptor =
    $convert.base64Decode('ChFVcGRhdGVNYW1SZXNwb25zZQ==');

@$core.Deprecated('Use updateDownloaderRequestDescriptor instead')
const UpdateDownloaderRequest$json = {
  '1': 'UpdateDownloaderRequest',
  '2': [
    {
      '1': 'client',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.TorrentClient',
      '10': 'client'
    },
    {
      '1': 'downloader',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.Downloader',
      '10': 'downloader'
    },
  ],
};

/// Descriptor for `UpdateDownloaderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDownloaderRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVEb3dubG9hZGVyUmVxdWVzdBIyCgZjbGllbnQYASABKAsyGi5zZXR0aW5ncy52MS'
    '5Ub3JyZW50Q2xpZW50UgZjbGllbnQSNwoKZG93bmxvYWRlchgCIAEoCzIXLnNldHRpbmdzLnYx'
    'LkRvd25sb2FkZXJSCmRvd25sb2FkZXI=');

@$core.Deprecated('Use updateDownloaderResponseDescriptor instead')
const UpdateDownloaderResponse$json = {
  '1': 'UpdateDownloaderResponse',
};

/// Descriptor for `UpdateDownloaderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDownloaderResponseDescriptor =
    $convert.base64Decode('ChhVcGRhdGVEb3dubG9hZGVyUmVzcG9uc2U=');

@$core.Deprecated('Use updateSettingsRequestDescriptor instead')
const UpdateSettingsRequest$json = {
  '1': 'UpdateSettingsRequest',
  '2': [
    {
      '1': 'settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.GoudaConfig',
      '10': 'settings'
    },
  ],
};

/// Descriptor for `UpdateSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSettingsRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVTZXR0aW5nc1JlcXVlc3QSNAoIc2V0dGluZ3MYASABKAsyGC5zZXR0aW5ncy52MS'
    '5Hb3VkYUNvbmZpZ1IIc2V0dGluZ3M=');

@$core.Deprecated('Use updateSettingsResponseDescriptor instead')
const UpdateSettingsResponse$json = {
  '1': 'UpdateSettingsResponse',
};

/// Descriptor for `UpdateSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSettingsResponseDescriptor =
    $convert.base64Decode('ChZVcGRhdGVTZXR0aW5nc1Jlc3BvbnNl');

@$core.Deprecated('Use loadSettingsRequestDescriptor instead')
const LoadSettingsRequest$json = {
  '1': 'LoadSettingsRequest',
};

/// Descriptor for `LoadSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loadSettingsRequestDescriptor =
    $convert.base64Decode('ChNMb2FkU2V0dGluZ3NSZXF1ZXN0');

@$core.Deprecated('Use loadSettingsResponseDescriptor instead')
const LoadSettingsResponse$json = {
  '1': 'LoadSettingsResponse',
  '2': [
    {
      '1': 'settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.GoudaConfig',
      '10': 'settings'
    },
  ],
};

/// Descriptor for `LoadSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loadSettingsResponseDescriptor = $convert.base64Decode(
    'ChRMb2FkU2V0dGluZ3NSZXNwb25zZRI0CghzZXR0aW5ncxgBIAEoCzIYLnNldHRpbmdzLnYxLk'
    'dvdWRhQ29uZmlnUghzZXR0aW5ncw==');

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
    {
      '1': 'torrentClient',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.TorrentClient',
      '10': 'torrentClient'
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
    'c3Npb25zUgtwZXJtaXNzaW9ucxJACg10b3JyZW50Q2xpZW50GAogASgLMhouc2V0dGluZ3Mudj'
    'EuVG9ycmVudENsaWVudFINdG9ycmVudENsaWVudA==');

@$core.Deprecated('Use directoriesDescriptor instead')
const Directories$json = {
  '1': 'Directories',
  '2': [
    {'1': 'downloadDir', '3': 2, '4': 1, '5': 9, '10': 'downloadDir'},
    {'1': 'completeDir', '3': 3, '4': 1, '5': 9, '10': 'completeDir'},
    {'1': 'torrentDir', '3': 4, '4': 1, '5': 9, '10': 'torrentDir'},
  ],
};

/// Descriptor for `Directories`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directoriesDescriptor = $convert.base64Decode(
    'CgtEaXJlY3RvcmllcxIgCgtkb3dubG9hZERpchgCIAEoCVILZG93bmxvYWREaXISIAoLY29tcG'
    'xldGVEaXIYAyABKAlSC2NvbXBsZXRlRGlyEh4KCnRvcnJlbnREaXIYBCABKAlSCnRvcnJlbnRE'
    'aXI=');

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

@$core.Deprecated('Use torrentClientDescriptor instead')
const TorrentClient$json = {
  '1': 'TorrentClient',
  '2': [
    {'1': 'clientType', '3': 2, '4': 1, '5': 9, '10': 'clientType'},
    {'1': 'host', '3': 1, '4': 1, '5': 9, '10': 'host'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    {'1': 'protocol', '3': 4, '4': 1, '5': 9, '10': 'protocol'},
    {'1': 'user', '3': 5, '4': 1, '5': 9, '10': 'user'},
  ],
};

/// Descriptor for `TorrentClient`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List torrentClientDescriptor = $convert.base64Decode(
    'Cg1Ub3JyZW50Q2xpZW50Eh4KCmNsaWVudFR5cGUYAiABKAlSCmNsaWVudFR5cGUSEgoEaG9zdB'
    'gBIAEoCVIEaG9zdBIaCghwYXNzd29yZBgDIAEoCVIIcGFzc3dvcmQSGgoIcHJvdG9jb2wYBCAB'
    'KAlSCHByb3RvY29sEhIKBHVzZXIYBSABKAlSBHVzZXI=');

const $core.Map<$core.String, $core.dynamic> SettingsServiceBase$json = {
  '1': 'SettingsService',
  '2': [
    {
      '1': 'LoadSettings',
      '2': '.settings.v1.LoadSettingsRequest',
      '3': '.settings.v1.LoadSettingsResponse',
      '4': {}
    },
    {
      '1': 'UpdateSettings',
      '2': '.settings.v1.UpdateSettingsRequest',
      '3': '.settings.v1.UpdateSettingsResponse',
      '4': {}
    },
    {
      '1': 'UpdateMam',
      '2': '.settings.v1.UpdateMamRequest',
      '3': '.settings.v1.UpdateMamResponse',
      '4': {}
    },
    {
      '1': 'UpdateDownloader',
      '2': '.settings.v1.UpdateDownloaderRequest',
      '3': '.settings.v1.UpdateDownloaderResponse',
      '4': {}
    },
    {
      '1': 'UpdateDir',
      '2': '.settings.v1.UpdateDirRequest',
      '3': '.settings.v1.UpdateDirResponse',
      '4': {}
    },
    {
      '1': 'ListDirectories',
      '2': '.settings.v1.ListDirectoriesRequest',
      '3': '.settings.v1.ListDirectoriesResponse',
      '4': {}
    },
    {
      '1': 'ListSupportedClients',
      '2': '.settings.v1.ListSupportedClientsRequest',
      '3': '.settings.v1.ListSupportedClientsResponse',
      '4': {}
    },
    {
      '1': 'TestClient',
      '2': '.settings.v1.TorrentClient',
      '3': '.settings.v1.TestTorrentResponse',
      '4': {}
    },
    {
      '1': 'GetMetadata',
      '2': '.settings.v1.GetMetadataRequest',
      '3': '.settings.v1.GetMetadataResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use settingsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
SettingsServiceBase$messageJson = {
  '.settings.v1.LoadSettingsRequest': LoadSettingsRequest$json,
  '.settings.v1.LoadSettingsResponse': LoadSettingsResponse$json,
  '.settings.v1.GoudaConfig': GoudaConfig$json,
  '.settings.v1.Directories': Directories$json,
  '.settings.v1.Logger': Logger$json,
  '.settings.v1.Downloader': Downloader$json,
  '.settings.v1.UserPermissions': UserPermissions$json,
  '.settings.v1.TorrentClient': TorrentClient$json,
  '.settings.v1.UpdateSettingsRequest': UpdateSettingsRequest$json,
  '.settings.v1.UpdateSettingsResponse': UpdateSettingsResponse$json,
  '.settings.v1.UpdateMamRequest': UpdateMamRequest$json,
  '.settings.v1.UpdateMamResponse': UpdateMamResponse$json,
  '.settings.v1.UpdateDownloaderRequest': UpdateDownloaderRequest$json,
  '.settings.v1.UpdateDownloaderResponse': UpdateDownloaderResponse$json,
  '.settings.v1.UpdateDirRequest': UpdateDirRequest$json,
  '.settings.v1.UpdateDirResponse': UpdateDirResponse$json,
  '.settings.v1.ListDirectoriesRequest': ListDirectoriesRequest$json,
  '.settings.v1.ListDirectoriesResponse': ListDirectoriesResponse$json,
  '.settings.v1.ListSupportedClientsRequest': ListSupportedClientsRequest$json,
  '.settings.v1.ListSupportedClientsResponse':
  ListSupportedClientsResponse$json,
  '.settings.v1.TestTorrentResponse': TestTorrentResponse$json,
  '.settings.v1.GetMetadataRequest': GetMetadataRequest$json,
  '.settings.v1.GetMetadataResponse': GetMetadataResponse$json,
};

/// Descriptor for `SettingsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List settingsServiceDescriptor = $convert.base64Decode(
    'Cg9TZXR0aW5nc1NlcnZpY2USVQoMTG9hZFNldHRpbmdzEiAuc2V0dGluZ3MudjEuTG9hZFNldH'
        'RpbmdzUmVxdWVzdBohLnNldHRpbmdzLnYxLkxvYWRTZXR0aW5nc1Jlc3BvbnNlIgASWwoOVXBk'
        'YXRlU2V0dGluZ3MSIi5zZXR0aW5ncy52MS5VcGRhdGVTZXR0aW5nc1JlcXVlc3QaIy5zZXR0aW'
        '5ncy52MS5VcGRhdGVTZXR0aW5nc1Jlc3BvbnNlIgASTAoJVXBkYXRlTWFtEh0uc2V0dGluZ3Mu'
        'djEuVXBkYXRlTWFtUmVxdWVzdBoeLnNldHRpbmdzLnYxLlVwZGF0ZU1hbVJlc3BvbnNlIgASYQ'
        'oQVXBkYXRlRG93bmxvYWRlchIkLnNldHRpbmdzLnYxLlVwZGF0ZURvd25sb2FkZXJSZXF1ZXN0'
        'GiUuc2V0dGluZ3MudjEuVXBkYXRlRG93bmxvYWRlclJlc3BvbnNlIgASTAoJVXBkYXRlRGlyEh'
        '0uc2V0dGluZ3MudjEuVXBkYXRlRGlyUmVxdWVzdBoeLnNldHRpbmdzLnYxLlVwZGF0ZURpclJl'
        'c3BvbnNlIgASXgoPTGlzdERpcmVjdG9yaWVzEiMuc2V0dGluZ3MudjEuTGlzdERpcmVjdG9yaW'
        'VzUmVxdWVzdBokLnNldHRpbmdzLnYxLkxpc3REaXJlY3Rvcmllc1Jlc3BvbnNlIgASbQoUTGlz'
        'dFN1cHBvcnRlZENsaWVudHMSKC5zZXR0aW5ncy52MS5MaXN0U3VwcG9ydGVkQ2xpZW50c1JlcX'
        'Vlc3QaKS5zZXR0aW5ncy52MS5MaXN0U3VwcG9ydGVkQ2xpZW50c1Jlc3BvbnNlIgASTAoKVGVz'
        'dENsaWVudBIaLnNldHRpbmdzLnYxLlRvcnJlbnRDbGllbnQaIC5zZXR0aW5ncy52MS5UZXN0VG'
        '9ycmVudFJlc3BvbnNlIgASUgoLR2V0TWV0YWRhdGESHy5zZXR0aW5ncy52MS5HZXRNZXRhZGF0'
        'YVJlcXVlc3QaIC5zZXR0aW5ncy52MS5HZXRNZXRhZGF0YVJlc3BvbnNlIgA=');
