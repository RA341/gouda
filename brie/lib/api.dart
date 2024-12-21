import 'dart:convert';

import 'package:brie/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models.dart';
import 'package:universal_html/html.dart' as html;

var api = GoudaApi();

class GoudaApi {
  late String basePath;

  String apiKey = '';

  late CategoryApi categoryApi;
  late SettingsApi settingsApi;
  late HistoryApi historyApi;

  GoudaApi({
    this.apiKey = '',
  }) {
    final (apiBasePath, basePath) = makeBasePath();
    this.basePath = basePath;
    updateClients();
  }

  (String, String) makeBasePath() {
    basePath = kDebugMode
        ? ('http://localhost:9862')
        : html.window.location.toString();

    basePath = basePath.endsWith('/')
        ? basePath.substring(0, basePath.length - 1)
        : basePath;

    return ('$basePath/api', basePath);
  }

  Map<String, String> defaultHeaders({Map<String, String>? input1}) {
    var input = input1 ?? <String, String>{};

    if (apiKey != "") {
      input['Authorization'] = apiKey;
    }

    return input;
  }

  void updateClients() {
    final (apiBasePath, _) = makeBasePath();

    categoryApi = CategoryApi(
      baseUrl: apiBasePath,
      defaultHeader: defaultHeaders(),
    );

    settingsApi = SettingsApi(
      baseUrl: apiBasePath,
      defaultHeader: defaultHeaders(),
    );

    historyApi = HistoryApi(
      defaultHeader: defaultHeaders(),
      baseUrl: apiBasePath,
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
    } catch (e) {
      throw Exception('Error occurred while logging in: $e');
    }
  }

  Future<bool> testToken({required String token}) async {
    if (token == '') {
      return false;
    }

    final response = await http.get(
      Uri.parse('$basePath/auth/test'),
      headers: defaultHeaders(),
    );

    if (response.statusCode != 200) {
      print('Failed to verify token: ${response.statusCode}');
      return false;
    }

    return true;
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

  Future<void> deleteCategory(int catId, String catName) async {
    final resp = await http.delete(
      Uri.parse('$baseUrl/category/del'),
      body: jsonEncode({"ID": catId, "category": catName}),
      headers: defaultHeader,
    );

    if (resp.statusCode != 200) {
      throw Exception("Failed to add category $catId, ${resp.body}");
    }
  }

  Future<List<(String, int)>> listCategory() async {
    final resp = await http.get(
      Uri.parse('$baseUrl/category/list'),
      headers: defaultHeader,
    );

    if (resp.statusCode != 200) {
      throw Exception("Failed to list category, ${resp.body}");
    }

    final tmp = (jsonDecode(resp.body) as List<dynamic>);
    return tmp.map((e) => (e['category'] as String, e['ID'] as int)).toList();
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

class HistoryApi {
  final Map<String, String> defaultHeader;
  final String baseUrl;

  HistoryApi({required this.defaultHeader, required this.baseUrl});

  Future<List<Book>> getTorrentHistory() async {
    final response = await http.get(
      Uri.parse('$baseUrl/history/all'),
      headers: defaultHeader,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get history: ${response.statusCode}');
    }

    final tmp = jsonDecode(response.body) as List<dynamic>;
    final res = tmp.map((e) => Book.fromJson(e)).toList();
    return res;
  }

  Future<void> retryBookRequest(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/history/retry/$id'),
      headers: defaultHeader,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed retry: ${response.statusCode}');
    }
  }
}
