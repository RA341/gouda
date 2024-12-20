import 'package:brie/api.dart';
import 'package:brie/pages/utils.dart';
import 'package:brie/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import '../config.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = useTextEditingController(text: kDebugMode ? 'admin' : '');
    final pass = useTextEditingController(text: kDebugMode ? 'admin' : '');

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Setup page', style: TextStyle(fontSize: 30)),
            SizedBox(height: 50),
            AutofillGroup(
              child: SizedBox(
                width: 200,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      autofillHints: [AutofillHints.username],
                      controller: userName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      autofillHints: [AutofillHints.password],
                      controller: pass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    if (!context.mounted) return;
                    await api.login(
                      context,
                      user: userName.text,
                      pass: pass.text,
                    );
                    ref.invalidate(checkTokenProvider);
                  } catch (e) {
                    print(e);
                    if (!context.mounted) return;
                    showErrorDialog(
                      context,
                      'Unable to login',
                      '',
                      e.toString(),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkUrlAndLogin(String host, String user, String pass) async {}
}
