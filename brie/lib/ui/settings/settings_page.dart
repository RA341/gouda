import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/settings/settings_widgets.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:brie/ui/shared/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const headerStyle = TextStyle(fontSize: 28);
const maxSettingsWidth = 300.0;

final tabIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSettings = ref.watch(settingsProvider);

    return currentSettings.when(
      data: (data) => SettingsContainer(settings: data),
      error: (error, stackTrace) => Center(
        child: Column(
          children: [
            const Text('Error', style: TextStyle(fontSize: 30)),
            Text(error.toString()),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class SettingsContainer extends HookConsumerWidget {
  const SettingsContainer({super.key, required this.settings});

  final Settings settings;

  @override
  Widget build(BuildContext context, ref) {
    final settingsObj = useState(Settings());
    final settings = ref.watch(settingsProvider).value!;
    final curSettings = useState(settings);

    final tabs = <String, Widget>{
      "General": GeneralGroup(settings: curSettings),
      "Torrent Client": TorrentGroup(settings: curSettings),
      "Folders": FolderGroup(settings: curSettings),
      "User": UserGroup(settings: curSettings),
    };

    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        children: [
          ...pageHeaderBuilder(
            header: "Settings",
            subHeading:
                'Configure your application settings. Changes will be applied after saving.',
          ),
          const SizedBox(height: 35),
          SettingsTabs(
            tabs: tabs.keys
                .map(
                  (e) => Tab(
                    text: e,
                    icon:
                        e == 'Torrent Client' &&
                            (curSettings.value.client.torrentHost.isEmpty ||
                                curSettings.value.client.torrentName.isEmpty ||
                                curSettings
                                    .value
                                    .client
                                    .torrentPassword
                                    .isEmpty)
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          SettingsDisplay(
            settings: settingsObj,
            settingsGroup: tabs.values.toList(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await ref
                      .watch(settingsApiProvider)
                      .update(curSettings.value);
                  ref.invalidate(settingsProvider);
                  if (!context.mounted) return;
                  showSnackBar(context, 'Updated settings');
                } catch (e) {
                  if (!context.mounted) return;
                  showErrorDialog(
                    context,
                    'Error saving settings',
                    '',
                    errorMessage: e.toString(),
                  );
                }
              },
              child: const Text('Update Settings'),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsTabs extends HookConsumerWidget {
  const SettingsTabs({required this.tabs, super.key});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context, ref) {
    final controller = useTabController(initialLength: tabs.length);
    controller.index = ref.watch(tabIndexProvider);
    return TabBar(
      tabs: tabs,
      onTap: (value) => ref.read(tabIndexProvider.notifier).state = value,
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.fill,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: Theme.of(context).focusColor,
        // backgroundBlendMode: BlendMode.darken,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      controller: controller,
    );
  }
}

class SettingsDisplay extends HookConsumerWidget {
  const SettingsDisplay({
    required this.settings,
    required this.settingsGroup,
    super.key,
  });

  final ValueNotifier<Settings> settings;

  final List<Widget> settingsGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabIndexProvider);
    return settingsGroup[tabIndex];
  }
}

class ApiCopyField extends StatelessWidget {
  const ApiCopyField({super.key, required this.apiKey});

  final TextEditingController apiKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(
          child: TextField(
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
            controller: apiKey,
          ),
        ),
        IconButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: apiKey.text));
            if (!context.mounted) return;
            showSnackBar(context, 'copied API key');
          },
          icon: const Icon(Icons.copy, color: Colors.white),
        ),
      ],
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
  );
}
