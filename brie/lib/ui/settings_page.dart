import 'package:brie/clients/settings_api.dart';
import 'package:brie/config.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/components/utils.dart';
import 'package:fixnum/fixnum.dart';
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
    final userID = useTextEditingController(text: settings.userUid.toString());
    final groupID =
        useTextEditingController(text: settings.groupUid.toString());
    final torrentHost = useTextEditingController(text: settings.torrentHost);
    final clientType = useTextEditingController(text: settings.torrentName);
    final torrentPassword =
        useTextEditingController(text: settings.torrentPassword);
    final torrentProtocol =
        useTextEditingController(text: settings.torrentProtocol);
    final torrentUser = useTextEditingController(text: settings.torrentUser);
    final exitOnClose = useState(settings.exitOnClose);
    final ignoreTimeout = useState(settings.ignoreTimeout);

    // some extra info
    final supportedClients = ref.watch(supportedClientsProvider).value;
    final metadata = ref.watch(metadataProvider).value;

    return SingleChildScrollView(
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Settings', style: headerStyle),
          boxDivider,
          Text('General', style: headerStyle),
          lineDivider,
          SizedBox(
            width: 700,
            child: ApiCopyField(apiKey: apiKey),
          ),
          boxDivider,
          createUpdateButtons2('Server Port', serverPort),
          createUpdateButtons2(
            'Download Check timeout (In minutes)',
            downloadCheckTimeout,
          ),
          Text('Ignore timeout check'),
          SizedBox(width: 20),
          Switch(
            value: ignoreTimeout.value,
            onChanged: (value) => ignoreTimeout.value = value,
          ),
          if (metadata?.binaryType == "desktop")
            Row(
              children: [
                Text('Exit application on close'),
                SizedBox(width: 20),
                Switch(
                  value: exitOnClose.value,
                  onChanged: (value) => exitOnClose.value = value,
                ),
              ],
            ),
          Text('Torrent Client', style: headerStyle),
          lineDivider,
          Row(
            spacing: 10,
            children: [
              createDropDown2(
                supportedClients ?? [],
                clientType,
                "Torrent Client Type",
              ),
              createDropDown2(
                supportedProtocols,
                torrentProtocol,
                "Torrent Client Protocol",
              ),
              Expanded(
                child: createUpdateButtons2('Torrent Host', torrentHost,
                    hintText: 'localhost:8080 or qbit.eg.com'),
              ),
            ],
          ),
          boxDivider,
          createUpdateButtons2(
            'Torrent Username',
            torrentUser,
            autofillHints: [AutofillHints.username],
          ),
          boxDivider,
          createUpdateButtons2(
            'Torrent Password',
            torrentPassword,
            autofillHints: [AutofillHints.password],
          ),
          boxDivider,
          Text('User Settings', style: headerStyle),
          boxDivider,
          createUpdateButtons('Username', username),
          boxDivider,
          createUpdateButtons('Password', password),
          boxDivider,
          createUpdateButtons('Linux UID', userID),
          boxDivider,
          createUpdateButtons('Linux GID', groupID),
          boxDivider,
          Text('Folder Settings', style: headerStyle),
          lineDivider,
          createUpdateButtons('Complete Folder', completeFolder),
          boxDivider,
          createUpdateButtons('Download Folder', downloadFolder),
          boxDivider,
          createUpdateButtons('Torrents folder', torrentsFolder),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: ElevatedButton(
                onPressed: () async {
                  try {
                    await ref.watch(settingsApiProvider).update(
                          Settings()
                            ..apiKey = apiKey.text
                            ..serverPort = serverPort.text
                            ..downloadCheckTimeout =
                                Int64.parseInt(downloadCheckTimeout.text)
                            ..completeFolder = completeFolder.text
                            ..downloadFolder = downloadFolder.text
                            ..torrentsFolder = torrentsFolder.text
                            ..username = username.text
                            ..password = password.text
                            ..userUid = Int64.parseInt(userID.text)
                            ..groupUid = Int64.parseInt(groupID.text)
                            ..torrentHost = torrentHost.text
                            ..torrentName = clientType.text
                            ..torrentPassword = torrentPassword.text
                            ..torrentProtocol = torrentProtocol.text
                            ..torrentUser = torrentUser.text
                            ..exitOnClose = exitOnClose.value
                            ..ignoreTimeout = ignoreTimeout.value,
                        );

                    ref.invalidate(settingsProvider);
                    if (!context.mounted) return;
                    showSnackBar(context, 'Updated settings');
                  } catch (e) {
                    if (!context.mounted) return;
                    showErrorDialog(
                      context,
                      'Error saving settings',
                      '',
                      e.toString(),
                    );
                  }
                },
                child: Text('Update Settings')),
          )
        ],
      ),
    );
  }

  Widget createUpdateButtons(
    String input,
    TextEditingController controller, {
    void Function()? editingController,
  }) {
    return TextField(
      controller: controller,
      onEditingComplete: editingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: input,
      ),
    );
  }
}

class ApiCopyField extends StatelessWidget {
  const ApiCopyField({super.key, required this.apiKey});

  final TextEditingController apiKey;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'API key', // or
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
          ),
          controller: apiKey,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: apiKey.text));

          if (!context.mounted) return;
          showSnackBar(context, 'copied API key');
        },
        icon: Icon(Icons.copy, color: Colors.white),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ),
  );
}

const lineDivider = Padding(
  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
  child: Divider(thickness: 5),
);

const boxDivider = SizedBox(height: 20);
