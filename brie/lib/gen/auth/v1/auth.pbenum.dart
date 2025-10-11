// This is a generated file - do not edit.
//
// Generated from auth/v1/auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Role extends $pb.ProtobufEnum {
  static const Role Admin = Role._(0, _omitEnumNames ? '' : 'Admin');

  /// normal user
  static const Role Mouse = Role._(1, _omitEnumNames ? '' : 'Mouse');
  static const Role Unknown = Role._(999, _omitEnumNames ? '' : 'Unknown');

  static const $core.List<Role> values = <Role>[
    Admin,
    Mouse,
    Unknown,
  ];

  static final $core.Map<$core.int, Role> _byValue =
  $pb.ProtobufEnum.initByValue(values);
  static Role? valueOf($core.int value) => _byValue[value];

  const Role._(super.value, super.name);
}

const $core.bool _omitEnumNames =
$core.bool.fromEnvironment('protobuf.omit_enum_names');
