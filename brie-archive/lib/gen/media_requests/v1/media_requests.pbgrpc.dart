// This is a generated file - do not edit.
//
// Generated from media_requests/v1/media_requests.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'media_requests.pb.dart' as $0;

export 'media_requests.pb.dart';

@$pb.GrpcServiceName('media_requests.v1.MediaRequestService')
class MediaRequestServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MediaRequestServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.SearchResponse> search(
    $0.SearchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$search, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListResponse> list(
    $0.ListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteResponse> delete(
    $0.DeleteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$0.EditResponse> edit(
    $0.EditRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$edit, request, options: options);
  }

  $grpc.ResponseFuture<$0.ExistsResponse> exists(
    $0.ExistsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$exists, request, options: options);
  }

  $grpc.ResponseFuture<$0.RetryResponse> retry(
    $0.RetryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$retry, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddMediaResponse> addMedia(
    $0.AddMediaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addMedia, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddMediaResponse> addMediaWithFreeleech(
    $0.AddMediaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addMediaWithFreeleech, request, options: options);
  }

  // method descriptors

  static final _$search =
      $grpc.ClientMethod<$0.SearchRequest, $0.SearchResponse>(
          '/media_requests.v1.MediaRequestService/Search',
          ($0.SearchRequest value) => value.writeToBuffer(),
          $0.SearchResponse.fromBuffer);
  static final _$list = $grpc.ClientMethod<$0.ListRequest, $0.ListResponse>(
      '/media_requests.v1.MediaRequestService/List',
      ($0.ListRequest value) => value.writeToBuffer(),
      $0.ListResponse.fromBuffer);
  static final _$delete =
      $grpc.ClientMethod<$0.DeleteRequest, $0.DeleteResponse>(
          '/media_requests.v1.MediaRequestService/Delete',
          ($0.DeleteRequest value) => value.writeToBuffer(),
          $0.DeleteResponse.fromBuffer);
  static final _$edit = $grpc.ClientMethod<$0.EditRequest, $0.EditResponse>(
      '/media_requests.v1.MediaRequestService/Edit',
      ($0.EditRequest value) => value.writeToBuffer(),
      $0.EditResponse.fromBuffer);
  static final _$exists =
      $grpc.ClientMethod<$0.ExistsRequest, $0.ExistsResponse>(
          '/media_requests.v1.MediaRequestService/Exists',
          ($0.ExistsRequest value) => value.writeToBuffer(),
          $0.ExistsResponse.fromBuffer);
  static final _$retry = $grpc.ClientMethod<$0.RetryRequest, $0.RetryResponse>(
      '/media_requests.v1.MediaRequestService/Retry',
      ($0.RetryRequest value) => value.writeToBuffer(),
      $0.RetryResponse.fromBuffer);
  static final _$addMedia =
      $grpc.ClientMethod<$0.AddMediaRequest, $0.AddMediaResponse>(
          '/media_requests.v1.MediaRequestService/AddMedia',
          ($0.AddMediaRequest value) => value.writeToBuffer(),
          $0.AddMediaResponse.fromBuffer);
  static final _$addMediaWithFreeleech =
      $grpc.ClientMethod<$0.AddMediaRequest, $0.AddMediaResponse>(
          '/media_requests.v1.MediaRequestService/AddMediaWithFreeleech',
          ($0.AddMediaRequest value) => value.writeToBuffer(),
          $0.AddMediaResponse.fromBuffer);
}

@$pb.GrpcServiceName('media_requests.v1.MediaRequestService')
abstract class MediaRequestServiceBase extends $grpc.Service {
  $core.String get $name => 'media_requests.v1.MediaRequestService';

  MediaRequestServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SearchRequest, $0.SearchResponse>(
        'Search',
        search_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchRequest.fromBuffer(value),
        ($0.SearchResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListRequest, $0.ListResponse>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListRequest.fromBuffer(value),
        ($0.ListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteRequest, $0.DeleteResponse>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteRequest.fromBuffer(value),
        ($0.DeleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EditRequest, $0.EditResponse>(
        'Edit',
        edit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EditRequest.fromBuffer(value),
        ($0.EditResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExistsRequest, $0.ExistsResponse>(
        'Exists',
        exists_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExistsRequest.fromBuffer(value),
        ($0.ExistsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RetryRequest, $0.RetryResponse>(
        'Retry',
        retry_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RetryRequest.fromBuffer(value),
        ($0.RetryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddMediaRequest, $0.AddMediaResponse>(
        'AddMedia',
        addMedia_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddMediaRequest.fromBuffer(value),
        ($0.AddMediaResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddMediaRequest, $0.AddMediaResponse>(
        'AddMediaWithFreeleech',
        addMediaWithFreeleech_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddMediaRequest.fromBuffer(value),
        ($0.AddMediaResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SearchResponse> search_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SearchRequest> $request) async {
    return search($call, await $request);
  }

  $async.Future<$0.SearchResponse> search(
      $grpc.ServiceCall call, $0.SearchRequest request);

  $async.Future<$0.ListResponse> list_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ListRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$0.ListResponse> list(
      $grpc.ServiceCall call, $0.ListRequest request);

  $async.Future<$0.DeleteResponse> delete_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.DeleteRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$0.DeleteResponse> delete(
      $grpc.ServiceCall call, $0.DeleteRequest request);

  $async.Future<$0.EditResponse> edit_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.EditRequest> $request) async {
    return edit($call, await $request);
  }

  $async.Future<$0.EditResponse> edit(
      $grpc.ServiceCall call, $0.EditRequest request);

  $async.Future<$0.ExistsResponse> exists_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.ExistsRequest> $request) async {
    return exists($call, await $request);
  }

  $async.Future<$0.ExistsResponse> exists(
      $grpc.ServiceCall call, $0.ExistsRequest request);

  $async.Future<$0.RetryResponse> retry_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RetryRequest> $request) async {
    return retry($call, await $request);
  }

  $async.Future<$0.RetryResponse> retry(
      $grpc.ServiceCall call, $0.RetryRequest request);

  $async.Future<$0.AddMediaResponse> addMedia_Pre($grpc.ServiceCall $call,
      $async.Future<$0.AddMediaRequest> $request) async {
    return addMedia($call, await $request);
  }

  $async.Future<$0.AddMediaResponse> addMedia(
      $grpc.ServiceCall call, $0.AddMediaRequest request);

  $async.Future<$0.AddMediaResponse> addMediaWithFreeleech_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AddMediaRequest> $request) async {
    return addMediaWithFreeleech($call, await $request);
  }

  $async.Future<$0.AddMediaResponse> addMediaWithFreeleech(
      $grpc.ServiceCall call, $0.AddMediaRequest request);
}
