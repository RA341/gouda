import 'package:brie/api.dart';
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
  print('Token');
  print(token);
  return api.testToken(token: token);
});

final pageIndexListProvider = StateProvider<int>((ref) {
  return 0;
});

final settingsProvider = FutureProvider<Settings>((ref) async {
  return await api.settingsApi.list();
});

final categoryListProvider = FutureProvider<List<String>>((ref) async {
  return await api.categoryApi.listCategory();
});
