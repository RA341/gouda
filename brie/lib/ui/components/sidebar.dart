import 'package:brie/config.dart';
import 'package:brie/grpc/api.dart';
import 'package:brie/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerticalNavBar extends ConsumerWidget {
  const VerticalNavBar({super.key});

  static const iconsSize = 30.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexListProvider);
    final labelType = NavigationRailLabelType.all;

    return Column(
      children: [
        Expanded(
          child: NavigationRail(
            selectedIndex: pageIndex,
            groupAlignment: -0.955,
            onDestinationSelected: (int index) =>
                ref.read(pageIndexListProvider.notifier).navigateToPage(index),
            labelType: labelType,
            // leading: GoudaHeader(),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined, size: iconsSize),
                selectedIcon: Icon(Icons.home_filled, size: iconsSize),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book_outlined, size: iconsSize),
                selectedIcon: Icon(Icons.book, size: iconsSize),
                label: Text('Categories'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined, size: iconsSize),
                selectedIcon: Icon(Icons.settings, size: iconsSize),
                label: Text('Settings'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: IconButton(
            onPressed: () async {
              await prefs.setString('apikey', '');
              ref.invalidate(apiTokenProvider);
            },
            icon: Tooltip(
              message: 'Logout',
              child: Icon(
                Icons.logout,
                semanticLabel: 'Logout',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GoudaHeader extends StatelessWidget {
  const GoudaHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.gamepad_outlined,
      size: 45,
    );
  }
}
