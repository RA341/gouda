//
//  Generated code. Do not modify.
//  source: category/v1/category.proto
//
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

import 'category.pb.dart' as $1;

export 'category.pb.dart';

@$pb.GrpcServiceName('category.v1.CategoryService')
class CategoryServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$listCategories = $grpc.ClientMethod<$1.ListCategoriesRequest, $1.ListCategoriesResponse>(
      '/category.v1.CategoryService/ListCategories',
      ($1.ListCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListCategoriesResponse.fromBuffer(value));
  static final _$addCategories = $grpc.ClientMethod<$1.AddCategoriesRequest, $1.AddCategoriesResponse>(
      '/category.v1.CategoryService/AddCategories',
      ($1.AddCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AddCategoriesResponse.fromBuffer(value));
  static final _$deleteCategories = $grpc.ClientMethod<$1.DelCategoriesRequest, $1.DelCategoriesResponse>(
      '/category.v1.CategoryService/DeleteCategories',
      ($1.DelCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DelCategoriesResponse.fromBuffer(value));

  CategoryServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.ListCategoriesResponse> listCategories($1.ListCategoriesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listCategories, request, options: options);
  }

  $grpc.ResponseFuture<$1.AddCategoriesResponse> addCategories($1.AddCategoriesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addCategories, request, options: options);
  }

  $grpc.ResponseFuture<$1.DelCategoriesResponse> deleteCategories($1.DelCategoriesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCategories, request, options: options);
  }
}

@$pb.GrpcServiceName('category.v1.CategoryService')
abstract class CategoryServiceBase extends $grpc.Service {
  $core.String get $name => 'category.v1.CategoryService';

  CategoryServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.ListCategoriesRequest, $1.ListCategoriesResponse>(
        'ListCategories',
        listCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListCategoriesRequest.fromBuffer(value),
        ($1.ListCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddCategoriesRequest, $1.AddCategoriesResponse>(
        'AddCategories',
        addCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AddCategoriesRequest.fromBuffer(value),
        ($1.AddCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DelCategoriesRequest, $1.DelCategoriesResponse>(
        'DeleteCategories',
        deleteCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DelCategoriesRequest.fromBuffer(value),
        ($1.DelCategoriesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.ListCategoriesResponse> listCategories_Pre($grpc.ServiceCall $call, $async.Future<$1.ListCategoriesRequest> $request) async {
    return listCategories($call, await $request);
  }

  $async.Future<$1.AddCategoriesResponse> addCategories_Pre($grpc.ServiceCall $call, $async.Future<$1.AddCategoriesRequest> $request) async {
    return addCategories($call, await $request);
  }

  $async.Future<$1.DelCategoriesResponse> deleteCategories_Pre($grpc.ServiceCall $call, $async.Future<$1.DelCategoriesRequest> $request) async {
    return deleteCategories($call, await $request);
  }

  $async.Future<$1.ListCategoriesResponse> listCategories($grpc.ServiceCall call, $1.ListCategoriesRequest request);
  $async.Future<$1.AddCategoriesResponse> addCategories($grpc.ServiceCall call, $1.AddCategoriesRequest request);
  $async.Future<$1.DelCategoriesResponse> deleteCategories($grpc.ServiceCall call, $1.DelCategoriesRequest request);
}
