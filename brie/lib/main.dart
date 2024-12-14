import 'package:brie/api.dart';
import 'package:brie/components/sidebar.dart';
import 'package:brie/pages/category_page.dart';
import 'package:brie/pages/settings_page.dart';
import 'package:brie/pages/setup_page.dart';
import 'package:brie/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import 'config.dart';

Future<void> main() async {
  await PreferencesService.init();

  final apikey = prefs.getString('apikey') ?? '';

  api = GoudaApi(apiKey: apikey);

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
      home: RootView(),
    );
  }
}

class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testToken = ref.watch(checkTokenProvider);

    return testToken.when(
      data: (data) => data ? MainView() : LoginPage(),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('An error occurred'),
              Text(error.toString()),
              Text(stackTrace.toString()),
            ],
          ),
        ),
      ),
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Navigator(
              initialRoute: '/categories',
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;
                print(settings.name);
                switch (settings.name) {
                  case '/':
                  case '/categories':
                    builder = (ctx) => const CategoryPage();
                  case '/settings':
                    builder = (ctx) => const SettingsPage();
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }
                return MaterialPageRoute<void>(
                  builder: builder,
                  settings: settings,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
