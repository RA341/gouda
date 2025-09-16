import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = useTextEditingController(
      text: kDebugMode ? 'admin' : '',
    );
    final pass = useTextEditingController(text: kDebugMode ? 'admin' : '');

    return Center(
      child: Card(
        elevation: 30,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisSize: MainAxisSize.min, // This is the key change
            children: [
              const Text('Login', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 20),
              AutofillGroup(
                child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextField(
                        autofillHints: const [AutofillHints.username],
                        controller: userName,
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
              ElevatedButton(
                onPressed: () async {
                  // Your existing onPressed logic here
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
