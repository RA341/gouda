import 'dart:convert';

import 'package:brie/api/api.dart';
import 'package:brie/config.dart';
import 'package:dio/dio.dart';

final authApi = AuthApi();

class AuthApi {
  Future<void> login({
    required String user,
    required String pass,
  }) async {
    final response = await authClient.post(
      '/auth/login',
      data: jsonEncode({"username": user, "password": pass}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load users: ${response.statusCode}');
    }

    apiInst.apiKey = response.data['token'];
    await prefs.setString('apikey', apiInst.apiKey);

    // reinitialize clients with new api key
    apiInst.setupApiClients();
  }

  Future<bool> testToken({required String token}) async {
    if (token == '') {
      return false;
    }

    final response = await authClient.get(
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
