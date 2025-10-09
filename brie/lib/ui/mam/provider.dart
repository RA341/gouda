import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:brie/clients/category_api.dart';
import 'package:brie/clients/mam_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/category/v1/category.connect.client.dart';
import 'package:brie/gen/category/v1/category.pb.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/ui/mam/mam_search.dart';
import 'package:brie/utils.dart';
import 'package:brie/utils/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef QueryUpdater = MamSearchQuery Function(MamSearchQuery query);

extension Search on WidgetRef {
  MamSearchQuery query() {
    return watch(mamSearchQueryProvider);
  }

  void updateQuery(QueryUpdater up) {
    read(mamSearchQueryProvider.notifier).updateQuery(up);
  }

  Future<void> search(MamSearchQuery q, {bool search = false}) async {
    await read(mamBooksSearchProvider.notifier).search(q, searchNew: search);
  }
}

final mamSearchQueryProvider =
    NotifierProvider<MamSearchQueryNotifier, MamSearchQuery>(
      MamSearchQueryNotifier.new,
    );

class MamSearchQueryNotifier extends Notifier<MamSearchQuery> {
  @override
  MamSearchQuery build() {
    return MamSearchQuery();
  }

  final encoder = const JsonEncoder.withIndent('  ');

  void updateQuery(QueryUpdater modify) {
    state = modify(state.clone());

    final json = encoder.convert(state.toJson());
    logger.d("query $json");
  }
}

final mamBooksSearchProvider =
    AsyncNotifierProvider<MamBooksSearchNotifier, List<SearchBook>>(
      MamBooksSearchNotifier.new,
    );

class MamBooksSearchNotifier extends AsyncNotifier<List<SearchBook>> {
  int found = 0;
  int total = 0;

  int page = 0;
  int perPage = 20;

  @override
  Future<List<SearchBook>> build() async => _runQuery();

  Future<void> search(MamSearchQuery query, {bool searchNew = false}) async {
    if (searchNew) {
      page = 0;
      found = 0;
      total = 0;
    }

    // logger.i("ss ${query.toJson()}");
    // todo cancel prev request
    // if (state.isLoading) {}

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _runQuery(query: query));
  }

  Future<List<SearchBook>> _runQuery({MamSearchQuery? query}) async {
    if (query == null) {
      return [];
    }
    if ((query.text ?? '').isEmpty) {
      return [];
    }

    final jsonQuery = jsonEncode(query.toJson());
    final mam = ref.watch(mamApiProvider);
    final results = await mustRunGrpcRequest(
      () => mam.search(Query(query: jsonQuery)),
    );

    found = results.found;
    total = results.total;
    return results.results;
  }

  Future<void> paginateForward() async {
    if (!lastPage()) {
      page += 1;
      await paginate();
    }
  }

  Future<void> paginateBack() async {
    if (page > 0) {
      page -= 1;
      await paginate();
    }
  }

  Future<void> paginate() async {
    final query = ref.read(mamSearchQueryProvider)..startAt(page * perPage);
    await search(query);
  }

  bool lastPage() => found < perPage;
}

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
      () => api.addCategories(
        AddCategoriesRequest(category: catName),
      ),
    );

    await refetch();
    return err.orNull;
  }

  Future<String?> delete(Category cat) async {
    final (_, err) = await runGrpcRequest(
      () => api.deleteCategories(
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
