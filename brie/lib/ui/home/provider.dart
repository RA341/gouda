import 'dart:async';

import 'package:brie/clients/history_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/media_requests/v1/media_requests.pbgrpc.dart';
import 'package:brie/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AsyncNotifierProvider<BookRequestHistoryNotifier, List<Media>>
bookHistoryProvider = AsyncNotifierProvider(
  BookRequestHistoryNotifier.new,
);

class BookRequestHistoryNotifier extends AsyncNotifier<List<Media>> {
  late final MediaRequestServiceClient mediaApi = ref.watch(
    mediaRequestApiProvider,
  );

  Timer? _timer;

  @override
  FutureOr<List<Media>> build() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!state.isLoading) {
        ref.invalidateSelf();
      }
    });
    ref.onDispose(() {
      _timer?.cancel();
    });

    final res = await mustRunGrpcRequest(
      () => mediaApi.list(
        ListRequest(
          // todo
          // limit:
          // offset:
        ),
      ),
    );

    logger.i("ssscc");
    return res.results.toList();
  }
}
