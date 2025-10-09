//
//  Generated code. Do not modify.
//  source: category/v1/category.proto
//

import "package:connectrpc/connect.dart" as connect;
import "category.pb.dart" as categoryv1category;

abstract final class CategoryService {
  /// Fully-qualified name of the CategoryService service.
  static const name = 'category.v1.CategoryService';

  static const listCategories = connect.Spec(
    '/$name/ListCategories',
    connect.StreamType.unary,
    categoryv1category.ListCategoriesRequest.new,
    categoryv1category.ListCategoriesResponse.new,
  );

  static const addCategories = connect.Spec(
    '/$name/AddCategories',
    connect.StreamType.unary,
    categoryv1category.AddCategoriesRequest.new,
    categoryv1category.AddCategoriesResponse.new,
  );

  static const deleteCategories = connect.Spec(
    '/$name/DeleteCategories',
    connect.StreamType.unary,
    categoryv1category.DelCategoriesRequest.new,
    categoryv1category.DelCategoriesResponse.new,
  );
}
