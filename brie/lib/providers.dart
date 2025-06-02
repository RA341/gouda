import 'package:brie/clients/auth_api.dart';
import 'package:brie/clients/category_api.dart';
import 'package:brie/clients/history_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/category/v1/category.pb.dart';
import 'package:brie/gen/media_requests/v1/media_requests.pb.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkTokenProvider = FutureProvider<bool>((ref) async {
  final token = ref.watch(apiTokenProvider);
  final authApi = ref.watch(authApiProvider);

  final status = await authApi.testToken(token: token);
  if (status) {
    // fetch settings if token is valid
    await ref.watch(settingsProvider.future);
  }

  // fetch settings
  return status;
});

final pageIndexListProvider = NotifierProvider<PageNotifier, int>(() {
  return PageNotifier();
});

final settingsProvider = FutureProvider<Settings>((ref) async {
  final settingsApi = ref.watch(settingsApiProvider);
  // initialize some extra info from the client
  await ref.watch(supportedClientsProvider.future);
  await ref.watch(metadataProvider.future);

  return await settingsApi.list();
});

final isSetupCompleteProvider = FutureProvider<bool>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  return settings.setupComplete;
});

final supportedClientsProvider = FutureProvider<List<String>>((ref) async {
  return ref.watch(settingsApiProvider).listClients();
});

final metadataProvider = FutureProvider<GetMetadataResponse>((ref) async {
  return ref.watch(settingsApiProvider).getMetadata();
});

final categoryListProvider = FutureProvider<List<Category>>((ref) async {
  final catApi = ref.watch(catProvider);
  return catApi.listCategory();
});

final requestHistoryProvider =
    AsyncNotifierProvider<RequestHistoryNotifier, List<Media>>(() {
  return RequestHistoryNotifier();
});

final searchProvider = StateProvider<String>((ref) {
  return '';
});

class PageNotifier extends Notifier<int> {
  @override
  int build() {
    ref.watch(checkTokenProvider);

    // if already on settings page and updated settings remain on settings page
    if (stateOrNull == 2) {
      return 2;
    }

    return 0;
  }

  void navigateToPage(int index) => state = index;
}

// The public methods on this class will be what allow the UI to modify the state.
class RequestHistoryNotifier extends AsyncNotifier<List<Media>> {
  var limit = 20;
  var offset = 0;
  var totalRecords = 0;

  @override
  Future<List<Media>> build() async {
    final histApi = ref.watch(historyApiProvider);
    final (records, count) = await histApi.getTorrentHistory(
      offset: offset,
      limit: limit,
    );

    totalRecords = count.toInt();
    return records;
  }

  Future<void> paginateForward() async {
    offset += 1;
    await fetchData();
  }

  Future<void> paginateBack() async {
    offset -= 1;
    await fetchData();
  }

  Future<void> fetchData() async {
    final histApi = ref.watch(historyApiProvider);
    final query = ref.watch(searchProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (query.isNotEmpty) {
        return await histApi.searchMedia(query);
      }

      final (books, count) = await histApi.getTorrentHistory(
        limit: limit,
        offset: offset * limit,
      );

      totalRecords = count.toInt();
      return books;
    });
  }

  bool lastPage() => totalRecords ~/ limit == offset;
}
