import 'package:brie/config.dart';
import 'package:brie/ui/layout/layout_page.dart';
import 'package:brie/ui/layout/nav_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerticalNavBar extends ConsumerWidget {
  const VerticalNavBar({required this.navList, super.key});

  final List<NavModel> navList;

  static const iconsSize = 30.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    const labelType = NavigationRailLabelType.all;

    final navItems = navList
        .map(
          (item) => NavigationRailDestination(
            icon: Icon(item.iconData),
            label: Text(item.label),
            selectedIcon: Icon(
              item.selectedIconData ?? item.iconData,
              size: iconsSize,
            ),
          ),
        )
        .toList();

    return Column(
      children: [
        Expanded(
          child: NavigationRail(
            selectedIndex: pageIndex,
            groupAlignment: -0.955,
            onDestinationSelected: (int index) =>
                ref.read(pageIndexProvider.notifier).switchPage(index),
            labelType: labelType,
            // leading: GoudaHeader(),
            destinations: navItems,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: IconButton(
            onPressed: () async {
              await ref.read(appSettingsProvider.notifier).clearTokens();
            },
            icon: const Tooltip(
              message: 'Logout',
              child: Icon(Icons.logout, semanticLabel: 'Logout'),
            ),
          ),
        ),
      ],
    );
  }
}
