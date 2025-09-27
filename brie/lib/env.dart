class Env {
  static String get baseUrl => const String.fromEnvironment('BASE_URL');

  static String get androidUrl =>
      const String.fromEnvironment('ANDROID_DEV_URL');

  static int get initialPage => const int.fromEnvironment("INITIAL_PAGE");
}
