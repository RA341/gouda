import 'package:shared_preferences/shared_preferences.dart';

final prefs = PreferencesService.instance.preferences;

class PreferencesService {
  static PreferencesService? _instance;
  static SharedPreferencesWithCache? _preferences;

  // Private constructor
  PreferencesService._();

  // Getter for the SharedPreferences instance
  SharedPreferencesWithCache get preferences {
    if (_preferences == null) {
      throw Exception('PreferencesService not initialized. Call init() first.');
    }
    return _preferences!;
  }

  // Get singleton instance
  static PreferencesService get instance {
    _instance ??= PreferencesService._();
    return _instance!;
  }

  // Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
  }
}
