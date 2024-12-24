import 'dart:convert';

import 'package:brie/api/api.dart';
import 'package:brie/models.dart';

final settingsApi = SettingsApi();

class SettingsApi {
  Future<void> update(Settings config) async {
    final response = await apiClient.post(
      '/settings/update',
      data: jsonEncode(config.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update config: ${response.statusCode}');
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
