import 'package:brie/api.dart';
import 'package:brie/components/sidebar.dart';
import 'package:brie/pages/category_page.dart';
import 'package:brie/pages/settings_page.dart';
import 'package:brie/pages/setup_page.dart';
import 'package:brie/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
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

    return Scaffold(
      body: testToken.when(
        data: (data) => data ? MainView() : LoginPage(),
        error: (error, stackTrace) => Center(
          child: Column(
            children: [
              Text('An error occurred'),
              Text(error.toString()),
              Text(stackTrace.toString()),
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const routeList = [
      CategoryPage(),
      SettingsPage(),
    ];

    final pageIndex = ref.watch(pageIndexListProvider);

    return Row(
      children: [
        Sidebar(),
        Expanded(child: routeList[pageIndex]),
      ],
    );
  }
}
