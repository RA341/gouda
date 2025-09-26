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

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'category.pb.dart' as $0;

export 'category.pb.dart';

@$pb.GrpcServiceName('category.v1.CategoryService')
class CategoryServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  CategoryServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ListCategoriesResponse> listCategories(
    $0.ListCategoriesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listCategories, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddCategoriesResponse> addCategories(
    $0.AddCategoriesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addCategories, request, options: options);
  }

  $grpc.ResponseFuture<$0.DelCategoriesResponse> deleteCategories(
    $0.DelCategoriesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteCategories, request, options: options);
  }

  // method descriptors

  static final _$listCategories =
      $grpc.ClientMethod<$0.ListCategoriesRequest, $0.ListCategoriesResponse>(
          '/category.v1.CategoryService/ListCategories',
          ($0.ListCategoriesRequest value) => value.writeToBuffer(),
          $0.ListCategoriesResponse.fromBuffer);
  static final _$addCategories =
      $grpc.ClientMethod<$0.AddCategoriesRequest, $0.AddCategoriesResponse>(
          '/category.v1.CategoryService/AddCategories',
          ($0.AddCategoriesRequest value) => value.writeToBuffer(),
          $0.AddCategoriesResponse.fromBuffer);
  static final _$deleteCategories =
      $grpc.ClientMethod<$0.DelCategoriesRequest, $0.DelCategoriesResponse>(
          '/category.v1.CategoryService/DeleteCategories',
          ($0.DelCategoriesRequest value) => value.writeToBuffer(),
          $0.DelCategoriesResponse.fromBuffer);
}

@$pb.GrpcServiceName('category.v1.CategoryService')
abstract class CategoryServiceBase extends $grpc.Service {
  $core.String get $name => 'category.v1.CategoryService';

  CategoryServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ListCategoriesRequest,
            $0.ListCategoriesResponse>(
        'ListCategories',
        listCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListCategoriesRequest.fromBuffer(value),
        ($0.ListCategoriesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.AddCategoriesRequest, $0.AddCategoriesResponse>(
            'AddCategories',
            addCategories_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AddCategoriesRequest.fromBuffer(value),
            ($0.AddCategoriesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DelCategoriesRequest, $0.DelCategoriesResponse>(
            'DeleteCategories',
            deleteCategories_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DelCategoriesRequest.fromBuffer(value),
            ($0.DelCategoriesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ListCategoriesResponse> listCategories_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListCategoriesRequest> $request) async {
    return listCategories($call, await $request);
  }

  $async.Future<$0.ListCategoriesResponse> listCategories(
      $grpc.ServiceCall call, $0.ListCategoriesRequest request);

  $async.Future<$0.AddCategoriesResponse> addCategories_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AddCategoriesRequest> $request) async {
    return addCategories($call, await $request);
  }

  $async.Future<$0.AddCategoriesResponse> addCategories(
      $grpc.ServiceCall call, $0.AddCategoriesRequest request);

  $async.Future<$0.DelCategoriesResponse> deleteCategories_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DelCategoriesRequest> $request) async {
    return deleteCategories($call, await $request);
  }

  $async.Future<$0.DelCategoriesResponse> deleteCategories(
      $grpc.ServiceCall call, $0.DelCategoriesRequest request);
}
