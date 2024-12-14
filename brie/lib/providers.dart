import 'dart:io';

import 'package:brie/api.dart';
import 'package:brie/config.dart';
import 'package:brie/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

final settingsProvider = FutureProvider<Settings>((ref) async {
  return await api.settingsApi.list();
});

final categoryListProvider = FutureProvider<List<String>>((ref) async {
  return await api.categoryApi.listCategory();
});
