import 'package:brie/ui/settings/model.dart';
import 'package:brie/ui/settings/provider.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableLink {
  const ClickableLink({
    required this.text,
    required this.url,
  });

  final String text;
  final String url;
}

class SettingsField extends StatelessWidget {
  const SettingsField({
    required this.controller,
    required this.labelText,
    this.onChanged,
    this.helpText,
    this.clickableLinks,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String labelText;
  final String? helpText;
  final List<ClickableLink>? clickableLinks;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          enabled: enabled,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            label: Text(labelText),
            border: const OutlineInputBorder(),
          ),
        ),
        if (helpText != null || clickableLinks != null) ...[
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info, size: 16),
              const SizedBox(width: 5),
              Expanded(
                child: _buildHelpText(context),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildHelpText(BuildContext context) {
    if (clickableLinks == null || clickableLinks!.isEmpty) {
      return Text(
        helpText ?? "",
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    final spans = <TextSpan>[];
    var remainingText = helpText ?? "";

    for (final link in clickableLinks!) {
      final index = remainingText.indexOf(link.text);
      if (index != -1) {
        // Add text before the link
        if (index > 0) {
          spans.add(
            TextSpan(
              text: remainingText.substring(0, index),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }

        // Add the clickable link
        spans.add(
          TextSpan(
            text: link.text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchUrl(link.url),
          ),
        );

        // Update remaining text
        remainingText = remainingText.substring(index + link.text.length);
      }
    }

    // Add any remaining text
    if (remainingText.isNotEmpty) {
      spans.add(
        TextSpan(
          text: remainingText,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

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
        skipLoadingOnReload: true,
        data: (data) => child,
        error: (error, stackTrace) {
          return Align(
            child: ErrorDisplay(message: error.toString()),
          );
        },
        loading: LoadingSpinner.new,
      ),
    );
  }
}
