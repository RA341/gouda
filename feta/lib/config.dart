import 'package:shared_preferences/shared_preferences.dart';

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
