import 'package:brie/config.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/auth/auth_page.dart';
import 'package:brie/ui/category/category_page.dart';
import 'package:brie/ui/history/history_page.dart';
import 'package:brie/ui/mam/mam_page.dart';
import 'package:brie/ui/nav/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: const RootView(),
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
        data: (data) => data ? const MainView() : const LoginView(),
        error: (error, stackTrace) =>
            Center(
              child: Column(
                children: [
                  const Text('An error occurred'),
                  Text(error.toString()),
                  Text(stackTrace.toString()),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class MainView extends ConsumerWidget {
  const MainView({super.key});

  static const iconsSize = 30.0;

  static final List<(NavigationRailDestination destination, Widget page)>
  navItems = [
    (
    const NavigationRailDestination(
      icon: Icon(Icons.home_outlined, size: iconsSize),
      selectedIcon: Icon(Icons.home_filled, size: iconsSize),
      label: Text('Home'),
    ),
    const HistoryPage(),
    ),
    (
    const NavigationRailDestination(
      icon: Icon(Icons.book_outlined, size: iconsSize),
      selectedIcon: Icon(Icons.book, size: iconsSize),
      label: Text('Categories'),
    ),
    const CategoryPage(),
    ),
    (
    const NavigationRailDestination(
      icon: Icon(Icons.mouse, size: iconsSize),
      selectedIcon: Icon(Icons.mouse, size: iconsSize),
      label: Text('Mam'),
    ),
    const MamPage(),
    ),
    // TODO: settings is borken
    // (
    //   const NavigationRailDestination(
    //     icon: Icon(Icons.settings_outlined, size: iconsSize),
    //     selectedIcon: Icon(Icons.settings, size: iconsSize),
    //     label: Text('Settings'),
    //   ),
    //   const SettingsPage(),
    // ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        VerticalNavBar(destinations: navItems.map((item) => item.$1).toList()),
        MainPage(routeList: navItems.map((item) => item.$2).toList()),
      ],
    );

    // final setup = ref.watch(isSetupCompleteProvider);
    // return setup.when(
    //   data: (setupComplete) => setupComplete
    //       ? Row(children: [VerticalNavBar(), PageView()])
    //       : SetupPage(),
    //   error: (error, stackTrace) => Center(
    //     child: Column(
    //       children: [
    //         Text('An error occurred'),
    //         Text(error.toString()),
    //         Text(stackTrace.toString()),
    //       ],
    //     ),
    //   ),
    //   loading: () => Center(child: CircularProgressIndicator()),
    // );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({required this.routeList, super.key});

  final List<Widget> routeList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
