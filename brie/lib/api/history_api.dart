import 'dart:convert';

import 'package:brie/api/api.dart';
import 'package:brie/models.dart';

final histApi = HistoryApi();

class HistoryApi {
  HistoryApi();

  Future<List<Book>> getTorrentHistory() async {
    final response = await apiClient.get(
      ('/history/all'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get history: ${response.statusCode}');
    }

    final tmp = response.data as List<dynamic>;
    final res = tmp.map((e) => Book.fromJson(e)).toList();
    return res;
  }

  Future<void> retryBookRequest(String id) async {
    final response = await apiClient.get(
      ('/history/retry/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed retry: ${response.statusCode}');
    }
  }

  Future<void> deleteBookRequest(String id) async {
    final response = await apiClient.delete(
      ('/history/delete/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed retry: ${response.statusCode}');
    }
  }
}
