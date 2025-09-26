import 'package:brie/ui/layout/layout_page.dart';
import 'package:brie/ui/layout/nav_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileNavbar extends ConsumerWidget {
  const MobileNavbar({required this.pageData, super.key});

  final List<NavModel> pageData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    final navItems = pageData
        .map(
          (item) => NavigationDestination(
            icon: Icon(item.iconData),
            label: item.label,
            selectedIcon: Icon(
              item.selectedIconData ?? item.iconData,
              // size: iconsSize,
            ),
          ),
        )
        .toList();

    return NavigationBar(
      // elevation: 0,
      // height: 20,
      selectedIndex: pageIndex,
      onDestinationSelected: (int index) =>
          ref.read(pageIndexProvider.notifier).switchPage(index),
      destinations: navItems,
    );
  }
}
