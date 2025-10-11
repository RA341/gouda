// This is a generated file - do not edit.
//
// Generated from media_requests/v1/media_requests.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DownloadStatus extends $pb.ProtobufEnum {
  static const DownloadStatus Downloading =
  DownloadStatus._(0, _omitEnumNames ? '' : 'Downloading');
  static const DownloadStatus Error =
  DownloadStatus._(1, _omitEnumNames ? '' : 'Error');
  static const DownloadStatus Complete =
  DownloadStatus._(2, _omitEnumNames ? '' : 'Complete');
  static const DownloadStatus Unknown =
  DownloadStatus._(3, _omitEnumNames ? '' : 'Unknown');

  static const $core.List<DownloadStatus> values = <DownloadStatus>[
    Downloading,
    Error,
    Complete,
    Unknown,
  ];

  static final $core.List<DownloadStatus?> _byValue =
  $pb.ProtobufEnum.$_initByValueList(values, 3);
  static DownloadStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DownloadStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
$core.bool.fromEnvironment('protobuf.omit_enum_names');
