//
//  Generated code. Do not modify.
//  source: settings/v1/settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getMetadataRequestDescriptor instead')
const GetMetadataRequest$json = {
  '1': 'GetMetadataRequest',
};

/// Descriptor for `GetMetadataRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMetadataRequestDescriptor = $convert.base64Decode(
    'ChJHZXRNZXRhZGF0YVJlcXVlc3Q=');

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
final $typed_data.Uint8List listSupportedClientsRequestDescriptor = $convert.base64Decode(
    'ChtMaXN0U3VwcG9ydGVkQ2xpZW50c1JlcXVlc3Q=');

@$core.Deprecated('Use listSupportedClientsResponseDescriptor instead')
const ListSupportedClientsResponse$json = {
  '1': 'ListSupportedClientsResponse',
  '2': [
    {'1': 'clients', '3': 1, '4': 3, '5': 9, '10': 'clients'},
  ],
};

/// Descriptor for `ListSupportedClientsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSupportedClientsResponseDescriptor = $convert.base64Decode(
    'ChxMaXN0U3VwcG9ydGVkQ2xpZW50c1Jlc3BvbnNlEhgKB2NsaWVudHMYASADKAlSB2NsaWVudH'
    'M=');

@$core.Deprecated('Use updateSettingsResponseDescriptor instead')
const UpdateSettingsResponse$json = {
  '1': 'UpdateSettingsResponse',
};

/// Descriptor for `UpdateSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSettingsResponseDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVTZXR0aW5nc1Jlc3BvbnNl');

@$core.Deprecated('Use listSettingsResponseDescriptor instead')
const ListSettingsResponse$json = {
  '1': 'ListSettingsResponse',
};

/// Descriptor for `ListSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSettingsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0U2V0dGluZ3NSZXNwb25zZQ==');

@$core.Deprecated('Use settingsDescriptor instead')
const Settings$json = {
  '1': 'Settings',
  '2': [
    {'1': 'api_key', '3': 1, '4': 1, '5': 9, '10': 'apiKey'},
    {'1': 'server_port', '3': 2, '4': 1, '5': 9, '10': 'serverPort'},
    {'1': 'download_check_timeout', '3': 3, '4': 1, '5': 4, '10': 'downloadCheckTimeout'},
    {'1': 'ignore_timeout', '3': 17, '4': 1, '5': 8, '10': 'ignoreTimeout'},
    {'1': 'exit_on_close', '3': 16, '4': 1, '5': 8, '10': 'exitOnClose'},
    {'1': 'complete_folder', '3': 4, '4': 1, '5': 9, '10': 'completeFolder'},
    {'1': 'download_folder', '3': 5, '4': 1, '5': 9, '10': 'downloadFolder'},
    {'1': 'torrents_folder', '3': 6, '4': 1, '5': 9, '10': 'torrentsFolder'},
    {'1': 'username', '3': 7, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 8, '4': 1, '5': 9, '10': 'password'},
    {'1': 'user_uid', '3': 9, '4': 1, '5': 4, '10': 'userUid'},
    {'1': 'group_uid', '3': 10, '4': 1, '5': 4, '10': 'groupUid'},
    {'1': 'torrent_host', '3': 11, '4': 1, '5': 9, '10': 'torrentHost'},
    {'1': 'torrent_name', '3': 12, '4': 1, '5': 9, '10': 'torrentName'},
    {'1': 'torrent_password', '3': 13, '4': 1, '5': 9, '10': 'torrentPassword'},
    {'1': 'torrent_protocol', '3': 14, '4': 1, '5': 9, '10': 'torrentProtocol'},
    {'1': 'torrent_user', '3': 15, '4': 1, '5': 9, '10': 'torrentUser'},
  ],
};

/// Descriptor for `Settings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsDescriptor = $convert.base64Decode(
    'CghTZXR0aW5ncxIXCgdhcGlfa2V5GAEgASgJUgZhcGlLZXkSHwoLc2VydmVyX3BvcnQYAiABKA'
    'lSCnNlcnZlclBvcnQSNAoWZG93bmxvYWRfY2hlY2tfdGltZW91dBgDIAEoBFIUZG93bmxvYWRD'
    'aGVja1RpbWVvdXQSJQoOaWdub3JlX3RpbWVvdXQYESABKAhSDWlnbm9yZVRpbWVvdXQSIgoNZX'
    'hpdF9vbl9jbG9zZRgQIAEoCFILZXhpdE9uQ2xvc2USJwoPY29tcGxldGVfZm9sZGVyGAQgASgJ'
    'Ug5jb21wbGV0ZUZvbGRlchInCg9kb3dubG9hZF9mb2xkZXIYBSABKAlSDmRvd25sb2FkRm9sZG'
    'VyEicKD3RvcnJlbnRzX2ZvbGRlchgGIAEoCVIOdG9ycmVudHNGb2xkZXISGgoIdXNlcm5hbWUY'
    'ByABKAlSCHVzZXJuYW1lEhoKCHBhc3N3b3JkGAggASgJUghwYXNzd29yZBIZCgh1c2VyX3VpZB'
    'gJIAEoBFIHdXNlclVpZBIbCglncm91cF91aWQYCiABKARSCGdyb3VwVWlkEiEKDHRvcnJlbnRf'
    'aG9zdBgLIAEoCVILdG9ycmVudEhvc3QSIQoMdG9ycmVudF9uYW1lGAwgASgJUgt0b3JyZW50Tm'
    'FtZRIpChB0b3JyZW50X3Bhc3N3b3JkGA0gASgJUg90b3JyZW50UGFzc3dvcmQSKQoQdG9ycmVu'
    'dF9wcm90b2NvbBgOIAEoCVIPdG9ycmVudFByb3RvY29sEiEKDHRvcnJlbnRfdXNlchgPIAEoCV'
    'ILdG9ycmVudFVzZXI=');

