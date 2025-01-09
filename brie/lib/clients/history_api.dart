import 'package:brie/gen/media_requests/v1/media_requests.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:fixnum/src/int64.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyApiProvider = Provider<HistoryApi>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final catClient = MediaRequestServiceClient(
    channel,
    interceptors: [authInterceptor],
  );

  return HistoryApi(catClient);
});

class HistoryApi {
  final MediaRequestServiceClient apiClient;

  HistoryApi(this.apiClient);

  Future<(List<Media>, Int64)> getTorrentHistory({
    int limit = 20,
    int offset = 20,
  }) async {
    final medias = await apiClient.list(
      ListRequest(
        limit: Int64(limit),
        offset: Int64(offset),
      ),
    );
    return (medias.results, medias.totalRecords);
  }

  Future<void> retryBookRequest(Int64 id) async {
    await apiClient.retry(
      RetryRequest(iD: id),
    );
  }

  Future<List<Media>> searchMedia(String query) async {
    return (await apiClient.search(SearchRequest(mediaQuery: query))).results;
  }

  Future<void> deleteBookRequest(Int64 reqId) async {
    await apiClient.delete(DeleteRequest(requestId: reqId));
  }
}
