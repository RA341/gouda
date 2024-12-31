import 'package:brie/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

final apiTokenProvider = Provider<String>((ref) {
  return prefs.getString('apikey') ?? '';
});

final basePathProvider = Provider<String>((ref) {
  // setup for future feature to modify base path from within the client
  final basePath = prefs.getString('basePath');

  final finalPath = basePath ??
      (kDebugMode
          ? (dotenv.maybeGet('PROD_URL') ?? 'http://localhost:9862')
          : html.window.location.toString());

  print('Base path is: $finalPath');

  return "${finalPath.endsWith('/') ? finalPath.substring(0, finalPath.length - 1) : finalPath}/api";
});

final apiClientProvider = Provider<Dio>((ref) {
  final token = ref.watch(apiTokenProvider);
  final apiBasePath = ref.watch(basePathProvider);
  final client = setupApiClients(authToken: token, basePath: apiBasePath);

  ref.onDispose(() => client.close());

  return client;
});

Dio setupApiClients({required String authToken, required String basePath}) {
  final apiClient = _initApiClient(basePath: basePath, authToken: authToken);

  if (kDebugMode) {
    apiClient.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    apiClient.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  return apiClient;
}

Dio _initApiClient({required String basePath, required String authToken}) {
  return Dio(
    BaseOptions(
      baseUrl: basePath,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': authToken
      },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      validateStatus: (status) {
        // don't throw errors on on non 200 codes
        return true;
      },
    ),
  );
}
