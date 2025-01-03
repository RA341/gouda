//
//  Generated code. Do not modify.
//  source: category/v1/category.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ListCategoriesRequest extends $pb.GeneratedMessage {
  factory ListCategoriesRequest() => create();
  ListCategoriesRequest._() : super();
  factory ListCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListCategoriesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCategoriesRequest clone() => ListCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCategoriesRequest copyWith(void Function(ListCategoriesRequest) updates) => super.copyWith((message) => updates(message as ListCategoriesRequest)) as ListCategoriesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCategoriesRequest create() => ListCategoriesRequest._();
  ListCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<ListCategoriesRequest> createRepeated() => $pb.PbList<ListCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCategoriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCategoriesRequest>(create);
  static ListCategoriesRequest? _defaultInstance;
}

class ListCategoriesResponse extends $pb.GeneratedMessage {
  factory ListCategoriesResponse({
    $core.Iterable<Category>? categories,
  }) {
    final $result = create();
    if (categories != null) {
      $result.categories.addAll(categories);
    }
    return $result;
  }
  ListCategoriesResponse._() : super();
  factory ListCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListCategoriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'), createEmptyInstance: create)
    ..pc<Category>(1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: Category.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCategoriesResponse clone() => ListCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCategoriesResponse copyWith(void Function(ListCategoriesResponse) updates) => super.copyWith((message) => updates(message as ListCategoriesResponse)) as ListCategoriesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCategoriesResponse create() => ListCategoriesResponse._();
  ListCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<ListCategoriesResponse> createRepeated() => $pb.PbList<ListCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCategoriesResponse>(create);
  static ListCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Category> get categories => $_getList(0);
}

class AddCategoriesRequest extends $pb.GeneratedMessage {
  factory AddCategoriesRequest({
    $core.String? category,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  AddCategoriesRequest._() : super();
  factory AddCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddCategoriesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddCategoriesRequest clone() => AddCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddCategoriesRequest copyWith(void Function(AddCategoriesRequest) updates) => super.copyWith((message) => updates(message as AddCategoriesRequest)) as AddCategoriesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddCategoriesRequest create() => AddCategoriesRequest._();
  AddCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<AddCategoriesRequest> createRepeated() => $pb.PbList<AddCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static AddCategoriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddCategoriesRequest>(create);
  static AddCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);
}

class AddCategoriesResponse extends $pb.GeneratedMessage {
  factory AddCategoriesResponse() => create();
  AddCategoriesResponse._() : super();
  factory AddCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddCategoriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddCategoriesResponse clone() => AddCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddCategoriesResponse copyWith(void Function(AddCategoriesResponse) updates) => super.copyWith((message) => updates(message as AddCategoriesResponse)) as AddCategoriesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddCategoriesResponse create() => AddCategoriesResponse._();
  AddCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<AddCategoriesResponse> createRepeated() => $pb.PbList<AddCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static AddCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddCategoriesResponse>(create);
  static AddCategoriesResponse? _defaultInstance;
}

class DelCategoriesRequest extends $pb.GeneratedMessage {
  factory DelCategoriesRequest({
    Category? category,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  DelCategoriesRequest._() : super();
  factory DelCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DelCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DelCategoriesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'), createEmptyInstance: create)
    ..aOM<Category>(1, _omitFieldNames ? '' : 'category', subBuilder: Category.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DelCategoriesRequest clone() => DelCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DelCategoriesRequest copyWith(void Function(DelCategoriesRequest) updates) => super.copyWith((message) => updates(message as DelCategoriesRequest)) as DelCategoriesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DelCategoriesRequest create() => DelCategoriesRequest._();
  DelCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<DelCategoriesRequest> createRepeated() => $pb.PbList<DelCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static DelCategoriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DelCategoriesRequest>(create);
  static DelCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Category get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(Category v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);
  @$pb.TagNumber(1)
  Category ensureCategory() => $_ensure(0);
}

class DelCategoriesResponse extends $pb.GeneratedMessage {
  factory DelCategoriesResponse() => create();
  DelCategoriesResponse._() : super();
  factory DelCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DelCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DelCategoriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DelCategoriesResponse clone() => DelCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DelCategoriesResponse copyWith(void Function(DelCategoriesResponse) updates) => super.copyWith((message) => updates(message as DelCategoriesResponse)) as DelCategoriesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DelCategoriesResponse create() => DelCategoriesResponse._();
  DelCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<DelCategoriesResponse> createRepeated() => $pb.PbList<DelCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static DelCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DelCategoriesResponse>(create);
  static DelCategoriesResponse? _defaultInstance;
}

class Category extends $pb.GeneratedMessage {
  factory Category({
    $fixnum.Int64? iD,
    $core.String? category,
  }) {
    final $result = create();
    if (iD != null) {
      $result.iD = iD;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  Category._() : super();
  factory Category.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Category.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Category', package: const $pb.PackageName(_omitMessageNames ? '' : 'category.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'ID', $pb.PbFieldType.OU6, protoName: 'ID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Category clone() => Category()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Category copyWith(void Function(Category) updates) => super.copyWith((message) => updates(message as Category)) as Category;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Category create() => Category._();
  Category createEmptyInstance() => create();
  static $pb.PbList<Category> createRepeated() => $pb.PbList<Category>();
  @$core.pragma('dart2js:noInline')
  static Category getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Category>(create);
  static Category? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
