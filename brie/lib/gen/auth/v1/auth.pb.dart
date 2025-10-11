// This is a generated file - do not edit.
//
// Generated from auth/v1/auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'auth.pbenum.dart';

class UserProfileRequest extends $pb.GeneratedMessage {
  factory UserProfileRequest() => create();

  UserProfileRequest._();

  factory UserProfileRequest.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);

  factory UserProfileRequest.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfileRequest clone() =>
      UserProfileRequest()
        ..mergeFromMessage(this);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfileRequest copyWith(void Function(UserProfileRequest) updates) =>
      super.copyWith((message) => updates(message as UserProfileRequest))
      as UserProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserProfileRequest create() => UserProfileRequest._();

  @$core.override
  UserProfileRequest createEmptyInstance() => create();

  static $pb.PbList<UserProfileRequest> createRepeated() =>
      $pb.PbList<UserProfileRequest>();

  @$core.pragma('dart2js:noInline')
  static UserProfileRequest getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<UserProfileRequest>(create);
  static UserProfileRequest? _defaultInstance;
}

class UserProfileResponse extends $pb.GeneratedMessage {
  factory UserProfileResponse({
    User? user,
  }) {
    final result = create();
    if (user != null) result.user = user;
    return result;
  }

  UserProfileResponse._();

