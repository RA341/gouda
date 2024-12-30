import 'dart:convert';

import 'package:brie/api/api.dart';
import 'package:brie/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return AuthApi(client);
});

class AuthApi {
  final Dio apiClient;

  AuthApi(this.apiClient);

  Future<void> login({
    required String user,
    required String pass,
  }) async {
    final response = await apiClient.post(
      '/auth/login',
      data: jsonEncode({"username": user, "password": pass}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load users: ${response.statusCode}');
    }

    final tok = response.data['token'];
    await prefs.setString('apikey', tok);
  }

  Future<bool> testToken({required String token}) async {
    if (token == '') {
      return false;
    }

    final response = await apiClient.get(
      '/auth/test',
      options: Options(headers: {'Authorization': token}),
    );

    if (response.statusCode != 200) {
      print('Failed to verify token: ${response.statusCode}');
      return false;
    }

    return true;
  }
}
