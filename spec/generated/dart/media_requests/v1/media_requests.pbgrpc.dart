//
//  Generated code. Do not modify.
//  source: media_requests/v1/media_requests.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'media_requests.pb.dart' as $2;

export 'media_requests.pb.dart';

@$pb.GrpcServiceName('media_requests.v1.MediaRequestService')
class MediaRequestServiceClient extends $grpc.Client {
  static final _$search = $grpc.ClientMethod<$2.SearchRequest, $2.SearchResponse>(
      '/media_requests.v1.MediaRequestService/Search',
      ($2.SearchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.SearchResponse.fromBuffer(value));
  static final _$list = $grpc.ClientMethod<$2.ListRequest, $2.ListResponse>(
      '/media_requests.v1.MediaRequestService/List',
      ($2.ListRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ListResponse.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$2.DeleteRequest, $2.DeleteResponse>(
      '/media_requests.v1.MediaRequestService/Delete',
      ($2.DeleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.DeleteResponse.fromBuffer(value));
  static final _$edit = $grpc.ClientMethod<$2.EditRequest, $2.EditResponse>(
      '/media_requests.v1.MediaRequestService/Edit',
      ($2.EditRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.EditResponse.fromBuffer(value));
  static final _$exists = $grpc.ClientMethod<$2.ExistsRequest, $2.ExistsResponse>(
      '/media_requests.v1.MediaRequestService/Exists',
      ($2.ExistsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.ExistsResponse.fromBuffer(value));
  static final _$retry = $grpc.ClientMethod<$2.RetryRequest, $2.RetryResponse>(
      '/media_requests.v1.MediaRequestService/Retry',
      ($2.RetryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.RetryResponse.fromBuffer(value));
  static final _$addMedia = $grpc.ClientMethod<$2.AddMediaRequest, $2.AddMediaResponse>(
      '/media_requests.v1.MediaRequestService/AddMedia',
      ($2.AddMediaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AddMediaResponse.fromBuffer(value));

  MediaRequestServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$2.SearchResponse> search($2.SearchRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$search, request, options: options);
  }

  $grpc.ResponseFuture<$2.ListResponse> list($2.ListRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$2.DeleteResponse> delete($2.DeleteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$2.EditResponse> edit($2.EditRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$edit, request, options: options);
  }

  $grpc.ResponseFuture<$2.ExistsResponse> exists($2.ExistsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$exists, request, options: options);
  }

  $grpc.ResponseFuture<$2.RetryResponse> retry($2.RetryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$retry, request, options: options);
  }

  $grpc.ResponseFuture<$2.AddMediaResponse> addMedia($2.AddMediaRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMedia, request, options: options);
  }
}

@$pb.GrpcServiceName('media_requests.v1.MediaRequestService')
abstract class MediaRequestServiceBase extends $grpc.Service {
  $core.String get $name => 'media_requests.v1.MediaRequestService';

  MediaRequestServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.SearchRequest, $2.SearchResponse>(
        'Search',
        search_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.SearchRequest.fromBuffer(value),
        ($2.SearchResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ListRequest, $2.ListResponse>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ListRequest.fromBuffer(value),
        ($2.ListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteRequest, $2.DeleteResponse>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteRequest.fromBuffer(value),
        ($2.DeleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.EditRequest, $2.EditResponse>(
        'Edit',
        edit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.EditRequest.fromBuffer(value),
        ($2.EditResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ExistsRequest, $2.ExistsResponse>(
        'Exists',
        exists_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ExistsRequest.fromBuffer(value),
        ($2.ExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.RetryRequest, $2.RetryResponse>(
        'Retry',
        retry_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.RetryRequest.fromBuffer(value),
        ($2.RetryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AddMediaRequest, $2.AddMediaResponse>(
        'AddMedia',
        addMedia_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AddMediaRequest.fromBuffer(value),
        ($2.AddMediaResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.SearchResponse> search_Pre($grpc.ServiceCall call, $async.Future<$2.SearchRequest> request) async {
    return search(call, await request);
  }

  $async.Future<$2.ListResponse> list_Pre($grpc.ServiceCall call, $async.Future<$2.ListRequest> request) async {
    return list(call, await request);
  }

  $async.Future<$2.DeleteResponse> delete_Pre($grpc.ServiceCall call, $async.Future<$2.DeleteRequest> request) async {
    return delete(call, await request);
  }

  $async.Future<$2.EditResponse> edit_Pre($grpc.ServiceCall call, $async.Future<$2.EditRequest> request) async {
    return edit(call, await request);
  }

  $async.Future<$2.ExistsResponse> exists_Pre($grpc.ServiceCall call, $async.Future<$2.ExistsRequest> request) async {
    return exists(call, await request);
  }

  $async.Future<$2.RetryResponse> retry_Pre($grpc.ServiceCall call, $async.Future<$2.RetryRequest> request) async {
    return retry(call, await request);
  }

  $async.Future<$2.AddMediaResponse> addMedia_Pre($grpc.ServiceCall call, $async.Future<$2.AddMediaRequest> request) async {
    return addMedia(call, await request);
  }

  $async.Future<$2.SearchResponse> search($grpc.ServiceCall call, $2.SearchRequest request);
  $async.Future<$2.ListResponse> list($grpc.ServiceCall call, $2.ListRequest request);
  $async.Future<$2.DeleteResponse> delete($grpc.ServiceCall call, $2.DeleteRequest request);
  $async.Future<$2.EditResponse> edit($grpc.ServiceCall call, $2.EditRequest request);
  $async.Future<$2.ExistsResponse> exists($grpc.ServiceCall call, $2.ExistsRequest request);
  $async.Future<$2.RetryResponse> retry($grpc.ServiceCall call, $2.RetryRequest request);
  $async.Future<$2.AddMediaResponse> addMedia($grpc.ServiceCall call, $2.AddMediaRequest request);
}