  factory UserProfileResponse.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);

  factory UserProfileResponse.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserProfileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfileResponse clone() =>
      UserProfileResponse()
        ..mergeFromMessage(this);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfileResponse copyWith(void Function(UserProfileResponse) updates) =>
      super.copyWith((message) => updates(message as UserProfileResponse))
      as UserProfileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserProfileResponse create() => UserProfileResponse._();

  @$core.override
  UserProfileResponse createEmptyInstance() => create();

  static $pb.PbList<UserProfileResponse> createRepeated() =>
      $pb.PbList<UserProfileResponse>();

  @$core.pragma('dart2js:noInline')
  static UserProfileResponse getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<UserProfileResponse>(create);
  static UserProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);

  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);

  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);

  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);

  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class UserDeleteRequest extends $pb.GeneratedMessage {
  factory UserDeleteRequest({
    User? user,
  }) {
    final result = create();
    if (user != null) result.user = user;
    return result;
  }

  UserDeleteRequest._();

  factory UserDeleteRequest.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory UserDeleteRequest.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserDeleteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDeleteRequest clone() =>
      UserDeleteRequest()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDeleteRequest copyWith(void Function(UserDeleteRequest) updates) =>
      super.copyWith((message) => updates(message as UserDeleteRequest))
      as UserDeleteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserDeleteRequest create() => UserDeleteRequest._();
  @$core.override
  UserDeleteRequest createEmptyInstance() => create();
  static $pb.PbList<UserDeleteRequest> createRepeated() =>
      $pb.PbList<UserDeleteRequest>();
  @$core.pragma('dart2js:noInline')
  static UserDeleteRequest getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<UserDeleteRequest>(create);
  static UserDeleteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class UserDeleteResponse extends $pb.GeneratedMessage {
  factory UserDeleteResponse() => create();

  UserDeleteResponse._();

  factory UserDeleteResponse.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory UserDeleteResponse.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserDeleteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDeleteResponse clone() =>
      UserDeleteResponse()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserDeleteResponse copyWith(void Function(UserDeleteResponse) updates) =>
      super.copyWith((message) => updates(message as UserDeleteResponse))
      as UserDeleteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserDeleteResponse create() => UserDeleteResponse._();
  @$core.override
  UserDeleteResponse createEmptyInstance() => create();
  static $pb.PbList<UserDeleteResponse> createRepeated() =>
      $pb.PbList<UserDeleteResponse>();
  @$core.pragma('dart2js:noInline')
  static UserDeleteResponse getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<UserDeleteResponse>(create);
  static UserDeleteResponse? _defaultInstance;
}

class UserEditRequest extends $pb.GeneratedMessage {
  factory UserEditRequest({
    User? editUser,
  }) {
    final result = create();
    if (editUser != null) result.editUser = editUser;
    return result;
  }

  UserEditRequest._();

  factory UserEditRequest.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory UserEditRequest.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserEditRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'editUser',
        protoName: 'editUser', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserEditRequest clone() =>
      UserEditRequest()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserEditRequest copyWith(void Function(UserEditRequest) updates) =>
      super.copyWith((message) => updates(message as UserEditRequest))
      as UserEditRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserEditRequest create() => UserEditRequest._();
  @$core.override
  UserEditRequest createEmptyInstance() => create();
  static $pb.PbList<UserEditRequest> createRepeated() =>
      $pb.PbList<UserEditRequest>();
  @$core.pragma('dart2js:noInline')
  static UserEditRequest getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<UserEditRequest>(create);
  static UserEditRequest? _defaultInstance;

  @$pb.TagNumber(1)
  User get editUser => $_getN(0);
  @$pb.TagNumber(1)
  set editUser(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasEditUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearEditUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureEditUser() => $_ensure(0);
}

class UserEditResponse extends $pb.GeneratedMessage {
  factory UserEditResponse() => create();

  UserEditResponse._();

  factory UserEditResponse.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory UserEditResponse.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserEditResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserEditResponse clone() =>
      UserEditResponse()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserEditResponse copyWith(void Function(UserEditResponse) updates) =>
      super.copyWith((message) => updates(message as UserEditResponse))
      as UserEditResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserEditResponse create() => UserEditResponse._();
  @$core.override
  UserEditResponse createEmptyInstance() => create();
  static $pb.PbList<UserEditResponse> createRepeated() =>
      $pb.PbList<UserEditResponse>();
  @$core.pragma('dart2js:noInline')
  static UserEditResponse getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<UserEditResponse>(create);
  static UserEditResponse? _defaultInstance;
}

class AddUserRequest extends $pb.GeneratedMessage {
  factory AddUserRequest({
    User? user,
  }) {
    final result = create();
    if (user != null) result.user = user;
    return result;
  }

  AddUserRequest._();

  factory AddUserRequest.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory AddUserRequest.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddUserRequest clone() =>
      AddUserRequest()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddUserRequest copyWith(void Function(AddUserRequest) updates) =>
      super.copyWith((message) => updates(message as AddUserRequest))
      as AddUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddUserRequest create() => AddUserRequest._();
  @$core.override
  AddUserRequest createEmptyInstance() => create();
  static $pb.PbList<AddUserRequest> createRepeated() =>
      $pb.PbList<AddUserRequest>();
  @$core.pragma('dart2js:noInline')
  static AddUserRequest getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<AddUserRequest>(create);
  static AddUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class AddUserResponse extends $pb.GeneratedMessage {
  factory AddUserResponse() => create();

  AddUserResponse._();

  factory AddUserResponse.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory AddUserResponse.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddUserResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddUserResponse clone() =>
      AddUserResponse()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddUserResponse copyWith(void Function(AddUserResponse) updates) =>
      super.copyWith((message) => updates(message as AddUserResponse))
      as AddUserResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddUserResponse create() => AddUserResponse._();
  @$core.override
  AddUserResponse createEmptyInstance() => create();
  static $pb.PbList<AddUserResponse> createRepeated() =>
      $pb.PbList<AddUserResponse>();
  @$core.pragma('dart2js:noInline')
  static AddUserResponse getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<AddUserResponse>(create);
  static AddUserResponse? _defaultInstance;
}

class ListUsersRequest extends $pb.GeneratedMessage {
  factory ListUsersRequest() => create();

  ListUsersRequest._();

  factory ListUsersRequest.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory ListUsersRequest.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUsersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersRequest clone() =>
      ListUsersRequest()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersRequest copyWith(void Function(ListUsersRequest) updates) =>
      super.copyWith((message) => updates(message as ListUsersRequest))
      as ListUsersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUsersRequest create() => ListUsersRequest._();
  @$core.override
  ListUsersRequest createEmptyInstance() => create();
  static $pb.PbList<ListUsersRequest> createRepeated() =>
      $pb.PbList<ListUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUsersRequest getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<ListUsersRequest>(create);
  static ListUsersRequest? _defaultInstance;
}

class ListUsersResponse extends $pb.GeneratedMessage {
  factory ListUsersResponse({
    $core.Iterable<User>? users,
  }) {
    final result = create();
    if (users != null) result.users.addAll(users);
    return result;
  }

  ListUsersResponse._();

  factory ListUsersResponse.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory ListUsersResponse.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUsersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..pc<User>(1, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM,
        subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersResponse clone() =>
      ListUsersResponse()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersResponse copyWith(void Function(ListUsersResponse) updates) =>
      super.copyWith((message) => updates(message as ListUsersResponse))
      as ListUsersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUsersResponse create() => ListUsersResponse._();
  @$core.override
  ListUsersResponse createEmptyInstance() => create();
  static $pb.PbList<ListUsersResponse> createRepeated() =>
      $pb.PbList<ListUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUsersResponse getDefault() =>
      _defaultInstance ??=
          $pb.GeneratedMessage.$_defaultFor<ListUsersResponse>(create);
  static ListUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get users => $_getList(0);
}

class User extends $pb.GeneratedMessage {
  factory User({
    $core.String? username,
    $core.String? password,
    Role? role,
  }) {
    final result = create();
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    if (role != null) result.role = role;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json,
      [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()
        ..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')..aOS(
        2, _omitFieldNames ? '' : 'password')
    ..e<Role>(3, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE,
        defaultOrMaker: Role.Admin,
        valueOf: Role.valueOf,
        enumValues: Role.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() =>
      User()
        ..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  Role get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(Role value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);
}

class LogoutRequest extends $pb.GeneratedMessage {
  factory LogoutRequest({
    $core.String? refresh,
  }) {
    final result = create();
    if (refresh != null) result.refresh = refresh;
    return result;
  }

  LogoutRequest._();

  factory LogoutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'refresh')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest clone() => LogoutRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest copyWith(void Function(LogoutRequest) updates) =>
      super.copyWith((message) => updates(message as LogoutRequest))
          as LogoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutRequest create() => LogoutRequest._();
  @$core.override
  LogoutRequest createEmptyInstance() => create();
  static $pb.PbList<LogoutRequest> createRepeated() =>
      $pb.PbList<LogoutRequest>();
  @$core.pragma('dart2js:noInline')
  static LogoutRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutRequest>(create);
  static LogoutRequest? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get refresh => $_getSZ(0);
  @$pb.TagNumber(2)
  set refresh($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasRefresh() => $_has(0);
  @$pb.TagNumber(2)
  void clearRefresh() => $_clearField(2);
}

class LogoutResponse extends $pb.GeneratedMessage {
  factory LogoutResponse() => create();

  LogoutResponse._();

  factory LogoutResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutResponse clone() => LogoutResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutResponse copyWith(void Function(LogoutResponse) updates) =>
      super.copyWith((message) => updates(message as LogoutResponse))
          as LogoutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutResponse create() => LogoutResponse._();
  @$core.override
  LogoutResponse createEmptyInstance() => create();
  static $pb.PbList<LogoutResponse> createRepeated() =>
      $pb.PbList<LogoutResponse>();
  @$core.pragma('dart2js:noInline')
  static LogoutResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutResponse>(create);
  static LogoutResponse? _defaultInstance;
}

class LoginRequest extends $pb.GeneratedMessage {
  factory LoginRequest({
    $core.String? username,
    $core.String? password,
  }) {
    final result = create();
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    return result;
  }

  LoginRequest._();

  factory LoginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest clone() => LoginRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest copyWith(void Function(LoginRequest) updates) =>
      super.copyWith((message) => updates(message as LoginRequest))
          as LoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginRequest create() => LoginRequest._();
  @$core.override
  LoginRequest createEmptyInstance() => create();
  static $pb.PbList<LoginRequest> createRepeated() =>
      $pb.PbList<LoginRequest>();
  @$core.pragma('dart2js:noInline')
  static LoginRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginRequest>(create);
  static LoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class LoginResponse extends $pb.GeneratedMessage {
  factory LoginResponse({
    Session? session,
  }) {
    final result = create();
    if (session != null) result.session = session;
    return result;
  }

  LoginResponse._();

  factory LoginResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOM<Session>(1, _omitFieldNames ? '' : 'session',
        subBuilder: Session.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginResponse clone() => LoginResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginResponse copyWith(void Function(LoginResponse) updates) =>
      super.copyWith((message) => updates(message as LoginResponse))
          as LoginResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginResponse create() => LoginResponse._();
  @$core.override
  LoginResponse createEmptyInstance() => create();
  static $pb.PbList<LoginResponse> createRepeated() =>
      $pb.PbList<LoginResponse>();
  @$core.pragma('dart2js:noInline')
  static LoginResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginResponse>(create);
  static LoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Session get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(Session value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);
  @$pb.TagNumber(1)
  Session ensureSession() => $_ensure(0);
}

class RegisterRequest extends $pb.GeneratedMessage {
  factory RegisterRequest({
    $core.String? username,
    $core.String? password,
    $core.String? passwordVerify,
  }) {
    final result = create();
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    if (passwordVerify != null) result.passwordVerify = passwordVerify;
    return result;
  }

  RegisterRequest._();

  factory RegisterRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..aOS(3, _omitFieldNames ? '' : 'passwordVerify',
        protoName: 'passwordVerify')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterRequest clone() => RegisterRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterRequest copyWith(void Function(RegisterRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterRequest))
          as RegisterRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterRequest create() => RegisterRequest._();
  @$core.override
  RegisterRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterRequest> createRepeated() =>
      $pb.PbList<RegisterRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterRequest>(create);
  static RegisterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get passwordVerify => $_getSZ(2);
  @$pb.TagNumber(3)
  set passwordVerify($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPasswordVerify() => $_has(2);
  @$pb.TagNumber(3)
  void clearPasswordVerify() => $_clearField(3);
}

class RegisterResponse extends $pb.GeneratedMessage {
  factory RegisterResponse() => create();

  RegisterResponse._();

  factory RegisterResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterResponse clone() => RegisterResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterResponse copyWith(void Function(RegisterResponse) updates) =>
      super.copyWith((message) => updates(message as RegisterResponse))
          as RegisterResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterResponse create() => RegisterResponse._();
  @$core.override
  RegisterResponse createEmptyInstance() => create();
  static $pb.PbList<RegisterResponse> createRepeated() =>
      $pb.PbList<RegisterResponse>();
  @$core.pragma('dart2js:noInline')
  static RegisterResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterResponse>(create);
  static RegisterResponse? _defaultInstance;
}

class VerifySessionRequest extends $pb.GeneratedMessage {
  factory VerifySessionRequest({
    $core.String? sessionToken,
  }) {
    final result = create();
    if (sessionToken != null) result.sessionToken = sessionToken;
    return result;
  }

  VerifySessionRequest._();

  factory VerifySessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifySessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifySessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sessionToken', protoName: 'sessionToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifySessionRequest clone() =>
      VerifySessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifySessionRequest copyWith(void Function(VerifySessionRequest) updates) =>
      super.copyWith((message) => updates(message as VerifySessionRequest))
          as VerifySessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifySessionRequest create() => VerifySessionRequest._();
  @$core.override
  VerifySessionRequest createEmptyInstance() => create();
  static $pb.PbList<VerifySessionRequest> createRepeated() =>
      $pb.PbList<VerifySessionRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifySessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifySessionRequest>(create);
  static VerifySessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sessionToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionToken() => $_clearField(1);
}

class VerifySessionResponse extends $pb.GeneratedMessage {
  factory VerifySessionResponse() => create();

  VerifySessionResponse._();

  factory VerifySessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifySessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifySessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifySessionResponse clone() =>
      VerifySessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifySessionResponse copyWith(
          void Function(VerifySessionResponse) updates) =>
      super.copyWith((message) => updates(message as VerifySessionResponse))
          as VerifySessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifySessionResponse create() => VerifySessionResponse._();
  @$core.override
  VerifySessionResponse createEmptyInstance() => create();
  static $pb.PbList<VerifySessionResponse> createRepeated() =>
      $pb.PbList<VerifySessionResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifySessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifySessionResponse>(create);
  static VerifySessionResponse? _defaultInstance;
}

class RefreshSessionRequest extends $pb.GeneratedMessage {
  factory RefreshSessionRequest({
    $core.String? refreshToken,
  }) {
    final result = create();
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  RefreshSessionRequest._();

  factory RefreshSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refreshToken', protoName: 'refreshToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshSessionRequest clone() =>
      RefreshSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshSessionRequest copyWith(
          void Function(RefreshSessionRequest) updates) =>
      super.copyWith((message) => updates(message as RefreshSessionRequest))
          as RefreshSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshSessionRequest create() => RefreshSessionRequest._();
  @$core.override
  RefreshSessionRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshSessionRequest> createRepeated() =>
      $pb.PbList<RefreshSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshSessionRequest>(create);
  static RefreshSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => $_clearField(1);
}

class RefreshSessionResponse extends $pb.GeneratedMessage {
  factory RefreshSessionResponse({
    Session? session,
  }) {
    final result = create();
    if (session != null) result.session = session;
    return result;
  }

  RefreshSessionResponse._();

  factory RefreshSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOM<Session>(1, _omitFieldNames ? '' : 'session',
        subBuilder: Session.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshSessionResponse clone() =>
      RefreshSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshSessionResponse copyWith(
          void Function(RefreshSessionResponse) updates) =>
      super.copyWith((message) => updates(message as RefreshSessionResponse))
          as RefreshSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshSessionResponse create() => RefreshSessionResponse._();
  @$core.override
  RefreshSessionResponse createEmptyInstance() => create();
  static $pb.PbList<RefreshSessionResponse> createRepeated() =>
      $pb.PbList<RefreshSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static RefreshSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshSessionResponse>(create);
  static RefreshSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Session get session => $_getN(0);
  @$pb.TagNumber(1)
  set session(Session value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSession() => $_has(0);
  @$pb.TagNumber(1)
  void clearSession() => $_clearField(1);
  @$pb.TagNumber(1)
  Session ensureSession() => $_ensure(0);
}

class Session extends $pb.GeneratedMessage {
  factory Session({
    $core.String? refreshToken,
    $core.String? sessionToken,
  }) {
    final result = create();
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (sessionToken != null) result.sessionToken = sessionToken;
    return result;
  }

  Session._();

  factory Session.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Session.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Session',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refreshToken', protoName: 'refreshToken')
    ..aOS(2, _omitFieldNames ? '' : 'sessionToken', protoName: 'sessionToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Session clone() => Session()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Session copyWith(void Function(Session) updates) =>
      super.copyWith((message) => updates(message as Session)) as Session;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Session create() => Session._();
  @$core.override
  Session createEmptyInstance() => create();
  static $pb.PbList<Session> createRepeated() => $pb.PbList<Session>();
  @$core.pragma('dart2js:noInline')
  static Session getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Session>(create);
  static Session? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionToken() => $_clearField(2);
}

class AuthServiceApi {
  final $pb.RpcClient _client;

  AuthServiceApi(this._client);

  $async.Future<LoginResponse> login($pb.ClientContext? ctx,
      LoginRequest request) =>
      _client.invoke<LoginResponse>(
          ctx, 'AuthService', 'Login', request, LoginResponse());

  $async.Future<LogoutResponse> logout($pb.ClientContext? ctx,
      LogoutRequest request) =>
      _client.invoke<LogoutResponse>(
          ctx, 'AuthService', 'Logout', request, LogoutResponse());

  $async.Future<ListUsersResponse> userList($pb.ClientContext? ctx,
      ListUsersRequest request) =>
      _client.invoke<ListUsersResponse>(
          ctx, 'AuthService', 'UserList', request, ListUsersResponse());

  $async.Future<AddUserResponse> userAdd($pb.ClientContext? ctx,
      AddUserRequest request) =>
      _client.invoke<AddUserResponse>(
          ctx, 'AuthService', 'UserAdd', request, AddUserResponse());

  $async.Future<UserDeleteResponse> userDelete($pb.ClientContext? ctx,
      UserDeleteRequest request) =>
      _client.invoke<UserDeleteResponse>(
          ctx, 'AuthService', 'UserDelete', request, UserDeleteResponse());

  $async.Future<UserEditResponse> userEdit($pb.ClientContext? ctx,
      UserEditRequest request) =>
      _client.invoke<UserEditResponse>(
          ctx, 'AuthService', 'UserEdit', request, UserEditResponse());

  $async.Future<UserProfileResponse> userProfile($pb.ClientContext? ctx,
      UserProfileRequest request) =>
      _client.invoke<UserProfileResponse>(
          ctx, 'AuthService', 'UserProfile', request, UserProfileResponse());

  $async.Future<VerifySessionResponse> verifySession($pb.ClientContext? ctx,
      VerifySessionRequest request) =>
      _client.invoke<VerifySessionResponse>(ctx, 'AuthService', 'VerifySession',
          request, VerifySessionResponse());

  $async.Future<RefreshSessionResponse> refreshSession($pb.ClientContext? ctx,
      RefreshSessionRequest request) =>
      _client.invoke<RefreshSessionResponse>(ctx, 'AuthService',
          'RefreshSession', request, RefreshSessionResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
