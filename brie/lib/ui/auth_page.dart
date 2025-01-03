import 'package:brie/clients/auth_api.dart';
import 'package:brie/grpc/api.dart';
import 'package:brie/ui/components/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = useTextEditingController(
        text: kDebugMode ? (dotenv.maybeGet('GOUDA_USERNAME') ?? 'admin') : '');
    final pass = useTextEditingController(
        text: kDebugMode ? (dotenv.maybeGet('GOUDA_PASS') ?? 'admin') : '');

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Login', style: TextStyle(fontSize: 30)),
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
                    await ref.read(authApiProvider).login(
                      user: userName.text,
                      pass: pass.text,
                    );
                    ref.invalidate(apiTokenProvider);
                  } catch (e) {
                    print(e);
                    if (!context.mounted) return;
                    showErrorDialog(
                      context,
                      'Unable to login',
                      'Incorrect username or password',
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
}
