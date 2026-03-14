// This is a generated file - do not edit.
//
// Generated from category/v1/category.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ListCategoriesRequest extends $pb.GeneratedMessage {
  factory ListCategoriesRequest() => create();

  ListCategoriesRequest._();

  factory ListCategoriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCategoriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCategoriesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCategoriesRequest clone() =>
      ListCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCategoriesRequest copyWith(
          void Function(ListCategoriesRequest) updates) =>
      super.copyWith((message) => updates(message as ListCategoriesRequest))
          as ListCategoriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCategoriesRequest create() => ListCategoriesRequest._();
  @$core.override
  ListCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<ListCategoriesRequest> createRepeated() =>
      $pb.PbList<ListCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCategoriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCategoriesRequest>(create);
  static ListCategoriesRequest? _defaultInstance;
}

class ListCategoriesResponse extends $pb.GeneratedMessage {
  factory ListCategoriesResponse({
    $core.Iterable<Category>? categories,
  }) {
    final result = create();
    if (categories != null) result.categories.addAll(categories);
    return result;
  }

  ListCategoriesResponse._();

  factory ListCategoriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCategoriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCategoriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'),
      createEmptyInstance: create)
    ..pc<Category>(1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: Category.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCategoriesResponse clone() =>
      ListCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCategoriesResponse copyWith(
          void Function(ListCategoriesResponse) updates) =>
      super.copyWith((message) => updates(message as ListCategoriesResponse))
          as ListCategoriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCategoriesResponse create() => ListCategoriesResponse._();
  @$core.override
  ListCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<ListCategoriesResponse> createRepeated() =>
      $pb.PbList<ListCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCategoriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCategoriesResponse>(create);
  static ListCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Category> get categories => $_getList(0);
}

class AddCategoriesRequest extends $pb.GeneratedMessage {
  factory AddCategoriesRequest({
    $core.String? category,
  }) {
    final result = create();
    if (category != null) result.category = category;
    return result;
  }

  AddCategoriesRequest._();

  factory AddCategoriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddCategoriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddCategoriesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddCategoriesRequest clone() =>
      AddCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddCategoriesRequest copyWith(void Function(AddCategoriesRequest) updates) =>
      super.copyWith((message) => updates(message as AddCategoriesRequest))
          as AddCategoriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddCategoriesRequest create() => AddCategoriesRequest._();
  @$core.override
  AddCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<AddCategoriesRequest> createRepeated() =>
      $pb.PbList<AddCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static AddCategoriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddCategoriesRequest>(create);
  static AddCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);
}

class AddCategoriesResponse extends $pb.GeneratedMessage {
  factory AddCategoriesResponse() => create();

  AddCategoriesResponse._();

  factory AddCategoriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddCategoriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddCategoriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddCategoriesResponse clone() =>
      AddCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddCategoriesResponse copyWith(
          void Function(AddCategoriesResponse) updates) =>
      super.copyWith((message) => updates(message as AddCategoriesResponse))
          as AddCategoriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddCategoriesResponse create() => AddCategoriesResponse._();
  @$core.override
  AddCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<AddCategoriesResponse> createRepeated() =>
      $pb.PbList<AddCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static AddCategoriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddCategoriesResponse>(create);
  static AddCategoriesResponse? _defaultInstance;
}

class DelCategoriesRequest extends $pb.GeneratedMessage {
  factory DelCategoriesRequest({
    Category? category,
  }) {
    final result = create();
    if (category != null) result.category = category;
    return result;
  }

  DelCategoriesRequest._();

  factory DelCategoriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DelCategoriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DelCategoriesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'),
      createEmptyInstance: create)
    ..aOM<Category>(1, _omitFieldNames ? '' : 'category',
        subBuilder: Category.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DelCategoriesRequest clone() =>
      DelCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DelCategoriesRequest copyWith(void Function(DelCategoriesRequest) updates) =>
      super.copyWith((message) => updates(message as DelCategoriesRequest))
          as DelCategoriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DelCategoriesRequest create() => DelCategoriesRequest._();
  @$core.override
  DelCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<DelCategoriesRequest> createRepeated() =>
      $pb.PbList<DelCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static DelCategoriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DelCategoriesRequest>(create);
  static DelCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Category get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(Category value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);
  @$pb.TagNumber(1)
  Category ensureCategory() => $_ensure(0);
}

class DelCategoriesResponse extends $pb.GeneratedMessage {
  factory DelCategoriesResponse() => create();

  DelCategoriesResponse._();

  factory DelCategoriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DelCategoriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DelCategoriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DelCategoriesResponse clone() =>
      DelCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DelCategoriesResponse copyWith(
          void Function(DelCategoriesResponse) updates) =>
      super.copyWith((message) => updates(message as DelCategoriesResponse))
          as DelCategoriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DelCategoriesResponse create() => DelCategoriesResponse._();
  @$core.override
  DelCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<DelCategoriesResponse> createRepeated() =>
      $pb.PbList<DelCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static DelCategoriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DelCategoriesResponse>(create);
  static DelCategoriesResponse? _defaultInstance;
}

class Category extends $pb.GeneratedMessage {
  factory Category({
    $fixnum.Int64? iD,
    $core.String? category,
  }) {
    final result = create();
    if (iD != null) result.iD = iD;
    if (category != null) result.category = category;
    return result;
  }

  Category._();

  factory Category.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Category.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Category',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'ID', $pb.PbFieldType.OU6,
        protoName: 'ID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Category clone() => Category()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Category copyWith(void Function(Category) updates) =>
      super.copyWith((message) => updates(message as Category)) as Category;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Category create() => Category._();
  @$core.override
  Category createEmptyInstance() => create();
  static $pb.PbList<Category> createRepeated() => $pb.PbList<Category>();
  @$core.pragma('dart2js:noInline')
  static Category getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Category>(create);
  static Category? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);
}

class CategoryServiceApi {
  final $pb.RpcClient _client;

  CategoryServiceApi(this._client);

  $async.Future<ListCategoriesResponse> listCategories(
          $pb.ClientContext? ctx, ListCategoriesRequest request) =>
      _client.invoke<ListCategoriesResponse>(ctx, 'CategoryService',
          'ListCategories', request, ListCategoriesResponse());
  $async.Future<AddCategoriesResponse> addCategories(
          $pb.ClientContext? ctx, AddCategoriesRequest request) =>
      _client.invoke<AddCategoriesResponse>(ctx, 'CategoryService',
          'AddCategories', request, AddCategoriesResponse());
  $async.Future<DelCategoriesResponse> deleteCategories(
          $pb.ClientContext? ctx, DelCategoriesRequest request) =>
      _client.invoke<DelCategoriesResponse>(ctx, 'CategoryService',
          'DeleteCategories', request, DelCategoriesResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
