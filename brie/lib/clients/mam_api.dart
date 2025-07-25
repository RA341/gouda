import 'dart:async';
import 'dart:convert';

import 'package:brie/clients/mam_search.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/mam/v1/mam.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mamApiProvider = Provider<MamApi>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final client = MamServiceClient(channel, interceptors: [authInterceptor]);

  return MamApi(client);
});

final searchProvider = FutureProvider<SearchResults>((ref) async {
  const query = 'hitchhikers';

  final mam = ref.watch(mamApiProvider);

  return mam.list(query);
});

class MamApi {
  MamApi(this.apiClient);

  final MamServiceClient apiClient;

  Future<SearchResults> list(String search) async {
    return mustRunGrpcRequest(() => apiClient.search(Query(query: search)));
  }
}

final mamBooksSearchNotifier =
    AsyncNotifierProvider<MamBooksSearchNotifier, List<Book>>(() {
      return MamBooksSearchNotifier();
    });

class MamBooksSearchNotifier extends AsyncNotifier<List<Book>> {
  int page = 0;
  int found = 0;
  int total = 0;

  MamSearchQuery query = MamSearchQuery().resultsPerPage(20).startAt(0);

  // .includeThumbnail();

  @override
  Future<List<Book>> build() async {
    return search();
  }

  Future<List<Book>> search() async {
    final mam = ref.watch(mamApiProvider);
    if ((query.text ?? '').isEmpty) {
      return [];
    }

    final q = jsonEncode(query.toJson());
    final results = await mam.list(q);

    found = results.found;
    total = results.total;
    return results.results;
  }

  Future<void> paginateForward() async {
    page += 1;
    await fetchData();
  }

  Future<void> paginateBack() async {
    page -= 1;
    await fetchData();
  }

  Future<void> searchNew(String text) async {
    query.withText(text);
    page = 0;
    found = 0;
    total = 0;

    await fetchData();
  }

  Future<void> searchWithSort(SortType sort) async {
    query.sortBy(sort);
    await fetchData();
  }

  Future<void> fetchData() async {
    query.startAt(page);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return search();
    });
  }

  bool lastPage() => total ~/ 20 == query.startNumber;
}
