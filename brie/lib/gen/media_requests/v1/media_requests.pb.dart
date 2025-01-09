//
//  Generated code. Do not modify.
//  source: media_requests/v1/media_requests.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class SearchRequest extends $pb.GeneratedMessage {
  factory SearchRequest({
    $core.String? mediaQuery,
  }) {
    final $result = create();
    if (mediaQuery != null) {
      $result.mediaQuery = mediaQuery;
    }
    return $result;
  }
  SearchRequest._() : super();
  factory SearchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mediaQuery', protoName: 'mediaQuery')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchRequest clone() => SearchRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchRequest copyWith(void Function(SearchRequest) updates) => super.copyWith((message) => updates(message as SearchRequest)) as SearchRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRequest create() => SearchRequest._();
  SearchRequest createEmptyInstance() => create();
  static $pb.PbList<SearchRequest> createRepeated() => $pb.PbList<SearchRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchRequest>(create);
  static SearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mediaQuery => $_getSZ(0);
  @$pb.TagNumber(1)
  set mediaQuery($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMediaQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaQuery() => clearField(1);
}

class SearchResponse extends $pb.GeneratedMessage {
  factory SearchResponse({
    $core.Iterable<Media>? results,
  }) {
    final $result = create();
    if (results != null) {
      $result.results.addAll(results);
    }
    return $result;
  }
  SearchResponse._() : super();
  factory SearchResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..pc<Media>(1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM, subBuilder: Media.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchResponse clone() => SearchResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchResponse copyWith(void Function(SearchResponse) updates) => super.copyWith((message) => updates(message as SearchResponse)) as SearchResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchResponse create() => SearchResponse._();
  SearchResponse createEmptyInstance() => create();
  static $pb.PbList<SearchResponse> createRepeated() => $pb.PbList<SearchResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchResponse>(create);
  static SearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Media> get results => $_getList(0);
}

class ListRequest extends $pb.GeneratedMessage {
  factory ListRequest({
    $fixnum.Int64? limit,
    $fixnum.Int64? offset,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  ListRequest._() : super();
  factory ListRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListRequest clone() => ListRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListRequest copyWith(void Function(ListRequest) updates) => super.copyWith((message) => updates(message as ListRequest)) as ListRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRequest create() => ListRequest._();
  ListRequest createEmptyInstance() => create();
  static $pb.PbList<ListRequest> createRepeated() => $pb.PbList<ListRequest>();
  @$core.pragma('dart2js:noInline')
  static ListRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRequest>(create);
  static ListRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get limit => $_getI64(0);
  @$pb.TagNumber(1)
  set limit($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get offset => $_getI64(1);
  @$pb.TagNumber(2)
  set offset($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class ListResponse extends $pb.GeneratedMessage {
  factory ListResponse({
    $core.Iterable<Media>? results,
    $fixnum.Int64? totalRecords,
  }) {
    final $result = create();
    if (results != null) {
      $result.results.addAll(results);
    }
    if (totalRecords != null) {
      $result.totalRecords = totalRecords;
    }
    return $result;
  }
  ListResponse._() : super();
  factory ListResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..pc<Media>(1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM, subBuilder: Media.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'totalRecords', $pb.PbFieldType.OU6, protoName: 'totalRecords', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListResponse clone() => ListResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListResponse copyWith(void Function(ListResponse) updates) => super.copyWith((message) => updates(message as ListResponse)) as ListResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListResponse create() => ListResponse._();
  ListResponse createEmptyInstance() => create();
  static $pb.PbList<ListResponse> createRepeated() => $pb.PbList<ListResponse>();
  @$core.pragma('dart2js:noInline')
  static ListResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListResponse>(create);
  static ListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Media> get results => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalRecords => $_getI64(1);
  @$pb.TagNumber(2)
  set totalRecords($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalRecords() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRecords() => clearField(2);
}

class DeleteRequest extends $pb.GeneratedMessage {
  factory DeleteRequest({
    $fixnum.Int64? requestId,
  }) {
    final $result = create();
    if (requestId != null) {
      $result.requestId = requestId;
    }
    return $result;
  }
  DeleteRequest._() : super();
  factory DeleteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'requestId', $pb.PbFieldType.OU6, protoName: 'requestId', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteRequest clone() => DeleteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteRequest copyWith(void Function(DeleteRequest) updates) => super.copyWith((message) => updates(message as DeleteRequest)) as DeleteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRequest create() => DeleteRequest._();
  DeleteRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteRequest> createRepeated() => $pb.PbList<DeleteRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteRequest>(create);
  static DeleteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get requestId => $_getI64(0);
  @$pb.TagNumber(1)
  set requestId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);
}

class DeleteResponse extends $pb.GeneratedMessage {
  factory DeleteResponse() => create();
  DeleteResponse._() : super();
  factory DeleteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteResponse clone() => DeleteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteResponse copyWith(void Function(DeleteResponse) updates) => super.copyWith((message) => updates(message as DeleteResponse)) as DeleteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteResponse create() => DeleteResponse._();
  DeleteResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteResponse> createRepeated() => $pb.PbList<DeleteResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteResponse>(create);
  static DeleteResponse? _defaultInstance;
}

class EditRequest extends $pb.GeneratedMessage {
  factory EditRequest({
    Media? media,
  }) {
    final $result = create();
    if (media != null) {
      $result.media = media;
    }
    return $result;
  }
  EditRequest._() : super();
  factory EditRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EditRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EditRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..aOM<Media>(1, _omitFieldNames ? '' : 'media', subBuilder: Media.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EditRequest clone() => EditRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EditRequest copyWith(void Function(EditRequest) updates) => super.copyWith((message) => updates(message as EditRequest)) as EditRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EditRequest create() => EditRequest._();
  EditRequest createEmptyInstance() => create();
  static $pb.PbList<EditRequest> createRepeated() => $pb.PbList<EditRequest>();
  @$core.pragma('dart2js:noInline')
  static EditRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EditRequest>(create);
  static EditRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media(Media v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => clearField(1);
  @$pb.TagNumber(1)
  Media ensureMedia() => $_ensure(0);
}

class EditResponse extends $pb.GeneratedMessage {
  factory EditResponse() => create();
  EditResponse._() : super();
  factory EditResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EditResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EditResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EditResponse clone() => EditResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EditResponse copyWith(void Function(EditResponse) updates) => super.copyWith((message) => updates(message as EditResponse)) as EditResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EditResponse create() => EditResponse._();
  EditResponse createEmptyInstance() => create();
  static $pb.PbList<EditResponse> createRepeated() => $pb.PbList<EditResponse>();
  @$core.pragma('dart2js:noInline')
  static EditResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EditResponse>(create);
  static EditResponse? _defaultInstance;
}

class ExistsRequest extends $pb.GeneratedMessage {
  factory ExistsRequest({
    $fixnum.Int64? mamId,
  }) {
    final $result = create();
    if (mamId != null) {
      $result.mamId = mamId;
    }
    return $result;
  }
  ExistsRequest._() : super();
  factory ExistsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExistsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExistsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'mamId', $pb.PbFieldType.OU6, protoName: 'mamId', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExistsRequest clone() => ExistsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExistsRequest copyWith(void Function(ExistsRequest) updates) => super.copyWith((message) => updates(message as ExistsRequest)) as ExistsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExistsRequest create() => ExistsRequest._();
  ExistsRequest createEmptyInstance() => create();
  static $pb.PbList<ExistsRequest> createRepeated() => $pb.PbList<ExistsRequest>();
  @$core.pragma('dart2js:noInline')
  static ExistsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExistsRequest>(create);
  static ExistsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get mamId => $_getI64(0);
  @$pb.TagNumber(1)
  set mamId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMamId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMamId() => clearField(1);
}

class ExistsResponse extends $pb.GeneratedMessage {
  factory ExistsResponse({
    Media? media,
  }) {
    final $result = create();
    if (media != null) {
      $result.media = media;
    }
    return $result;
  }
  ExistsResponse._() : super();
  factory ExistsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExistsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExistsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..aOM<Media>(1, _omitFieldNames ? '' : 'media', subBuilder: Media.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExistsResponse clone() => ExistsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExistsResponse copyWith(void Function(ExistsResponse) updates) => super.copyWith((message) => updates(message as ExistsResponse)) as ExistsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExistsResponse create() => ExistsResponse._();
  ExistsResponse createEmptyInstance() => create();
  static $pb.PbList<ExistsResponse> createRepeated() => $pb.PbList<ExistsResponse>();
  @$core.pragma('dart2js:noInline')
  static ExistsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExistsResponse>(create);
  static ExistsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media(Media v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => clearField(1);
  @$pb.TagNumber(1)
  Media ensureMedia() => $_ensure(0);
}

class RetryRequest extends $pb.GeneratedMessage {
  factory RetryRequest({
    $fixnum.Int64? iD,
  }) {
    final $result = create();
    if (iD != null) {
      $result.iD = iD;
    }
    return $result;
  }
  RetryRequest._() : super();
  factory RetryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RetryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RetryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'ID', $pb.PbFieldType.OU6, protoName: 'ID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RetryRequest clone() => RetryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RetryRequest copyWith(void Function(RetryRequest) updates) => super.copyWith((message) => updates(message as RetryRequest)) as RetryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetryRequest create() => RetryRequest._();
  RetryRequest createEmptyInstance() => create();
  static $pb.PbList<RetryRequest> createRepeated() => $pb.PbList<RetryRequest>();
  @$core.pragma('dart2js:noInline')
  static RetryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RetryRequest>(create);
  static RetryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class RetryResponse extends $pb.GeneratedMessage {
  factory RetryResponse({
    Media? media,
  }) {
    final $result = create();
    if (media != null) {
      $result.media = media;
    }
    return $result;
  }
  RetryResponse._() : super();
  factory RetryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RetryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RetryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..aOM<Media>(1, _omitFieldNames ? '' : 'media', subBuilder: Media.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RetryResponse clone() => RetryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RetryResponse copyWith(void Function(RetryResponse) updates) => super.copyWith((message) => updates(message as RetryResponse)) as RetryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetryResponse create() => RetryResponse._();
  RetryResponse createEmptyInstance() => create();
  static $pb.PbList<RetryResponse> createRepeated() => $pb.PbList<RetryResponse>();
  @$core.pragma('dart2js:noInline')
  static RetryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RetryResponse>(create);
  static RetryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media(Media v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => clearField(1);
  @$pb.TagNumber(1)
  Media ensureMedia() => $_ensure(0);
}

class AddMediaRequest extends $pb.GeneratedMessage {
  factory AddMediaRequest({
    Media? media,
  }) {
    final $result = create();
    if (media != null) {
      $result.media = media;
    }
    return $result;
  }
  AddMediaRequest._() : super();
  factory AddMediaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddMediaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddMediaRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..aOM<Media>(1, _omitFieldNames ? '' : 'media', subBuilder: Media.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddMediaRequest clone() => AddMediaRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddMediaRequest copyWith(void Function(AddMediaRequest) updates) => super.copyWith((message) => updates(message as AddMediaRequest)) as AddMediaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddMediaRequest create() => AddMediaRequest._();
  AddMediaRequest createEmptyInstance() => create();
  static $pb.PbList<AddMediaRequest> createRepeated() => $pb.PbList<AddMediaRequest>();
  @$core.pragma('dart2js:noInline')
  static AddMediaRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddMediaRequest>(create);
  static AddMediaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media(Media v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => clearField(1);
  @$pb.TagNumber(1)
  Media ensureMedia() => $_ensure(0);
}

class AddMediaResponse extends $pb.GeneratedMessage {
  factory AddMediaResponse() => create();
  AddMediaResponse._() : super();
  factory AddMediaResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddMediaResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddMediaResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddMediaResponse clone() => AddMediaResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddMediaResponse copyWith(void Function(AddMediaResponse) updates) => super.copyWith((message) => updates(message as AddMediaResponse)) as AddMediaResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddMediaResponse create() => AddMediaResponse._();
  AddMediaResponse createEmptyInstance() => create();
  static $pb.PbList<AddMediaResponse> createRepeated() => $pb.PbList<AddMediaResponse>();
  @$core.pragma('dart2js:noInline')
  static AddMediaResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddMediaResponse>(create);
  static AddMediaResponse? _defaultInstance;
}

class Media extends $pb.GeneratedMessage {
  factory Media({
    $fixnum.Int64? iD,
    $core.String? author,
    $core.String? book,
    $core.String? series,
    $core.int? seriesNumber,
    $core.String? category,
    $fixnum.Int64? mamBookId,
    $core.String? status,
    $core.String? torrentId,
    $core.int? timeRunning,
    $core.String? torrentFileLocation,
    $core.String? fileLink,
    $core.String? createdAt,
  }) {
    final $result = create();
    if (iD != null) {
      $result.iD = iD;
    }
    if (author != null) {
      $result.author = author;
    }
    if (book != null) {
      $result.book = book;
    }
    if (series != null) {
      $result.series = series;
    }
    if (seriesNumber != null) {
      $result.seriesNumber = seriesNumber;
    }
    if (category != null) {
      $result.category = category;
    }
    if (mamBookId != null) {
      $result.mamBookId = mamBookId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (torrentId != null) {
      $result.torrentId = torrentId;
    }
    if (timeRunning != null) {
      $result.timeRunning = timeRunning;
    }
    if (torrentFileLocation != null) {
      $result.torrentFileLocation = torrentFileLocation;
    }
    if (fileLink != null) {
      $result.fileLink = fileLink;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  Media._() : super();
  factory Media.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Media.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Media', package: const $pb.PackageName(_omitMessageNames ? '' : 'media_requests.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'ID', $pb.PbFieldType.OU6, protoName: 'ID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'author')
    ..aOS(3, _omitFieldNames ? '' : 'book')
    ..aOS(4, _omitFieldNames ? '' : 'series')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'seriesNumber', $pb.PbFieldType.OU3)
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'mamBookId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'torrentId')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'timeRunning', $pb.PbFieldType.OU3)
    ..aOS(11, _omitFieldNames ? '' : 'torrentFileLocation')
    ..aOS(12, _omitFieldNames ? '' : 'fileLink')
    ..aOS(13, _omitFieldNames ? '' : 'createdAt', protoName: 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Media clone() => Media()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Media copyWith(void Function(Media) updates) => super.copyWith((message) => updates(message as Media)) as Media;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Media create() => Media._();
  Media createEmptyInstance() => create();
  static $pb.PbList<Media> createRepeated() => $pb.PbList<Media>();
  @$core.pragma('dart2js:noInline')
  static Media getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Media>(create);
  static Media? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get author => $_getSZ(1);
  @$pb.TagNumber(2)
  set author($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get book => $_getSZ(2);
  @$pb.TagNumber(3)
  set book($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBook() => $_has(2);
  @$pb.TagNumber(3)
  void clearBook() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get series => $_getSZ(3);
  @$pb.TagNumber(4)
  set series($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSeries() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeries() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get seriesNumber => $_getIZ(4);
  @$pb.TagNumber(5)
  set seriesNumber($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSeriesNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearSeriesNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get mamBookId => $_getI64(6);
  @$pb.TagNumber(7)
  set mamBookId($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMamBookId() => $_has(6);
  @$pb.TagNumber(7)
  void clearMamBookId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get torrentId => $_getSZ(8);
  @$pb.TagNumber(9)
  set torrentId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTorrentId() => $_has(8);
  @$pb.TagNumber(9)
  void clearTorrentId() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get timeRunning => $_getIZ(9);
  @$pb.TagNumber(10)
  set timeRunning($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTimeRunning() => $_has(9);
  @$pb.TagNumber(10)
  void clearTimeRunning() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get torrentFileLocation => $_getSZ(10);
  @$pb.TagNumber(11)
  set torrentFileLocation($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTorrentFileLocation() => $_has(10);
  @$pb.TagNumber(11)
  void clearTorrentFileLocation() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get fileLink => $_getSZ(11);
  @$pb.TagNumber(12)
  set fileLink($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasFileLink() => $_has(11);
  @$pb.TagNumber(12)
  void clearFileLink() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
