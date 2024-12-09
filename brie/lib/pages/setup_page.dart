import 'package:brie/api.dart';
import 'package:brie/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

import '../config.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostInput = useTextEditingController(
      text: api.apiKey.isEmpty ? html.window.location.toString() : api.apiKey,
    );
    final userName = useTextEditingController(text: kDebugMode ? 'admin' : '');
    final pass = useTextEditingController(text: kDebugMode ? 'admin' : '');

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Setup page', style: TextStyle(fontSize: 30)),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  controller: hostInput,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Gouda Url",
                  ),
                ),
              ),
              AutofillGroup(
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
              ElevatedButton(
                onPressed: () async {
                  try {
                    hostInput.text = hostInput.text.endsWith('/')
                        ? hostInput.text.substring(0, hostInput.text.length - 1)
                        : hostInput.text;

                    print(hostInput.text);

                    await prefs.setString('basepath', hostInput.text);
                    api = GoudaApi(basePath: hostInput.text, apiKey: "");

                    if (!context.mounted) return;
                    await api.login(
                      context,
                      user: userName.text,
                      pass: pass.text,
                    );
                  } catch (e) {
                    print(e);
                    if (!context.mounted) return;

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            Text('An error occured'),
                            Text(e.toString())
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkUrlAndLogin(String host, String user, String pass) async {}
}
