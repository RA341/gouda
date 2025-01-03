// import 'package:brie/api/api.dart';
// import 'package:brie/models.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final historyApiProvider = Provider<HistoryApi>((ref) {
//   final client = ref.watch(apiClientProvider);
//   return HistoryApi(client);
// });
//
// class HistoryApi {
//   final Dio apiClient;
//
//   HistoryApi(this.apiClient);
//
//   Future<(List<Book>, int)> getTorrentHistory({int limit = 20, int offset = 0}) async {
//     final response = await apiClient.get(
//       '/history/all',
//       queryParameters: {'limit': limit, 'offset': offset},
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to get history: ${response.statusCode}');
//     }
//
//     final tmp = response.data as Map<String, dynamic>;
//     final res = (tmp['torrents'] as List<dynamic>).map((e) => Book.fromJson(e)).toList();
//     final count = tmp['count'] as int;
//     return (res, count);
//   }
//
//   Future<void> retryBookRequest(String id) async {
//     final response = await apiClient.get('/history/retry/$id');
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed retry: ${response.statusCode}');
//     }
//   }
//
//   Future<void> deleteBookRequest(String id) async {
//     final response = await apiClient.delete('/history/delete/$id');
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed retry: ${response.statusCode}');
//     }
//   }
// }
