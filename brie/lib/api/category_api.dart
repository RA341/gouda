import 'dart:convert';

import 'package:brie/api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catProvider = Provider<CategoryApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return CategoryApi(client);
});

class CategoryApi {
  final Dio apiClient;

  CategoryApi(this.apiClient);

  Future<void> addCategory(String cat) async {
    final resp = await apiClient.post(
      '/category/add',
      data: jsonEncode({"category": cat}),
    );

    if (resp.statusCode != 200) {
      throw Exception("Failed to add category $cat, ${resp.data}");
    }
  }

  Future<void> deleteCategory(int catId, String catName) async {
    final resp = await apiClient.delete(
      '/category/del',
      data: jsonEncode({"ID": catId, "category": catName}),
    );

    if (resp.statusCode != 200) {
      throw Exception("Failed to add category $catId, ${resp.data}");
    }
  }

  Future<List<(String, int)>> listCategory() async {
    final resp = await apiClient.get('/category/list');

    if (resp.statusCode != 200) {
      throw Exception("Failed to list category, ${resp.data}");
    }

    final tmp = resp.data as List<dynamic>;
    return tmp.map((e) => (e['category'] as String, e['ID'] as int)).toList();
  }
}
