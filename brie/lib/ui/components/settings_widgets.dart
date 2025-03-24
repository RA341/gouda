import 'package:brie/config.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/components/utils.dart';
import 'package:brie/ui/settings_page.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const settingsSpacing = 26.0;

class BaseSettingsGroup extends HookConsumerWidget {
  const BaseSettingsGroup({required this.settings, super.key});

  Settings get value => settings.value;

  final ValueNotifier<Settings> settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    throw UnimplementedError();
  }
}

class GeneralGroup extends BaseSettingsGroup {
  const GeneralGroup({super.key, required super.settings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metadata = ref.watch(metadataProvider).value;

    final apiKey = useTextEditingController(text: value.apiKey);
    final serverPort = useTextEditingController(text: value.serverPort);
    final exitOnClose = useState(value.exitOnClose);
    final ignoreTimeout = useState(value.ignoreTimeout);
    final downloadCheckTimeout =
        useTextEditingController(text: value.downloadCheckTimeout.toString());

    return Column(
      spacing: settingsSpacing,
      children: [
        SettingField(
          titleText: 'API Key',
          helpText:
              'Used to call the Gouda API, used by the Parmesan extension',
          child: ApiCopyField(apiKey: apiKey),
        ),
        SettingField(
          titleText: 'Server port',
          helpText: 'The port number the server listens on, Requires Restart',
          child: createUpdateButtons(
            serverPort,
            onChanged: (p0) => settings.value.serverPort = p0,
          ),
        ),
        SettingField(
          titleText: 'Download Check Timeout (In minutes)',
          helpText:
              'Time until gouda will monitor the download before stopping check, if ignore timeout check is enabled gouda will monitor until the download is completed',
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: createUpdateButtons(
                  downloadCheckTimeout,
                  enabled: !ignoreTimeout.value,
                  onChanged: (p0) =>
                      value.downloadCheckTimeout = Int64.parseInt(p0),
                ),
              ),
              SizedBox(width: 30),
              Row(
                children: [
                  Text('Ignore timeout'),
                  SizedBox(width: 20),
                  Switch(
                    value: ignoreTimeout.value,
                    onChanged: (ch) {
                      ignoreTimeout.value = ch;
                      value.ignoreTimeout = ch;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        if (metadata?.binaryType == "desktop")
          SettingField(
            titleText: 'Exit application on close',
            helpText: 'Exists the gouda process on closing the window',
            child: Row(
              children: [
                Switch(
                  value: exitOnClose.value,
                  onChanged: (ch) {
                    exitOnClose.value = ch;
                    value.exitOnClose = ch;
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class FolderGroup extends BaseSettingsGroup {
  const FolderGroup({super.key, required super.settings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completeFolder = useTextEditingController(text: value.completeFolder);
    final downloadFolder = useTextEditingController(text: value.downloadFolder);
    final torrentsFolder = useTextEditingController(text: value.torrentsFolder);

    return Column(
      spacing: settingsSpacing,
      children: [
        SettingField(
          titleText: 'Complete Folder',
          helpText: 'Path where completed downloads are moved',
          child: createUpdateButtons(
            completeFolder,
            onChanged: (p0) => value.completeFolder = p0,
          ),
        ),
        SettingField(
          titleText: 'Download Folder',
          helpText: 'Path where raw downloads are stored',
          child: createUpdateButtons(
            downloadFolder,
            onChanged: (p0) => value.downloadFolder = p0,
          ),
        ),
        SettingField(
          titleText: 'Torrents Folder',
          helpText: 'Path where torrent files are stored',
          child: createUpdateButtons(
            torrentsFolder,
            onChanged: (p0) => value.torrentsFolder = p0,
          ),
        ),
      ],
    );
  }
}

class UserGroup extends BaseSettingsGroup {
  const UserGroup({super.key, required super.settings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = useTextEditingController(text: value.username);
    final password = useTextEditingController(text: value.password);
    final userID = useTextEditingController(text: value.userUid.toString());
    final groupID = useTextEditingController(text: value.groupUid.toString());

    return AutofillGroup(
      child: Column(
        spacing: settingsSpacing,
        children: [
          SettingField(
            titleText: 'Username',
            helpText: 'Username for gouda UI',
            child: createUpdateButtons(
              username,
              autofillHints: [AutofillHints.username],
              onChanged: (p0) => value.username = p0,
            ),
          ),
          SettingField(
            titleText: 'Password',
            helpText: 'Password for gouda UI',
            child: createUpdateButtons(
              password,
              input: 'Password',
              autofillHints: [AutofillHints.password],
              onChanged: (p0) => value.password = p0,
            ),
          ),
          Row(
            children: [
              IntrinsicWidth(
                child: SettingField(
                  titleText: 'Linux UID',
                  helpText: 'User Permission when touching files',
                  child: createUpdateButtons(
                    userID,
                    onChanged: (p0) => value.userUid = Int64.parseInt(p0),
                  ),
                ),
              ),
              SizedBox(width: 20),
              IntrinsicWidth(
                child: SettingField(
                  titleText: 'Linux GID',
                  helpText: 'Group Permission when touching files',
                  child: createUpdateButtons(
                    groupID,
                    onChanged: (p0) => value.groupUid = Int64.parseInt(p0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TorrentGroup extends BaseSettingsGroup {
  const TorrentGroup({super.key, required super.settings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supportedClients = ref.watch(supportedClientsProvider).value ?? [];

    final torrentHost = useTextEditingController(text: value.torrentHost);
    final clientType = useTextEditingController(text: value.torrentName);
    final torrentPassword =
        useTextEditingController(text: value.torrentPassword);
    final torrentProtocol =
        useTextEditingController(text: value.torrentProtocol);
    final torrentUser = useTextEditingController(text: value.torrentUser);

    return AutofillGroup(
      child: Column(
        spacing: settingsSpacing,
        children: [
          SettingField(
            titleText: 'Torrent Host',
            helpText: 'Hostname or IP of the torrent client, make sure to set protocol accordingly',
            child: Row(
              spacing: 10,
              children: [
                createDropDown(
                  supportedClients,
                  clientType,
                  "Type",
                  onChanged: (String p0) => value.torrentName = p0,
                ),
                createDropDown(
                  supportedProtocols,
                  torrentProtocol,
                  "Protocol",
                  onChanged: (String p0) => value.torrentProtocol = p0,
                ),
                IntrinsicWidth(
                  child: createUpdateButtons(
                    torrentHost,
                    input: 'Host',
                    hintText: 'localhost:8080 or qbit.gg.com',
                    onChanged: (p0) => value.torrentHost = p0,
                  ),
                ),
              ],
            ),
          ),
          // if (value.torrentHost.isNotEmpty)
          //   Chip(
          //     label: Text('${value.torrentProtocol}://${value.torrentHost}'),
          //   ),
          SettingField(
            titleText: 'Torrent Username',
            helpText: 'Username for torrent client authentication',
            child: createUpdateButtons(
              torrentUser,
              autofillHints: [AutofillHints.username],
              onChanged: (p0) => value.torrentUser = p0,
            ),
          ),
          SettingField(
            titleText: 'Torrent Password',
            helpText: 'Password for torrent client authentication',
            child: createUpdateButtons(
              torrentPassword,
              editingController: () {},
              autofillHints: [AutofillHints.password],
              onChanged: (p0) => value.torrentPassword = p0,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingField extends HookWidget {
  const SettingField({
    required this.titleText,
    required this.child,
    this.helpText = '',
    super.key,
  });

  final String titleText;
  final Widget child;
  final String helpText;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: TextStyle(fontSize: 20),
        ),
        child,
        helpText.isNotEmpty ? Text(helpText) : SizedBox(),
      ],
    );
  }
}
