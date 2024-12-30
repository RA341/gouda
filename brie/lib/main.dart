import 'package:brie/config.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/auth_page.dart';
import 'package:brie/ui/category_page.dart';
import 'package:brie/ui/components/sidebar.dart';
import 'package:brie/ui/history_page.dart';
import 'package:brie/ui/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await dotenv.load();
  await PreferencesService.init();

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
    ).animate().fadeIn(duration: 400.ms);
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
      HistoryPage(),
      CategoryPage(),
      SettingsPage(),
    ];

    final pageIndex = ref.watch(pageIndexListProvider);
    // call the settings now so that later pages can use it without going to
    // ref.watch(settingsProvider).value;

    return Row(
      children: [
        Sidebar(),
        Expanded(child: routeList[pageIndex]),
      ],
    );
  }
}
