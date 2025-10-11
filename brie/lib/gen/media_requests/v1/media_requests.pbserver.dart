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

import 'package:protobuf/protobuf.dart' as $pb;

import 'media_requests.pb.dart' as $0;
import 'media_requests.pbjson.dart';

export 'media_requests.pb.dart';

abstract class MediaRequestServiceBase extends $pb.GeneratedService {
  $async.Future<$0.SearchResponse> search($pb.ServerContext ctx,
      $0.SearchRequest request);

  $async.Future<$0.ListResponse> list($pb.ServerContext ctx,
      $0.ListRequest request);

  $async.Future<$0.DeleteResponse> delete($pb.ServerContext ctx,
      $0.DeleteRequest request);

  $async.Future<$0.EditResponse> edit($pb.ServerContext ctx,
      $0.EditRequest request);

  $async.Future<$0.ExistsResponse> exists($pb.ServerContext ctx,
      $0.ExistsRequest request);

  $async.Future<$0.RetryResponse> retry($pb.ServerContext ctx,
      $0.RetryRequest request);

  $async.Future<$0.AddMediaResponse> addMedia($pb.ServerContext ctx,
      $0.AddMediaRequest request);
  $async.Future<$0.AddMediaResponse> addMediaWithFreeleech(
      $pb.ServerContext ctx, $0.AddMediaRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Search':
        return $0.SearchRequest();
      case 'List':
        return $0.ListRequest();
      case 'Delete':
        return $0.DeleteRequest();
      case 'Edit':
        return $0.EditRequest();
      case 'Exists':
        return $0.ExistsRequest();
      case 'Retry':
        return $0.RetryRequest();
      case 'AddMedia':
        return $0.AddMediaRequest();
      case 'AddMediaWithFreeleech':
        return $0.AddMediaRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Search':
        return search(ctx, request as $0.SearchRequest);
      case 'List':
        return list(ctx, request as $0.ListRequest);
      case 'Delete':
        return delete(ctx, request as $0.DeleteRequest);
      case 'Edit':
        return edit(ctx, request as $0.EditRequest);
      case 'Exists':
        return exists(ctx, request as $0.ExistsRequest);
      case 'Retry':
        return retry(ctx, request as $0.RetryRequest);
      case 'AddMedia':
        return addMedia(ctx, request as $0.AddMediaRequest);
      case 'AddMediaWithFreeleech':
        return addMediaWithFreeleech(ctx, request as $0.AddMediaRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      MediaRequestServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
  get $messageJson => MediaRequestServiceBase$messageJson;
}
