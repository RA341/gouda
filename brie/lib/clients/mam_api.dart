import 'dart:async';

import 'package:brie/clients/mam_search.dart';
import 'package:brie/gen/mam/v1/mam.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mamApiProvider = Provider<MamServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final client = MamServiceClient(channel, interceptors: [authInterceptor]);
  return client;
});

final mamProfileProvider = FutureProvider<UserData>((ref) async {
  final mam = ref.watch(mamApiProvider);
  return mam.getProfile(Empty());
});

final mamBooksSearchNotifier =
    AsyncNotifierProvider<MamBooksSearchNotifier, List<SearchBook>>(() {
      return MamBooksSearchNotifier();
    });

class MamBooksSearchNotifier extends AsyncNotifier<List<SearchBook>> {
  int page = 0;
  int found = 0;
  int total = 0;

  MamSearchQuery query = MamSearchQuery().resultsPerPage(20).startAt(0);

  // .includeThumbnail();

  @override
  Future<List<SearchBook>> build() async {
    return search();
  }

  Future<List<SearchBook>> search() async {
    // todo
    // final mam = ref.watch(mamApiProvider);
    // if ((query.text ?? '').isEmpty) {
    //   return [];
    // }
    //
    // final q = jsonEncode(query.toJson());
    // final results = await mam.search(q);
    //
    // found = results.found;
    // total = results.total;
    // return results.results;
    return [];
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
