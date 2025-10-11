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

import 'package:protobuf/protobuf.dart' as $pb;

import 'category.pb.dart' as $0;
import 'category.pbjson.dart';

export 'category.pb.dart';

abstract class CategoryServiceBase extends $pb.GeneratedService {
  $async.Future<$0.ListCategoriesResponse> listCategories($pb.ServerContext ctx,
      $0.ListCategoriesRequest request);

  $async.Future<$0.AddCategoriesResponse> addCategories($pb.ServerContext ctx,
      $0.AddCategoriesRequest request);
  $async.Future<$0.DelCategoriesResponse> deleteCategories(
      $pb.ServerContext ctx, $0.DelCategoriesRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListCategories':
        return $0.ListCategoriesRequest();
      case 'AddCategories':
        return $0.AddCategoriesRequest();
      case 'DeleteCategories':
        return $0.DelCategoriesRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListCategories':
        return listCategories(ctx, request as $0.ListCategoriesRequest);
      case 'AddCategories':
        return addCategories(ctx, request as $0.AddCategoriesRequest);
      case 'DeleteCategories':
        return deleteCategories(ctx, request as $0.DelCategoriesRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => CategoryServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
  get $messageJson => CategoryServiceBase$messageJson;
}
