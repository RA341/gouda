import 'dart:async';
import 'dart:typed_data';

import 'package:brie/clients/category_api.dart';
import 'package:brie/clients/mam_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/category/v1/category.pbgrpc.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryListProvider =
AsyncNotifierProvider<CategoryNotifier, List<Category>>(
  CategoryNotifier.new,
);

class CategoryNotifier extends AsyncNotifier<List<Category>> {
  late final CategoryServiceClient api = ref.watch(categoryApiProvider);

  @override
  FutureOr<List<Category>> build() => fetchCat();

  Future<String?> add(String catName) async {
    final (_, err) = await runGrpcRequest(
          () =>
          api.addCategories(
            AddCategoriesRequest(category: catName),
          ),
    );

    await refetch();
    return err.orNull;
  }

  Future<String?> delete(Category cat) async {
    final (_, err) = await runGrpcRequest(
          () =>
          api.deleteCategories(
            DelCategoriesRequest(category: cat),
          ),
    );

    if (err.isNotEmpty) {
      return err;
    }

    await refetch();
    return null;
  }

  Future<void> refetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(fetchCat);
  }

  Future<List<Category>> fetchCat() async {
    final response = await api.listCategories(ListCategoriesRequest());

    return response.categories.toList();
  }
}

// The internal type is not exported by riverpod
// ignore: specify_nonobvious_property_types
final thumbnailProvider = FutureProvider.family<Uint8List, String>((
  ref,
  imageId,
) async {
  final mamApi = ref.watch(mamApiProvider);
  final res = await mamApi.getThumbnail(GetThumbnailRequest(id: imageId));
  return Uint8List.fromList(res.imageData);
});

// todo thumbnails move them to display only when user expands book info
// Consumer(
//   builder: (context, ref, child) {
//     final imageProvider = ref.watch(
//       thumbnailProvider(book.thumbnail),
//     );
//
//     return imageProvider.when(
//       data: (data) {
//         return Image.memory(
//           data,
//           scale: 10,
//         );
//       },
//       error: (error, stackTrace) {
//         logger.e("Error fetching thumbnail $error");
//         return const Icon(Icons.error);
//       },
//       loading: () {
//         return const CircularProgressIndicator();
//       },
//     );
//   },
// ),
