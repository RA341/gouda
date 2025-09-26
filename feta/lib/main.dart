import 'package:feta/clients/auth_api.dart';
import 'package:feta/clients/settings_api.dart';
import 'package:feta/config.dart';
import 'package:feta/gen/auth/v1/auth.pb.dart';
import 'package:feta/ui/auth/auth_page.dart';
import 'package:feta/ui/layout/layout_page.dart';
import 'package:feta/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gouda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          secondary: Colors.yellow,
          brightness: Brightness.dark,
        ),
      ),
      home: const AppView(),
    );
  }
}

final sessionProvider = FutureProvider<bool>((ref) async {
  final localSettings = ref.watch(appSettingsProvider);
  final refreshToken = localSettings.refreshToken;
  final sessionToken = localSettings.sessionToken;

  if (sessionToken.isEmpty || refreshToken.isEmpty) {
    logger.w('Empty refresh:$refreshToken or session: $refreshToken tokens');
    return false;
  }

  final authApi = ref.watch(authApiProvider);

  // check for session if expired
  final (_, err) = await runGrpcRequest(
    () => authApi.verifySession(
      VerifySessionRequest(
        sessionToken: sessionToken,
      ),
    ),
  );
  if (err.isEmpty) {
    logger.i('Session verified, auth is complete');
    return true;
  }

  final (refreshedSession, err2) = await runGrpcRequest(
    () => authApi.refreshSession(
      RefreshSessionRequest(
        refreshToken: refreshToken,
      ),
    ),
  );
  if (err2.isNotEmpty) {
    logger.w('unable to refresh token: $err2');
    return false;
  }

  await ref
      .read(appSettingsProvider.notifier)
      .updateTokens(
        sessionToken: refreshedSession?.session.sessionToken ?? '',
        refreshToken: refreshedSession?.session.refreshToken ?? '',
      );

  return true;
});

class AppView extends ConsumerWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(sessionProvider);
    return authStatus.when(
      data: (data) {
        return data ? const LayoutView() : const LoginView();
      },
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(
            'Error occurred while verifying authentication: $error',
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text('Verifying Authentication'),
            ],
          ),
        ),
      ),
    );
  }
}
