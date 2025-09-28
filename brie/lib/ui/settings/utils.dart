import 'package:brie/ui/settings/model.dart';
import 'package:brie/ui/settings/provider.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsActionBar extends ConsumerWidget {
  const SettingsActionBar({required this.config, super.key});

  final SettingsPageConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 10,
          children: config.buttons,
        ),
      ),
    );
  }
}

class IconLabelButton extends ConsumerWidget {
  const IconLabelButton({
    required this.onTap,
    required this.icon,
    required this.label,
    this.isRefreshing = false,
    super.key,
  });

  final bool isRefreshing;
  final void Function() onTap;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    return InkWell(
      onTap: isRefreshing ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isRefreshing ? iconColor?.withAlpha(30) : iconColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isRefreshing ? iconColor?.withAlpha(30) : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServerSettingsView extends ConsumerWidget {
  const ServerSettingsView({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(serverConfigProvider);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: config.when(
        data: (data) => child,
        error: (error, stackTrace) => Align(
          child: ErrorDisplay(message: error.toString()),
        ),
        loading: LoadingSpinner.new,
      ),
    );
  }
}
