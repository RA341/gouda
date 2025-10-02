import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/ui/settings/provider.dart';
import 'package:brie/ui/settings/utils.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:brie/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabDownloader extends HookConsumerWidget {
  const TabDownloader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curConfig = ref.watch(serverConfigProvider).value!;
    final timeoutController = useTextEditingController(
      text: curConfig.downloader.timeout,
    );

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              flex: 5,
              child: SettingsField(
                controller: timeoutController,
                enabled: curConfig.downloader.ignoreTimeout,
                labelText: 'Download Timeout',
                helpText: 'Max time before downloads are considered failed',
                onChanged: (value) {
                  ref.serverUpdateConfig(
                    (prev) => prev..downloader.timeout = value,
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Switch(
                    value: curConfig.downloader.ignoreTimeout,
                    onChanged: (value) {
                      ref.serverUpdateConfig(
                            (prev) => prev..downloader.ignoreTimeout = value,
                      );
                    },
                  ),
                  Text(
                    curConfig.downloader.ignoreTimeout
                        ? "Check enabled"
                        : "Check disabled",
                  ),
                ],
              ),
            ),
          ],
        ),

        const Divider(),

        TorrentClientSettings(curConfig: curConfig),
      ],
    );
  }
}

final FutureProvider<List<String>> supportedClientProvider =
    FutureProvider.autoDispose<List<String>>((ref) async {
      final clients = await mustRunGrpcRequest(
        () => ref
            .watch(settingsApiProvider)
            .listSupportedClients(ListSupportedClientsRequest()),
      );

      return clients.clients.toList();
    });

class TorrentClientSettings extends HookConsumerWidget {
  const TorrentClientSettings({required this.curConfig, super.key});

  final GoudaConfig curConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supportedClients = ref.watch(supportedClientProvider);

    final curClient = curConfig.torrentClient;

    final hostController = useTextEditingController(text: curClient.host);
    final clientUsernameController = useTextEditingController(
      text: curClient.user,
    );
    final clientPasswordController = useTextEditingController(
      text: curClient.password,
    );

    return supportedClients.when(
      data: (data) => Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            value: curClient.clientType.orNull,
            hint: const Text('Select a client'),
            items: data
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              ref.serverUpdateConfig(
                (prev) => prev..torrentClient.clientType = value,
              );
            },
          ),
          Row(
            spacing: 5,
            children: [
              Expanded(
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButton<String>(
                        value: curClient.protocol,
                        hint: const Text('protocol'),
                        items: const [
                          DropdownMenuItem(
                            value: 'http',
                            child: Text('http://'),
                          ),
                          DropdownMenuItem(
                            value: 'https',
                            child: Text('https://'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }

                          ref.serverUpdateConfig(
                            (prev) => prev..torrentClient.protocol = value,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: TextField(
                        onChanged: (value) =>
                            ref.serverUpdateConfig(
                                  (con) => con..torrentClient.host = value,
                            ),
                        controller: hostController,
                        decoration: const InputDecoration(
                          label: Text("Host"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SettingsField(
            labelText: "Client username",
            controller: clientUsernameController,
            onChanged: (value) => ref.serverUpdateConfig(
              (con) => con..torrentClient.user = value,
            ),
          ),
          SettingsField(
            controller: clientPasswordController,
            labelText: "Client password",
            onChanged: (value) => ref.serverUpdateConfig(
              (con) => con..torrentClient.password = value,
            ),
          ),
        ],
      ),
      error: (error, stackTrace) => ErrorDisplay(message: error.toString()),
      loading: LoadingSpinner.new,
    );
  }
}
