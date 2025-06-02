import 'package:brie/config.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/auth_page.dart';
import 'package:brie/ui/category_page.dart';
import 'package:brie/ui/components/sidebar.dart';
import 'package:brie/ui/history_page.dart';
import 'package:brie/ui/settings_page.dart';
import 'package:brie/ui/setup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await PreferencesService.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gouda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
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
    final setup = ref.watch(isSetupCompleteProvider);

    return setup.when(
      data: (setupComplete) => setupComplete
          ? Row(
              children: [
                VerticalNavBar(),
                PageView(),
              ],
            )
          : SetupPage(),
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
    );
  }
}

class PageView extends ConsumerWidget {
  const PageView({super.key});

  static const routeList = [
    HistoryPage(),
    CategoryPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context, ref) {
    final pageIndex = ref.watch(pageIndexListProvider);

    return Flexible(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: routeList[pageIndex].animate().fadeIn(duration: 200.ms),
          ),
        ),
      ),
    );
  }
}
