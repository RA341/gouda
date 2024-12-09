import 'dart:convert';

import 'package:brie/config.dart';
import 'package:brie/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';
import 'models.dart';

class GoudaApi {
  late String basePath;

  String apiKey = '';

  late CategoryApi categoryApi;
  late SettingsApi settingsApi;

  GoudaApi({
    required this.basePath,
    this.apiKey = '',
  }) {
    categoryApi = CategoryApi(
      baseUrl: basePath,
      defaultHeader: defaultHeaders(),
    );

    settingsApi = SettingsApi(
      baseUrl: basePath,
      defaultHeader: defaultHeaders(),
    );
  }

  Map<String, String> defaultHeaders({Map<String, String>? input1}) {
    var input = input1 ?? <String, String>{};

    if (apiKey != "") {
      input['Authorization'] = apiKey;
    }

    return input;
  }

  void updateClients() {
    categoryApi = CategoryApi(
      baseUrl: basePath,
      defaultHeader: defaultHeaders(),
    );

    settingsApi = SettingsApi(
      baseUrl: basePath,
      defaultHeader: defaultHeaders(),
    );
  }

  Future<void> login(
    BuildContext ctx, {
    required String user,
    required String pass,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$basePath/auth/login'),
        headers: defaultHeaders(),
        body: jsonEncode({"username": user, "password": pass}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load users: ${response.statusCode}');
      }

      apiKey = jsonDecode(response.body)['token'];
      await prefs.setString('apikey', apiKey);

      updateClients();

      if (!ctx.mounted) return;
      await Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
          builder: (context) => SettingsPage(),
        ),
      );
    } catch (e) {
      throw Exception('Error occurred while logging in: $e');
    }
  }

  // Add Torrent Client
  Future<void> addTorrentClient(TorrentClient client) async {
    try {
      final response = await http.post(
        Uri.parse('$basePath/torrents/addTorrentClient'),
        headers: defaultHeaders(),
        body: jsonEncode(client.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add torrent client: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding torrent client: $e');
    }
  }

  // Get Torrent Client
  Future<TorrentClient> getTorrentClient() async {
    try {
      final response = await http.get(
        Uri.parse('$basePath/torrents/torrentclient'),
        headers: defaultHeaders(),
      );

      if (response.statusCode == 200) {
        return TorrentClient.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get torrent client: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting torrent client: $e');
    }
  }

  // Add Torrent
  Future<void> addTorrent(TorrentRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$basePath/torrents/addTorrent'),
        headers: defaultHeaders(),
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add torrent: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding torrent: $e');
    }
  }
}

class CategoryApi {
  final Map<String, String> defaultHeader;
  final String baseUrl;

  CategoryApi({required this.defaultHeader, required this.baseUrl});

  Future<void> addCategory(String cat) async {
    final resp = await http.post(
      Uri.parse('$baseUrl/category/add'),
      body: jsonEncode({"category": cat}),
      headers: defaultHeader,
    );

    if (resp.statusCode != 200) {
      throw Exception("Failed to add category $cat, ${resp.body}");
    }
  }

  Future<void> deleteCategory(String cat) async {
    final resp = await http.delete(
      Uri.parse('$baseUrl/category/del'),
      body: jsonEncode({"category": cat}),
      headers: defaultHeader,
    );

    if (resp.statusCode != 200) {
      throw Exception("Failed to add category $cat, ${resp.body}");
    }
  }

  Future<List<String>> listCategory() async {
    final resp = await http.get(
      Uri.parse('$baseUrl/category/list'),
      headers: defaultHeader,
    );

    if (resp.statusCode != 200) {
      throw Exception("Failed to list category, ${resp.body}");
    }

    final tmp = (jsonDecode(resp.body) as Map<String, dynamic>)['categories']
        as List<dynamic>;
    return tmp.map((e) => e.toString()).toList();
  }
}

class SettingsApi {
  final Map<String, String> defaultHeader;
  final String baseUrl;

  SettingsApi({required this.defaultHeader, required this.baseUrl});

  Future<void> update(Settings config) async {
    final response = await http.post(
      Uri.parse('$baseUrl/settings/update'),
      headers: defaultHeader,
      body: jsonEncode(config.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update config: ${response.statusCode}');
    }
  }

  Future<Settings> list() async {
    final response = await http.get(
      Uri.parse('$baseUrl/settings/retrieve'),
      headers: defaultHeader,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get config: ${response.statusCode}');
    }

    final tmp = jsonDecode(response.body) as Map<String, dynamic>;
    return Settings.fromJson(tmp);
  }
}
