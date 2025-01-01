import 'package:brie/api/settings_api.dart';
import 'package:brie/config.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/components/torrent_client.dart';
import 'package:brie/ui/components/user_auth.dart';
import 'package:brie/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SetupPage extends HookConsumerWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    // user auth
    final username = useTextEditingController();
    final password = useTextEditingController();

    // torrent settings
    final torrentClientType = useState(supportedClients.first);
    final torrentProtocol = useState(supportedProtocols.first);

    final torrentUrl = useTextEditingController();
    final torrentUsername = useTextEditingController();
    final torrentPassword = useTextEditingController();

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Setup gouda',
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(
              width: 900,
              child: Divider(height: 20, color: Colors.white60),
            ),
            SizedBox(height: 20),
            UserAuth(
              username: username,
              password: password,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 900,
              child: Divider(height: 20, color: Colors.white60),
            ),
            SizedBox(height: 20),
            TorrentClientInput(
              torrentClientType: torrentClientType,
              torrentProtocol: torrentProtocol,
              torrentUrl: torrentUrl,
              torrentUsername: torrentUsername,
              torrentPassword: torrentPassword,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading.value
                  ? null
                  : () async {
                      if (torrentUrl.text.isEmpty ||
                          torrentUsername.text.isEmpty ||
                          torrentPassword.text.isEmpty) {
                        showErrorDialog(
                          context,
                          'Empty fields',
                          'Please fill out every field and try again',
                          '',
                        );
                        return;
                      }

                      isLoading.value = true;
                      try {
                        final currSettings =
                            await ref.read(settingsProvider.future);

                        await ref
                            .read(settingsApiProvider)
                            .update(currSettings.copyWith(
                              username: username.text,
                              password: password.text,
                              torrentName: torrentClientType.value,
                              torrentHost: torrentUrl.text,
                              torrentProtocol: torrentProtocol.value,
                              torrentUser: torrentUsername.text,
                              torrentPassword: torrentPassword.text,
                            ));

                        ref.invalidate(settingsProvider);
                      } catch (e) {
                        if (!context.mounted) return;
                        showErrorDialog(
                          context,
                          'Unable to update torrent settings',
                          'Check your torrent client details',
                          e.toString(),
                        );
                      }
                      isLoading.value = false;
                    },
              child: isLoading.value
                  ? CircularProgressIndicator()
                  : Text(
                      'Save',
                      style: TextStyle(fontSize: 25),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
