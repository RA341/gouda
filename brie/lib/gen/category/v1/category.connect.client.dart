//
//  Generated code. Do not modify.
//  source: category/v1/category.proto
//

import "package:connectrpc/connect.dart" as connect;
import "category.pb.dart" as categoryv1category;
import "category.connect.spec.dart" as specs;

extension type CategoryServiceClient (connect.Transport _transport) {
  Future<categoryv1category.ListCategoriesResponse> listCategories(
    categoryv1category.ListCategoriesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.CategoryService.listCategories,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<categoryv1category.AddCategoriesResponse> addCategories(
    categoryv1category.AddCategoriesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.CategoryService.addCategories,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<categoryv1category.DelCategoriesResponse> deleteCategories(
    categoryv1category.DelCategoriesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.CategoryService.deleteCategories,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
