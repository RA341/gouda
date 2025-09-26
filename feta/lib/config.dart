import 'package:feta/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const prefsRefreshTokenKey = 'RefreshToken';
const prefsSessionKey = 'SessionToken';
const prefsBaseUrl = 'BaseUrl';

class AppSettings {
  const AppSettings({
    required this.refreshToken,
    required this.sessionToken,
    required this.basePath,
  });

  final String refreshToken;
  final String sessionToken;
  final String basePath;

  AppSettings copyWith({
    String? refreshToken,
    String? sessionToken,
    String? basePath,
  }) {
    return AppSettings(
      refreshToken: refreshToken ?? this.refreshToken,
      sessionToken: sessionToken ?? this.sessionToken,
      basePath: basePath ?? this.basePath,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          refreshToken == other.refreshToken &&
          sessionToken == other.sessionToken &&
          basePath == other.basePath;

  @override
  int get hashCode =>
      refreshToken.hashCode ^ sessionToken.hashCode ^ basePath.hashCode;
}

class AppSettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    final refreshToken = prefs.getString(prefsRefreshTokenKey) ?? '';
    final sessionToken = prefs.getString(prefsSessionKey) ?? '';
    var basePath = prefs.getString(prefsBaseUrl) ?? '';

    basePath = basePath.endsWith('/')
        ? basePath.substring(0, basePath.length - 1)
        : basePath;

    logger.i('Base path is: $basePath');

    return AppSettings(
      refreshToken: refreshToken,
      sessionToken: sessionToken,
      basePath: basePath,
    );
  }

  Future<void> updateTokens({
    required String sessionToken,
    required String refreshToken,
  }) async {
    await prefs.setString(prefsSessionKey, sessionToken);
    await prefs.setString(prefsRefreshTokenKey, refreshToken);

    state = state.copyWith(
      refreshToken: refreshToken,
      sessionToken: sessionToken,
    );
  }

  Future<void> updateRefreshToken(String refreshToken) async {
    await prefs.setString(prefsRefreshTokenKey, refreshToken);
    state = state.copyWith(refreshToken: refreshToken);
  }

  Future<void> updateSessionToken(String sessionToken) async {
    await prefs.setString(prefsSessionKey, sessionToken);
    state = state.copyWith(sessionToken: sessionToken);
  }

  Future<void> updateBasePath(String baseUrl) async {
    final processedBasePath = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;

    await prefs.setString(prefsBaseUrl, baseUrl);
    logger.i('Base path is: $processedBasePath');

    state = state.copyWith(basePath: processedBasePath);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      prefs.remove(prefsRefreshTokenKey),
      prefs.remove(prefsSessionKey),
    ]);

    state = state.copyWith(
      refreshToken: '',
      sessionToken: '',
    );
  }

  Future<void> clearAll() async {
    await Future.wait([
      prefs.remove(prefsRefreshTokenKey),
      prefs.remove(prefsSessionKey),
      prefs.remove(prefsBaseUrl),
    ]);

    state = const AppSettings(
      refreshToken: '',
      sessionToken: '',
      basePath: '',
    );
  }
}

final appSettingsProvider = NotifierProvider<AppSettingsNotifier, AppSettings>(
  AppSettingsNotifier.new,
);

Future<void> updatePref(
  String key,
  String val,
  void Function() refRefresh,
) async {
  await prefs.setString(key, val);
  refRefresh();
}

final SharedPreferencesWithCache prefs =
    PreferencesService.instance.preferences;

const supportedProtocols = ['http', 'https'];

class PreferencesService {
  PreferencesService._();

  static PreferencesService? _instance;
  static SharedPreferencesWithCache? _preferences;

  SharedPreferencesWithCache get preferences {
    if (_preferences == null) {
      throw Exception('PreferencesService not initialized. Call init() first.');
    }
    return _preferences!;
  }

  static PreferencesService get instance {
    _instance ??= PreferencesService._();
    return _instance!;
  }

  // Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }
}
