import 'dart:async';
import 'dart:io';

import 'package:brie/clients/auth_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/config.dart';
import 'package:brie/env.dart';
import 'package:brie/gen/auth/v1/auth.pb.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:brie/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    final baseUrl = kDebugMode
        ? (kIsWeb || !Platform.isAndroid)
              ? Env.baseUrl
              // android emu has a different address
              : Env.androidUrl
        : Env.baseUrl;

    final baseurl = useTextEditingController(text: baseUrl);

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

                SizedBox(
                  width: width,
                  child: AutofillGroup(
                    child: Column(
                      spacing: 20,
                      children: [
                        if (kDebugMode || !kIsWeb)
                          TextField(
                            autofillHints: const [AutofillHints.url],
                            controller: baseurl,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Server Address',
                            ),
                          ),
                        TextField(
                          autofillHints: const [AutofillHints.username],
                          controller: user,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                        TextField(
                          autofillHints: const [AutofillHints.password],
                          controller: pass,
                          obscureText: true,
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

                      if (!context.mounted) return;
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

  Future<void> handleLogin(
    BuildContext context,
    WidgetRef ref,
    String initialUrl,
    String username,
    String password,
  ) async {
    final localSettings = ref.read(appSettingsProvider.notifier);

    if (!kIsWeb || kDebugMode) {
      if (initialUrl.isEmpty) {
        await showErrorDialog(
          context,
          'Empty Server Address',
          "Enter the server address",
        );
        return;
      }

      var baseurl = initialUrl;

      final (result, candidates) = await inferServerUrl(baseurl);
      if (result == null) {
        logger.i("urls $candidates");
        await showErrorDialog(
          context,
          'Unable to find Gouda server',
          "Check your address\nTried the following urls:\n${candidates.join("\n")}",
        );
        return;
      }

      baseurl = result;

      await localSettings.updateBasePath(baseurl);
    }

    final (session, err) = await runGrpcRequest(
      () => ref
          .read(authApiProvider)
          .login(
            LoginRequest(username: username, password: password),
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

/// infer the server URL based on the provided incomplete URL.
Future<(String?, List<String>)> inferServerUrl(String url) async {
  final candidates = generateUrlCandidates(url);

  for (final url in candidates) {
    if (await makeHeadRequest(url)) {
      return (url, <String>[]);
    }
  }

  return (null, candidates);
}

/// Makes a HEAD request to the specified URL
/// Returns the response headers and status code
/// Checks if a server exists by making a HEAD request
/// Returns true if the server responds (regardless of status code)
/// Returns false only if the server is unreachable (network error, timeout, etc.)
Future<bool> makeHeadRequest(String url) async {
  try {
    final uri = Uri.parse(url);
    await http.head(uri).timeout(const Duration(seconds: 1));
    return true; // Server responded, even if 404 or other status
  } catch (e) {
    // Only return false for actual connection errors
    if (e is SocketException ||
        e is http.ClientException ||
        e is TimeoutException) {
      return false;
    }
    // For other errors, still consider server as existing
    return true;
  }
}

/// generate URL candidates based on the input URL.
List<String> generateUrlCandidates(
  String initialInput, {
  String defaultHttpsPort = "9862",
  String defaultHttpPort = "9862",
}) {
  var input = initialInput;

  if (input.endsWith('/')) {
    input = input.substring(0, input.length - 1);
  }

  final result = parseUrl(input);

  if (result == null) return [];

  final (scheme, host, port, path) = result;

  final protoCandidates = <String>[];
  final supportedProtos = <String>['https:', 'http:'];

  if (scheme.isNotEmpty) {
    protoCandidates.add('$scheme//$host');
  } else {
    // The user did not declare a protocol
    for (final proto in supportedProtos) {
      protoCandidates.add('$proto//$host');
    }
  }

  final finalCandidates = <String>[];

  if (port.isNotEmpty) {
    for (final candidate in protoCandidates) {
      finalCandidates.add('$candidate:$port$path');
    }
  } else {
    // The port wasn't declared, so use default Jellyfin and protocol ports

    for (final finalUrl in protoCandidates) {
      // add url without port
      finalCandidates.add('$finalUrl$path');

      if (finalUrl.startsWith('https')) {
        finalCandidates.add('$finalUrl:$defaultHttpsPort$path');
      } else if (finalUrl.startsWith('http')) {
        finalCandidates.add('$finalUrl:$defaultHttpPort$path');
      }
    }
  }

  return finalCandidates;
}

/// parse url and separate it into its components
/// if you are wondering why we don't use Uri.tryParse() it cannot parse ipv4 or ipv6 addresses
(String, String, String, String)? parseUrl(String initialInput) {
  var input = initialInput;

  if (!(input.startsWith('http://') || input.startsWith('https://'))) {
    // fill in a empty protocol, so regex matches
    input = 'none://$input';
  }

  final rgx = RegExp(r'^(.*:)//([A-Za-z0-9\-.]+)(:[0-9]+)?(.*)$');
  final match = rgx.firstMatch(input);
  if (match != null) {
    var scheme = match.group(1) ?? ''; // add back the //
    final body = match.group(2) ?? '';
    final port = match.group(3)?.substring(1) ?? ''; // Remove leading colon
    final path = match.group(4) ?? '';

    if (scheme == 'none:') {
      scheme = '';
    }

    return (scheme, body, port, path);
  }

  return null;
}
