import 'package:brie/gen/category/v1/category.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catProvider = Provider<CategoryApi>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final catClient = CategoryServiceClient(
    channel,
    interceptors: [authInterceptor],
  );

  return CategoryApi(catClient);
});

class CategoryApi {
  final CategoryServiceClient apiClient;

  CategoryApi(this.apiClient);

  Future<void> addCategory(String cat) async {
    await apiClient.addCategories(AddCategoriesRequest(category: cat));
  }

  Future<void> deleteCategory(Category cat) async {
    await apiClient.deleteCategories(
      DelCategoriesRequest(category: cat),
    );
  }

  Future<List<Category>> listCategory() async {
    final resp = await apiClient.listCategories(ListCategoriesRequest());
    return resp.categories;
  }
}
