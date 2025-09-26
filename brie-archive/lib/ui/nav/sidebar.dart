import 'package:brie/config.dart';
import 'package:brie/grpc/api.dart';
import 'package:brie/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerticalNavBar extends ConsumerWidget {
  const VerticalNavBar({required this.destinations, super.key});

  final List<NavigationRailDestination> destinations;

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
            destinations: destinations,
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
              child: Icon(Icons.logout, semanticLabel: 'Logout'),
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
    return const Icon(Icons.gamepad_outlined, size: 45);
  }
}
