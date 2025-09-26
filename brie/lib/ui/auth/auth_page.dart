import 'dart:io';

import 'package:brie/clients/auth_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/config.dart';
import 'package:brie/gen/auth/v1/auth.pb.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:brie/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    final baseUrl = kDebugMode
        ? (kIsWeb || !Platform.isAndroid)
        ? 'http://localhost:9862'
        : 'http://10.0.2.2:9862'
        : '';

    final baseurl = useTextEditingController(
      text: baseUrl,
    );

    final user = useTextEditingController(
      text: kDebugMode ? 'admin' : '',
    );
    final pass = useTextEditingController(text: kDebugMode ? 'gouda' : '');

    const width = 300.0;

    return Scaffold(
      body: Center(
        child: Card(
          elevation: 30,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    Image.asset(
                      'assets/gouda.png',
                      scale: 10,
                    ),
                    const Text('Gouda', style: TextStyle(fontSize: 35)),
                  ],
                ),
                const SizedBox(height: 10),

                const SizedBox(width: width, child: Divider()),
                const Text('Login', style: TextStyle(fontSize: 30)),
                const SizedBox(height: 20),

                AutofillGroup(
                  child: SizedBox(
                    width: width,
                    child: Column(
                      children: [
                        if (!kIsWeb)
                          TextField(
                            autofillHints: const [AutofillHints.url],
                            controller: baseurl,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Server Address',
                            ),
                          ),
                        const SizedBox(height: 20),
                        TextField(
                          autofillHints: const [AutofillHints.username],
                          controller: user,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          autofillHints: const [AutofillHints.password],
                          controller: pass,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                if (isLoading.value)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () async {
                      isLoading.value = true;

                      await handleLogin(
                        context,
                        ref,
                        baseurl.text,
                        user.text,
                        pass.text,
                      );

                      isLoading.value = false;
                    },
                    child: const Text('Submit'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleLogin(BuildContext context,
      WidgetRef ref,
      String baseurl,
      String username,
      String password,) async {
    final localSettings = ref.read(
      appSettingsProvider.notifier,
    );
    await localSettings.updateBasePath(baseurl);

    final (session, err) = await runGrpcRequest(
          () =>
          ref
              .read(authApiProvider)
              .login(
            LoginRequest(
              username: username,
              password: password,
            ),
          ),
    );

    if (err.isNotEmpty) {
      if (!context.mounted) return;
      logger.e('Error logging in $err');
      await showErrorDialog(context, 'Error Logging In', err);
      return;
    }

    await localSettings.updateTokens(
      sessionToken: session!.session.sessionToken,
      refreshToken: session.session.refreshToken,
    );
  }
}
