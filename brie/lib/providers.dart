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
  return authApi.testToken(token: token);
});

final pageIndexListProvider = StateProvider<int>((ref) {
  ref.watch(checkTokenProvider);
  return 0;
});

final settingsProvider = FutureProvider<Settings>((ref) async {
  final settingsApi = ref.watch(settingsApiProvider);

  return await settingsApi.list();
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
