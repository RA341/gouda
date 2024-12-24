import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

var apiInst = GoudaApi.instance;
var apiClient = apiInst.apiClient;
var authClient = apiInst.authClient;

class GoudaApi {
  String basePath = '';
  String apiBasePath = '';

  String apiKey = '';

  late Dio apiClient;
  late Dio authClient;

  static GoudaApi? _instance;

  GoudaApi._();

  // Get singleton instance
  static GoudaApi get instance {
    _instance ??= GoudaApi._();
    return _instance!;
  }

  // Initialize SharedPreferences
  Future<void> init({String apiKey = ''}) async {
    final (apiBasePath, basePath) = _makeBasePath();
    this.basePath = basePath;
    this.apiBasePath = apiBasePath;

    this.apiKey = apiKey;
    // separate this into a function because we will use this to
    // reinitialize the api clients when a user logs in and the api token is updated
    setupApiClients();
  }

  void setupApiClients() {
    authClient = _initApiClient(basePath);
    apiClient = _initApiClient(apiBasePath);

    if (kDebugMode) {
      apiClient.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));

      authClient.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  Dio _initApiClient(String basePath) {
    return Dio(
      BaseOptions(
        baseUrl: basePath,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': apiKey
        },
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        validateStatus: (status) {
          // don't throw errors on on non 200 codes
          return true;
        },
      ),
    );
  }

  (String, String) _makeBasePath() {
    basePath = kDebugMode
        ? ('https://gouda.dumbapps.org/' ?? 'http://localhost:9862')
        : html.window.location.toString();

    basePath = basePath.endsWith('/')
        ? basePath.substring(0, basePath.length - 1)
        : basePath;

    return ('$basePath/api', basePath);
  }
}
