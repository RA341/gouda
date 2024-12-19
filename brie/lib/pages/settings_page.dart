import 'package:brie/api.dart';
import 'package:brie/models.dart';
import 'package:brie/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSettings = ref.watch(settingsProvider);

    return currentSettings.when(
      data: (data) => SettingsView(settings: data),
      error: (error, stackTrace) => Center(
        child: Column(
          children: [
            Text('Error', style: TextStyle(fontSize: 30)),
            Text(error.toString())
          ],
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

const headerStyle = TextStyle(fontSize: 28);
const maxSettingsWidth = 300.0;

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key, required this.settings});

  final Settings settings;

  @override
  Widget build(BuildContext context, ref) {
    final apiKey = useTextEditingController(text: settings.apiKey);
    final serverPort = useTextEditingController(text: settings.serverPort);
    final downloadCheckTimeout = useTextEditingController(
        text: settings.downloadCheckTimeout.toString());
    final completeFolder =
        useTextEditingController(text: settings.completeFolder);
    final downloadFolder =
        useTextEditingController(text: settings.downloadFolder);
    final torrentsFolder =
        useTextEditingController(text: settings.torrentsFolder);
    final username = useTextEditingController(text: settings.username);
    final password = useTextEditingController(text: settings.password);
    final userID = useTextEditingController(text: settings.userID.toString());
    final groupID = useTextEditingController(text: settings.groupID.toString());
    final torrentHost = useTextEditingController(text: settings.torrentHost);
    final clientType = useTextEditingController(text: settings.torrentName);
    final torrentPassword =
        useTextEditingController(text: settings.torrentPassword);
    final torrentProtocol =
        useTextEditingController(text: settings.torrentProtocol);
    final torrentUser = useTextEditingController(text: settings.torrentUser);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('General', style: headerStyle),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(thickness: 4),
            ),
            SizedBox(
              // width: maxSettingsWidth,
              child: ListTile(
                title: Container(
                  decoration: ShapeDecoration(
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      apiKey.text,
                      style: TextStyle(overflow: TextOverflow.clip),
                    ),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: apiKey.text));

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Apikey copied'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  icon: Icon(Icons.copy, color: Colors.white),
                ),
              ),
            ),
            createUpdateButtons('Server Port', serverPort),
            createUpdateButtons(
              'Download Check timeout (In minutes)',
              downloadCheckTimeout,
            ),
            Text('Torrent Client', style: headerStyle),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(thickness: 4),
            ),
            createDropDown(
              ["transmission", "qbit"],
              clientType,
              "Torrent Client Type",
            ),
            createDropDown(
              ["http", "https"],
              torrentProtocol,
              "Torrent Client Protocol",
            ),
            createUpdateButtons('Torrent Host', torrentHost),
            createUpdateButtons('Torrent Username', torrentUser),
            createUpdateButtons('Torrent Password', torrentPassword),
            Text('User Settings', style: headerStyle),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(thickness: 4),
            ),
            createUpdateButtons('Username', username),
            createUpdateButtons('Password', password),
            createUpdateButtons('Linux UID', userID),
            createUpdateButtons('Linux GID', groupID),
            Text('Folder Settings', style: headerStyle),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(thickness: 4),
            ),
            createUpdateButtons('Complete Folder', completeFolder),
            createUpdateButtons('Download Folder', downloadFolder),
            createUpdateButtons('Torrents folder', torrentsFolder),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await api.settingsApi.update(
                        Settings(
                          apiKey: apiKey.text,
                          serverPort: serverPort.text,
                          downloadCheckTimeout:
                              int.parse(downloadCheckTimeout.text),
                          completeFolder: completeFolder.text,
                          downloadFolder: downloadFolder.text,
                          torrentsFolder: torrentsFolder.text,
                          username: username.text,
                          password: password.text,
                          userID: int.parse(userID.text),
                          groupID: int.parse(groupID.text),
                          torrentHost: torrentHost.text,
                          torrentName: clientType.text,
                          torrentPassword: torrentPassword.text,
                          torrentProtocol: torrentProtocol.text,
                          torrentUser: torrentUser.text,
                        ),
                      );

                      ref.invalidate(settingsProvider);
                    } catch (e) {
                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        builder: (context) => Column(
                          children: [
                            Text(
                              'Error updating settings',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(e.toString())
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Update Settings')),
            )
          ],
        ),
      ),
    );
  }

  Widget createDropDown(
    List<String> options,
    TextEditingController controller,
    String label,
  ) {
    final selectedIndex = options.indexOf(controller.text);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(label),
          SizedBox(width: 20),
          DropdownMenu<String>(
            initialSelection: options[selectedIndex == -1 ? 0 : selectedIndex],
            onSelected: (String? value) =>
                controller.text = value ?? options.first,
            dropdownMenuEntries:
                options.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget createUpdateButtons(
    String input,
    TextEditingController controller, {
    void Function()? editingController,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        // width: maxSettingsWidth,
        child: TextField(
          controller: controller,
          onEditingComplete: editingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: input,
          ),
        ),
      ),
    );
  }
}
