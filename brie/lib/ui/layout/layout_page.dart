import 'package:brie/env.dart';
import 'package:brie/ui/home/home_view.dart';
import 'package:brie/ui/layout/nav_model.dart';
import 'package:brie/ui/layout/navbar_mobile.dart';
import 'package:brie/ui/layout/navbar_vertical.dart';
import 'package:brie/ui/mam/ui_mam.dart';
import 'package:brie/ui/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageIndexProvider = NotifierProvider<PageIndexNotifier, int>(
  PageIndexNotifier.new,
);

class PageIndexNotifier extends Notifier<int> {
  @override
  int build() => Env.initialPage;

  void switchPage(int index) {
    state = index;
  }
}

const mobileWidth = 800;

bool isMobileView(BuildContext context) {
  return MediaQuery.of(context).size.width < mobileWidth;
}

class IsMobileView extends Notifier<bool> {
  @override
  bool build() => false;

  void desktopMode() {
    state = false;
  }

  void mobileMode() {
    state = true;
  }
}

class LayoutView extends ConsumerWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages = <NavModel>[
      const NavModel(
        iconData: Icons.home_outlined,
        selectedIconData: Icons.home_filled,
        label: 'Home',
        page: HomeView(),
      ),

      const NavModel(
        iconData: Icons.mouse,
        selectedIconData: Icons.mouse,
        label: 'Mam',
        page: MamView(),
      ),

      const NavModel(
        iconData: Icons.settings,
        selectedIconData: Icons.settings,
        label: 'Settings',
        page: SettingsView(),
      ),
    ];

    final pageIndex = ref.watch(pageIndexProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width > mobileWidth) {
          // desktop view
          return Scaffold(
            body: Row(
              children: [
                VerticalNavBar(navList: pages),
                Expanded(child: pages[pageIndex].page),
              ],
            ),
          );
        } else {
          // mobile view
          return SafeArea(
            child: Scaffold(
              body: pages[pageIndex].page,
              bottomNavigationBar: MobileNavbar(pageData: pages),
            ),
          );
        }
      },
    );
  }
}
