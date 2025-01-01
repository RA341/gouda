import 'dart:convert';

import 'package:brie/api/api.dart';
import 'package:brie/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsApiProvider = Provider<SettingsApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return SettingsApi(client);
});

class SettingsApi {
  final Dio apiClient;

  SettingsApi(this.apiClient);

  Future<void> update(Settings config) async {
    final response = await apiClient.post(
      '/settings/update',
      data: jsonEncode(config.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update config: ${response.statusCode}\nMessage: ${response.data}');
    }
  }

  Future<Settings> list() async {
    final response = await apiClient.get('/settings/retrieve');

    if (response.statusCode != 200) {
      throw Exception('Failed to get config: ${response.statusCode}');
    }

    final tmp = response.data as Map<String, dynamic>;
    return Settings.fromJson(tmp);
  }
}
