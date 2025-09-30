import 'package:brie/ui/settings/provider.dart';
import 'package:brie/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class TabMam extends HookConsumerWidget {
  const TabMam({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(serverConfigProvider).value!;
    final mamController = useTextEditingController(text: config.mamToken);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  spacing: 7,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: mamController,
                      onChanged: (value) {
                        ref
                            .read(serverConfigProvider.notifier)
                            .updateConfigField(
                              (existingConfig) =>
                                  existingConfig..mamToken = value,
                            );
                      },
                      decoration: const InputDecoration(
                        label: Text("Mam token"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.info),
                        const Text("Authentication token for Mam"),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () async {
                              final url = Uri.parse(
                                'https://www.myanonamouse.net/preferences/index.php?view=security',
                              );
                              if (!await launchUrl(url)) {
                                logger.w('Could not launch $url');
                              }
                            },
                            child: const Text('Generate token'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
