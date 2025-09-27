import 'package:brie/clients/auth_api.dart';
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

    return ColoredBox(
      color: Theme
          .of(context)
          .hoverColor,
      child: Column(
        children: [
          Expanded(
            child: NavigationRail(
              backgroundColor: Colors.transparent,
              selectedIndex: pageIndex,
              groupAlignment: -0.955,
              onDestinationSelected: (int index) =>
                  ref.read(pageIndexProvider.notifier).switchPage(index),
              labelType: labelType,
              leading: const GoudaHeader(),
              destinations: navItems,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: IconButton(
              onPressed: () async => logout(ref),
              icon: const Tooltip(
                message: 'Logout',
                child: Icon(Icons.logout, semanticLabel: 'Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoudaHeader extends ConsumerWidget {
  const GoudaHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {
          ref.read(pageIndexProvider.notifier).switchPage(0);
        },
        icon: Image.asset(
          'assets/gouda.png',
          scale: 11,
        ),
      ),
    );
  }
}
