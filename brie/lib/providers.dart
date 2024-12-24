import 'package:brie/api/auth_api.dart';
import 'package:brie/api/category_api.dart';
import 'package:brie/api/history_api.dart';
import 'package:brie/api/settings_api.dart';
import 'package:brie/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import 'models.dart';

final basePathProvider = StateProvider<String>((ref) {
  if (kIsWeb) {
    return html.window.location.toString();
  }
  return '';
});

final checkTokenProvider = FutureProvider<bool>((ref) async {
  final token = (prefs.get('apikey') ?? "").toString();
  return authApi.testToken(token: token);
});

final pageIndexListProvider = StateProvider<int>((ref) {
  return 0;
});

final settingsProvider = FutureProvider<Settings>((ref) async {
  return await settingsApi.list();
});

final categoryListProvider = FutureProvider<List<(String, int)>>((ref) async {
  return await catApi.listCategory();
});

final requestHistoryProvider = FutureProvider<List<Book>>((ref) async {
  return histApi.getTorrentHistory();
});
