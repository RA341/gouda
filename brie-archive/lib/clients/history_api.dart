import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/gen/media_requests/v1/media_requests.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:fixnum/fixnum.dart';
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
    final medias = await mustRunGrpcRequest(
      () => apiClient.list(
        ListRequest(limit: Int64(limit), offset: Int64(offset)),
      ),
    );
    return (medias.results, medias.totalRecords);
  }

  Future<void> retryBookRequest(Int64 id) async {
    await mustRunGrpcRequest(
      () => apiClient.retry(
        RetryRequest(iD: id),
      ),
    );
  }

  Future<List<Media>> searchMedia(String query) async {
    return (await mustRunGrpcRequest(
      () => apiClient.search(
        SearchRequest(mediaQuery: query),
      ),
    )).results;
  }

  Future<AddMediaResponse> download(
    SearchBook book,
    String cat, {
    bool useFreeleech = false,
  }) async {
    final req = AddMediaRequest(
      media: Media(
        author: book.author[0].name,
        book: book.title,
        category: cat,
        mamBookId: Int64(book.mamId),
        fileLink: book.torrentLink,
      ),
    );

    return mustRunGrpcRequest(
      () => useFreeleech
          ? apiClient.addMediaWithFreeleech(req)
          : apiClient.addMedia(req),
    );
  }

  Future<void> deleteBookRequest(Int64 reqId) async {
    await mustRunGrpcRequest(
      () => apiClient.delete(
        DeleteRequest(requestId: reqId),
      ),
    );
  }
}
