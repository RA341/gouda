import 'package:brie/api/api.dart';
import 'package:brie/api/auth_api.dart';
import 'package:brie/api/category_api.dart';
import 'package:brie/api/history_api.dart';
import 'package:brie/api/settings_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models.dart';

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

final categoryListProvider = FutureProvider<List<(String, int)>>((ref) async {
  final catApi = ref.watch(catProvider);
  return catApi.listCategory();
});

final requestHistoryProvider =
    AsyncNotifierProvider<RequestHistoryNotifier, List<Book>>(() {
  return RequestHistoryNotifier();
});

// The public methods on this class will be what allow the UI to modify the state.
class RequestHistoryNotifier extends AsyncNotifier<List<Book>> {
  var limit = 20;
  var offset = 0;

  @override
  Future<List<Book>> build() async {
    final histApi = ref.watch(historyApiProvider);
    return await histApi.getTorrentHistory(limit: limit, offset: offset);
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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await histApi.getTorrentHistory(limit: limit, offset: offset);
    });
  }
}
