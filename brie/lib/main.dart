import 'package:brie/api.dart';
import 'package:brie/pages/category_page.dart';
import 'package:brie/pages/settings_page.dart';
import 'package:brie/pages/setup_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import 'config.dart';

var api = GoudaApi(basePath: '');

Future<void> main() async {
  await PreferencesService.init();

  // await prefs.remove('apikey');

  final path = prefs.getString('basepath') ??
      (kIsWeb ? html.window.location.toString() : '');
  final apikey = prefs.getString('apikey') ?? '';

  api = GoudaApi(basePath: path, apiKey: apikey);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gouda',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: api.apiKey.isEmpty ? LoginPage() : CategoryPage());
  }
}
