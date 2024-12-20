import 'package:brie/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  static const buttonDivider = 18.0;
  static const activeButtonColor = Color(0xFF2B592B);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexListProvider);

    return ColoredBox(
      color: Theme.of(context).colorScheme.onSecondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: buttonDivider),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF207722),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 25,
                  ),
                  child: Text('Gouda'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: buttonDivider),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: pageIndex == 0 ? activeButtonColor : null,
                ),
                child: Text(
                  'History',
                ),
                onPressed: () async {
                  ref.read(pageIndexListProvider.notifier).state = 0;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: buttonDivider),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: pageIndex == 1 ? activeButtonColor : null,
                ),
                child: Text(
                  'Categories',
                ),
                onPressed: () async {
                  ref.read(pageIndexListProvider.notifier).state = 1;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: buttonDivider),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: pageIndex == 2 ? activeButtonColor : null,
                ),
                child: Text('Settings'),
                onPressed: () async {
                  ref.read(pageIndexListProvider.notifier).state = 2;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
