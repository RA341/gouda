import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/settings/v1/settings.pb.dart';
import 'package:brie/providers.dart';
import 'package:brie/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/settings_widgets.dart';

class SetupPage extends ConsumerStatefulWidget {
  const SetupPage({super.key});

  @override
  ConsumerState createState() => _SetupPageState();
}

class _SetupPageState extends ConsumerState<SetupPage> {
  final controller = PageController();
  late final settings = ref.watch(settingsProvider).value!;
  late final settingsModifier = ValueNotifier(settings);

  var curPage = 0;
  late final TextEditingController passwordVerify;

  @override
  void initState() {
    passwordVerify = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordVerify.dispose();
    super.dispose();
  }

  // widget and validateFunctions for that specific page
  // if function returns empty string it implies successful validation
  late final setupPages = <(Widget, Future<String> Function() validateFunc)>[
    (
      UserSetup(
        settingsNotifier: settingsModifier,
        passwordVerify: passwordVerify,
      ),
      () async {
        final user = settingsModifier.value.username;
        final pass = settingsModifier.value.password;

        if (user.isEmpty) {
          return "Username is empty";
        } else if (pass.isEmpty) {
          return "Password is empty";
        } else if (user == "admin" || pass == "admin") {
          return "default username or password use something else";
        } else if (passwordVerify.text != pass) {
          return "password mismatch";
        }
        return "";
      }
    ),
    (
      TorrentSetup(settingsNotifier: settingsModifier),
      () async {
        final err = await ref
            .read(settingsApiProvider)
            .testClient(settingsModifier.value.client);

        if (context.mounted && err.isNotEmpty) {
          return err;
        }
        return "";
      },
    ),
    (
      FinalizeSetup(settingsNotifier: settingsModifier),
      () async => "",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text("Setup Gouda", style: TextStyle(fontSize: 45)),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final allowed = await validatePage(curPage);
                  if (!allowed || curPage <= 0) {
                    return;
                  }
                  curPage--;
                  controller.jumpToPage(curPage);
                },
                child: Row(
                  children: [
                    Icon(Icons.navigate_before),
                    Text("prev", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(width: 100),
              ElevatedButton(
                onPressed: () async {
                  final allowed = await validatePage(curPage);
                  if (!allowed || curPage >= setupPages.length - 1) {
                    return;
                  }
                  curPage++;
                  controller.jumpToPage(curPage);
                },
                child: Row(
                  children: [
                    Text("next", style: TextStyle(fontSize: 18)),
                    Icon(Icons.navigate_next),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Center(
            child: SizedBox(
              width: 600,
              height: 500,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: controller,
                children: setupPages.map((e) => e.$1).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> validatePage(int page) async {
    final errReason = await setupPages[page].$2();
    if (errReason.isEmpty) {
      return true;
    }

    showErrorDialog(
      context,
      "Error validating",
      errReason,
    );
    return false;
  }
}

class TorrentSetup extends HookConsumerWidget {
  const TorrentSetup({required this.settingsNotifier, super.key});

  final ValueNotifier<Settings> settingsNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TorrentGroup(settings: settingsNotifier),
        SizedBox(height: 50),
        ElevatedButton(
          onPressed: () async {
            final err = await ref
                .read(settingsApiProvider)
                .testClient(settingsNotifier.value.client);
            if (!context.mounted) return;

            if (err.isNotEmpty) {
              showErrorDialog(
                context,
                "Error connecting to client",
                err,
              );
              return;
            }

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Successfully Connected"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: Text("Test connection"),
        )
      ],
    );
  }
}

class UserSetup extends ConsumerWidget {
  const UserSetup({
    required this.settingsNotifier,
    required this.passwordVerify,
    super.key,
  });

  final ValueNotifier<Settings> settingsNotifier;

  final TextEditingController passwordVerify;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        UserGroup(
          // clear out username and password and force user to update auth
          settings: settingsNotifier
            ..value.username = ""
            ..value.password = "",
          showFilePerm: false,
        ),
        SizedBox(height: settingsSpacing),
        SettingField(
          titleText: 'Password verify',
          child: createUpdateButtons(
            passwordVerify,
            autofillHints: [AutofillHints.password],
            obscureText: true,
          ),
        ),
      ],
    );
  }
}

class FinalizeSetup extends ConsumerWidget {
  const FinalizeSetup({
    required this.settingsNotifier,
    super.key,
  });

  final ValueNotifier<Settings> settingsNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        child: Text("Finish setup"),
        onPressed: () async {
          settingsNotifier.value.setupComplete = true;
          await ref.read(settingsApiProvider).update(settingsNotifier.value);
          ref.invalidate(settingsProvider);
        },
      ),
    );
  }
}
